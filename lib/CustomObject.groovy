import groovy.transform.Immutable
import nextflow.io.ValueObject
import nextflow.util.KryoHelper
import java.nio.file.Path
import nextflow.util.ArrayBag
import java.util.List
import nextflow.file.FileHolder
import java.util.Map

class CustomObject extends ArrayBag {
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
        this.target.add(name)
        this.target.add(r1)
        this.target.add(r2)
    }

    public String toString()
    {
        return this.name + " " + this.r1.toString() + " " + this.r2.toString()
    }
}