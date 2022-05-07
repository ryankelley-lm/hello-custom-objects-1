
nextflow.enable.dsl = 2

process STEPONE_PROCESS {
    input:
    path myinput

    output:
    tuple val("${myinput.name}"), path("output1.txt"), path("output2.txt"), emit: paths

    script:
    """
    cat ${myinput.r1} ${myinput.r2} >> output1.txt
    cat ${myinput.r2} ${myinput.r1} >> output2.txt
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
