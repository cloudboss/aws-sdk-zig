const ChimeSdkMeetingLiveConnectorConfiguration = @import("chime_sdk_meeting_live_connector_configuration.zig").ChimeSdkMeetingLiveConnectorConfiguration;
const LiveConnectorSourceType = @import("live_connector_source_type.zig").LiveConnectorSourceType;

/// The data source configuration object of a streaming media pipeline.
pub const LiveConnectorSourceConfiguration = struct {
    /// The configuration settings of the connector pipeline.
    chime_sdk_meeting_live_connector_configuration: ChimeSdkMeetingLiveConnectorConfiguration,

    /// The source configuration's media source type.
    source_type: LiveConnectorSourceType,

    pub const json_field_names = .{
        .chime_sdk_meeting_live_connector_configuration = "ChimeSdkMeetingLiveConnectorConfiguration",
        .source_type = "SourceType",
    };
};
