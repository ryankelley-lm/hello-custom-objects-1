#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

import sun.nio.fs.UnixPath
import java.nio.file.Path;
import java.nio.file.Paths;

include { STEPONE_WORKFLOW } from './modules/stepone/main.nf'

workflow {

    myFileChannel = Channel.fromPath( "*.txt" ).collect()

    myCustomChannel = myFileChannel.map {
        myPaths -> 
            return new CustomObject("custom_object_name", myPaths[0], myPaths[1])
    }.view()

    STEPONE_WORKFLOW(myCustomChannel).view()

}
