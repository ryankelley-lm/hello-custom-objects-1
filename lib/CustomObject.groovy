import groovy.transform.Immutable
import nextflow.io.ValueObject
import nextflow.util.KryoHelper
import java.nio.file.Path
import nextflow.util.ArrayBag
import java.util.List
import nextflow.file.FileHolder
import java.util.Map
import nextflow.util.CustomFileAttributesProvider

class CustomObject extends ArrayBag implements CustomFileAttributesProvider {
    static {
        // Register this class with the Kryo framework that serializes and deserializes objects
        // that pass through channles. This allows for caching when this object is used.
        KryoHelper.register(CustomObject)
    }

    String name

    Path r1

    Path r2

    CustomObject(String name, Path r1, Path r2)
    {
        super()
        this.name = name
        this.r1 = r1
        this.r2 = r2
        this.target.add(r1)
        this.target.add(r2)
    }

    public Map GetCustomFileAttributes(List<FileHolder> items)
    {
        def result = [:]

        result["r1"] = items[0].stageName
        result["r2"] = items[1].stageName
        result["name"] = name

        return result
    }

    public String toString()
    {
        return this.name + " " + this.r1.toString() + " " + this.r2.toString()
    }
}