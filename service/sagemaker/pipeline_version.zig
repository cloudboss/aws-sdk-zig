const UserContext = @import("user_context.zig").UserContext;
const PipelineExecutionStatus = @import("pipeline_execution_status.zig").PipelineExecutionStatus;

/// The version of the pipeline.
pub const PipelineVersion = struct {
    created_by: ?UserContext,

    /// The creation time of the pipeline version.
    creation_time: ?i64,

    /// The Amazon Resource Name (ARN) of the most recent pipeline execution created
    /// from this pipeline version.
    last_executed_pipeline_execution_arn: ?[]const u8,

    /// The display name of the most recent pipeline execution created from this
    /// pipeline version.
    last_executed_pipeline_execution_display_name: ?[]const u8,

    /// The status of the most recent pipeline execution created from this pipeline
    /// version.
    last_executed_pipeline_execution_status: ?PipelineExecutionStatus,

    last_modified_by: ?UserContext,

    /// The time when the pipeline version was last modified.
    last_modified_time: ?i64,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_arn: ?[]const u8,

    /// The description of the pipeline version.
    pipeline_version_description: ?[]const u8,

    /// The display name of the pipeline version.
    pipeline_version_display_name: ?[]const u8,

    /// The ID of the pipeline version.
    pipeline_version_id: ?i64,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_executed_pipeline_execution_arn = "LastExecutedPipelineExecutionArn",
        .last_executed_pipeline_execution_display_name = "LastExecutedPipelineExecutionDisplayName",
        .last_executed_pipeline_execution_status = "LastExecutedPipelineExecutionStatus",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .pipeline_arn = "PipelineArn",
        .pipeline_version_description = "PipelineVersionDescription",
        .pipeline_version_display_name = "PipelineVersionDisplayName",
        .pipeline_version_id = "PipelineVersionId",
    };
};
