/// The summary of the pipeline version.
pub const PipelineVersionSummary = struct {
    /// The creation time of the pipeline version.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the most recent pipeline execution created
    /// from this pipeline version.
    last_execution_pipeline_execution_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_arn: ?[]const u8 = null,

    /// The description of the pipeline version.
    pipeline_version_description: ?[]const u8 = null,

    /// The display name of the pipeline version.
    pipeline_version_display_name: ?[]const u8 = null,

    /// The ID of the pipeline version.
    pipeline_version_id: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_execution_pipeline_execution_arn = "LastExecutionPipelineExecutionArn",
        .pipeline_arn = "PipelineArn",
        .pipeline_version_description = "PipelineVersionDescription",
        .pipeline_version_display_name = "PipelineVersionDisplayName",
        .pipeline_version_id = "PipelineVersionId",
    };
};
