/// A summary of a pipeline.
pub const PipelineSummary = struct {
    /// The creation time of the pipeline.
    creation_time: ?i64 = null,

    /// The last time that a pipeline execution began.
    last_execution_time: ?i64 = null,

    /// The time that the pipeline was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_arn: ?[]const u8 = null,

    /// The description of the pipeline.
    pipeline_description: ?[]const u8 = null,

    /// The display name of the pipeline.
    pipeline_display_name: ?[]const u8 = null,

    /// The name of the pipeline.
    pipeline_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that the pipeline used to execute.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_execution_time = "LastExecutionTime",
        .last_modified_time = "LastModifiedTime",
        .pipeline_arn = "PipelineArn",
        .pipeline_description = "PipelineDescription",
        .pipeline_display_name = "PipelineDisplayName",
        .pipeline_name = "PipelineName",
        .role_arn = "RoleArn",
    };
};
