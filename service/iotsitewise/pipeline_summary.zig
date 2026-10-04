const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Contains summary information about a pipeline.
pub const PipelineSummary = struct {
    /// The time the pipeline was created, in Unix epoch time.
    created_at: i64,

    /// The description of the pipeline.
    description: ?[]const u8 = null,

    /// The ARN of the pipeline.
    pipeline_arn: []const u8,

    /// The name of the pipeline.
    pipeline_name: []const u8,

    /// The current lifecycle status of the pipeline.
    status: ResourceStatus,

    /// The time the pipeline was last updated, in Unix epoch time.
    updated_at: i64,

    /// The version of the pipeline.
    version: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .pipeline_arn = "pipelineArn",
        .pipeline_name = "pipelineName",
        .status = "status",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
