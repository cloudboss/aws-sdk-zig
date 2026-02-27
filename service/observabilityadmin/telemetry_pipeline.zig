const aws = @import("aws");

const TelemetryPipelineConfiguration = @import("telemetry_pipeline_configuration.zig").TelemetryPipelineConfiguration;
const TelemetryPipelineStatus = @import("telemetry_pipeline_status.zig").TelemetryPipelineStatus;
const TelemetryPipelineStatusReason = @import("telemetry_pipeline_status_reason.zig").TelemetryPipelineStatusReason;

/// Represents a complete telemetry pipeline resource with configuration,
/// status, and metadata for data processing and transformation.
pub const TelemetryPipeline = struct {
    /// The Amazon Resource Name (ARN) of the telemetry pipeline.
    arn: ?[]const u8,

    /// The configuration that defines how the telemetry pipeline processes data.
    configuration: ?TelemetryPipelineConfiguration,

    /// The timestamp when the telemetry pipeline was created.
    created_time_stamp: ?i64,

    /// The timestamp when the telemetry pipeline was last updated.
    last_update_time_stamp: ?i64,

    /// The name of the telemetry pipeline.
    name: ?[]const u8,

    /// The current status of the telemetry pipeline.
    status: ?TelemetryPipelineStatus,

    /// Additional information about the pipeline status, including reasons for
    /// failure states.
    status_reason: ?TelemetryPipelineStatusReason,

    /// The key-value pairs associated with the telemetry pipeline resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .configuration = "Configuration",
        .created_time_stamp = "CreatedTimeStamp",
        .last_update_time_stamp = "LastUpdateTimeStamp",
        .name = "Name",
        .status = "Status",
        .status_reason = "StatusReason",
        .tags = "Tags",
    };
};
