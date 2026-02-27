/// The logging configuration that's defined for pipeline execution.
pub const PipelineLoggingConfiguration = struct {
    /// The log group name that Image Builder uses for image creation. If not
    /// specified, the log group
    /// name defaults to `/aws/imagebuilder/image-name`.
    image_log_group_name: ?[]const u8,

    /// The log group name that Image Builder uses for the log output during
    /// creation of a new pipeline.
    /// If not specified, the pipeline log group name defaults to
    /// `/aws/imagebuilder/pipeline/pipeline-name`.
    pipeline_log_group_name: ?[]const u8,

    pub const json_field_names = .{
        .image_log_group_name = "imageLogGroupName",
        .pipeline_log_group_name = "pipelineLogGroupName",
    };
};
