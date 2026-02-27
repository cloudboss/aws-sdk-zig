const CompositedVideoArtifactsConfiguration = @import("composited_video_artifacts_configuration.zig").CompositedVideoArtifactsConfiguration;
const LiveConnectorMuxType = @import("live_connector_mux_type.zig").LiveConnectorMuxType;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;

/// The media pipeline's configuration object.
pub const ChimeSdkMeetingLiveConnectorConfiguration = struct {
    /// The configuration object's Chime SDK meeting ARN.
    arn: []const u8,

    /// The media pipeline's composited video.
    composited_video: ?CompositedVideoArtifactsConfiguration,

    /// The configuration object's multiplex type.
    mux_type: LiveConnectorMuxType,

    /// The source configuration settings of the media pipeline's configuration
    /// object.
    source_configuration: ?SourceConfiguration,

    pub const json_field_names = .{
        .arn = "Arn",
        .composited_video = "CompositedVideo",
        .mux_type = "MuxType",
        .source_configuration = "SourceConfiguration",
    };
};
