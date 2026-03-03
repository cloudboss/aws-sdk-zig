const aws = @import("aws");

const ConfigurationSummary = @import("configuration_summary.zig").ConfigurationSummary;
const TelemetryPipelineStatus = @import("telemetry_pipeline_status.zig").TelemetryPipelineStatus;

/// Contains summary information about a telemetry pipeline for listing
/// operations.
pub const TelemetryPipelineSummary = struct {
    /// The Amazon Resource Name (ARN) of the telemetry pipeline.
    arn: ?[]const u8 = null,

    /// A summary of the pipeline configuration components.
    configuration_summary: ?ConfigurationSummary = null,

    /// The timestamp when the telemetry pipeline was created.
    created_time_stamp: ?i64 = null,

    /// The timestamp when the telemetry pipeline was last updated.
    last_update_time_stamp: ?i64 = null,

    /// The name of the telemetry pipeline.
    name: ?[]const u8 = null,

    /// The current status of the telemetry pipeline.
    status: ?TelemetryPipelineStatus = null,

    /// The key-value pairs associated with the telemetry pipeline resource.
    tags: ?[]const aws.map.StringMapEntry = null,

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
