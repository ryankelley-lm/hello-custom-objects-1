nextflow.enable.dsl = 2

process STEPONE_PROCESS {
    input:
    tuple val(myname), path(r1), path(r2)

    output:
    tuple val("${myname}"), path("output1.txt"), path("output2.txt"), emit: paths

    script:
    """
    cat ${r1} ${r2} >> output1.txt
    cat ${r2} ${r1} >> output2.txt
    """
}


workflow STEPONE_WORKFLOW {
    take: workflowInput
    main:
        processResult = STEPONE_PROCESS(workflowInput).map {
            name, path1, path2 ->
                return new CustomObject(name, path1, path2) 
        }
    emit:
        processResult
}
