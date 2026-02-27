const LiveConnectorSinkConfiguration = @import("live_connector_sink_configuration.zig").LiveConnectorSinkConfiguration;
const LiveConnectorSourceConfiguration = @import("live_connector_source_configuration.zig").LiveConnectorSourceConfiguration;
const MediaPipelineStatus = @import("media_pipeline_status.zig").MediaPipelineStatus;

/// The connector pipeline.
pub const MediaLiveConnectorPipeline = struct {
    /// The time at which the connector pipeline was created.
    created_timestamp: ?i64,

    /// The connector pipeline's ARN.
    media_pipeline_arn: ?[]const u8,

    /// The connector pipeline's ID.
    media_pipeline_id: ?[]const u8,

    /// The connector pipeline's data sinks.
    sinks: ?[]const LiveConnectorSinkConfiguration,

    /// The connector pipeline's data sources.
    sources: ?[]const LiveConnectorSourceConfiguration,

    /// The connector pipeline's status.
    status: ?MediaPipelineStatus,

    /// The time at which the connector pipeline was last updated.
    updated_timestamp: ?i64,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .media_pipeline_arn = "MediaPipelineArn",
        .media_pipeline_id = "MediaPipelineId",
        .sinks = "Sinks",
        .sources = "Sources",
        .status = "Status",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
