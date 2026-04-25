const AudioConfiguration = @import("audio_configuration.zig").AudioConfiguration;
const VideoConfiguration = @import("video_configuration.zig").VideoConfiguration;

/// Object specifying the ingest configuration set up by the broadcaster,
/// usually in an encoder.
///
/// **Note:** Use IngestConfigurations instead of IngestConfiguration (which is
/// deprecated). If multitrack is not enabled, IngestConfiguration and
/// IngestConfigurations contain the same data, namely information about Track0
/// (the sole track). If multitrack is enabled, IngestConfiguration contains
/// data for only the first track (Track0) and IngestConfigurations contains
/// data for all tracks.
pub const IngestConfigurations = struct {
    /// Encoder settings for audio.
    audio_configurations: []const AudioConfiguration,

    /// Encoder settings for video
    video_configurations: []const VideoConfiguration,

    pub const json_field_names = .{
        .audio_configurations = "audioConfigurations",
        .video_configurations = "videoConfigurations",
    };
};
