import groovy.transform.Immutable
import nextflow.io.ValueObject
import nextflow.util.KryoHelper

@ValueObject
@Immutable(copyWith=true, knownImmutables = ['path'])
class Metadata {
    static {
        // Register this class with the Kryo framework that serializes and deserializes objects
        // that pass through channles. This allows for caching when this object is used.
        KryoHelper.register(Metadata)
    }

    Path path
}