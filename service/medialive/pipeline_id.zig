/// Pipeline ID
pub const PipelineId = enum {
    pipeline_0,
    pipeline_1,

    pub const json_field_names = .{
        .pipeline_0 = "PIPELINE_0",
        .pipeline_1 = "PIPELINE_1",
    };
};
