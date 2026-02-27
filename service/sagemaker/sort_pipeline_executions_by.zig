pub const SortPipelineExecutionsBy = enum {
    creation_time,
    pipeline_execution_arn,

    pub const json_field_names = .{
        .creation_time = "CREATION_TIME",
        .pipeline_execution_arn = "PIPELINE_EXECUTION_ARN",
    };
};
