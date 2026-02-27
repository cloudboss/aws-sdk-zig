const aws = @import("aws");

const ConfigurationSummary = @import("configuration_summary.zig").ConfigurationSummary;
const TelemetryPipelineStatus = @import("telemetry_pipeline_status.zig").TelemetryPipelineStatus;

/// Contains summary information about a telemetry pipeline for listing
/// operations.
pub const TelemetryPipelineSummary = struct {
    /// The Amazon Resource Name (ARN) of the telemetry pipeline.
    arn: ?[]const u8,

    /// A summary of the pipeline configuration components.
    configuration_summary: ?ConfigurationSummary,

    /// The timestamp when the telemetry pipeline was created.
    created_time_stamp: ?i64,

    /// The timestamp when the telemetry pipeline was last updated.
    last_update_time_stamp: ?i64,

    /// The name of the telemetry pipeline.
    name: ?[]const u8,

    /// The current status of the telemetry pipeline.
    status: ?TelemetryPipelineStatus,

    /// The key-value pairs associated with the telemetry pipeline resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .configuration_summary = "ConfigurationSummary",
        .created_time_stamp = "CreatedTimeStamp",
        .last_update_time_stamp = "LastUpdateTimeStamp",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
    };
};
