const LiveConnectorRTMPConfiguration = @import("live_connector_rtmp_configuration.zig").LiveConnectorRTMPConfiguration;
const LiveConnectorSinkType = @import("live_connector_sink_type.zig").LiveConnectorSinkType;

/// The media pipeline's sink configuration settings.
pub const LiveConnectorSinkConfiguration = struct {
    /// The sink configuration's RTMP configuration settings.
    rtmp_configuration: LiveConnectorRTMPConfiguration,

    /// The sink configuration's sink type.
    sink_type: LiveConnectorSinkType,

    pub const json_field_names = .{
        .rtmp_configuration = "RTMPConfiguration",
        .sink_type = "SinkType",
    };
};
