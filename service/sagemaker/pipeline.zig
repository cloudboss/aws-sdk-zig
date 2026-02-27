const UserContext = @import("user_context.zig").UserContext;
const ParallelismConfiguration = @import("parallelism_configuration.zig").ParallelismConfiguration;
const PipelineStatus = @import("pipeline_status.zig").PipelineStatus;
const Tag = @import("tag.zig").Tag;

/// A SageMaker Model Building Pipeline instance.
pub const Pipeline = struct {
    created_by: ?UserContext,

    /// The creation time of the pipeline.
    creation_time: ?i64,

    last_modified_by: ?UserContext,

    /// The time that the pipeline was last modified.
    last_modified_time: ?i64,

    /// The time when the pipeline was last run.
    last_run_time: ?i64,

    /// The parallelism configuration applied to the pipeline.
    parallelism_configuration: ?ParallelismConfiguration,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_arn: ?[]const u8,

    /// The description of the pipeline.
    pipeline_description: ?[]const u8,

    /// The display name of the pipeline.
    pipeline_display_name: ?[]const u8,

    /// The name of the pipeline.
    pipeline_name: ?[]const u8,

    /// The status of the pipeline.
    pipeline_status: ?PipelineStatus,

    /// The Amazon Resource Name (ARN) of the role that created the pipeline.
    role_arn: ?[]const u8,

    /// A list of tags that apply to the pipeline.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .last_run_time = "LastRunTime",
        .parallelism_configuration = "ParallelismConfiguration",
        .pipeline_arn = "PipelineArn",
        .pipeline_description = "PipelineDescription",
        .pipeline_display_name = "PipelineDisplayName",
        .pipeline_name = "PipelineName",
        .pipeline_status = "PipelineStatus",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};
