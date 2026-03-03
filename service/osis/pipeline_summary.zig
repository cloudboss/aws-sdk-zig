const PipelineDestination = @import("pipeline_destination.zig").PipelineDestination;
const PipelineStatus = @import("pipeline_status.zig").PipelineStatus;
const PipelineStatusReason = @import("pipeline_status_reason.zig").PipelineStatusReason;
const Tag = @import("tag.zig").Tag;

/// Summary information for an OpenSearch Ingestion pipeline.
pub const PipelineSummary = struct {
    /// The date and time when the pipeline was created.
    created_at: ?i64 = null,

    /// A list of destinations to which the pipeline writes data.
    destinations: ?[]const PipelineDestination = null,

    /// The date and time when the pipeline was last updated.
    last_updated_at: ?i64 = null,

    /// The maximum pipeline capacity, in Ingestion Compute Units (ICUs).
    max_units: ?i32 = null,

    /// The minimum pipeline capacity, in Ingestion Compute Units (ICUs).
    min_units: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_arn: ?[]const u8 = null,

    /// The name of the pipeline.
    pipeline_name: ?[]const u8 = null,

    /// The current status of the pipeline.
    status: ?PipelineStatus = null,

    status_reason: ?PipelineStatusReason = null,

    /// A list of tags associated with the given pipeline.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .destinations = "Destinations",
        .last_updated_at = "LastUpdatedAt",
        .max_units = "MaxUnits",
        .min_units = "MinUnits",
        .pipeline_arn = "PipelineArn",
        .pipeline_name = "PipelineName",
        .status = "Status",
        .status_reason = "StatusReason",
        .tags = "Tags",
    };
};
