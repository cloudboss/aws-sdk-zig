pub const WorkflowEngine = enum {
    wdl,
    nextflow,
    cwl,
    wdl_lenient,

    pub const json_field_names = .{
        .wdl = "WDL",
        .nextflow = "NEXTFLOW",
        .cwl = "CWL",
        .wdl_lenient = "WDL_LENIENT",
    };
};
