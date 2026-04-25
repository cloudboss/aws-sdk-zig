const AudioConfiguration = @import("audio_configuration.zig").AudioConfiguration;
const VideoConfiguration = @import("video_configuration.zig").VideoConfiguration;

/// Object specifying the ingest configuration set up by the broadcaster,
/// usually in an encoder.
///
/// **Note:** IngestConfiguration is deprecated in favor of IngestConfigurations
/// but retained to ensure backward compatibility. If multitrack is not enabled,
/// IngestConfiguration and IngestConfigurations contain the same data, namely
/// information about Track0 (the sole track). If multitrack is enabled,
/// IngestConfiguration contains data for only the first track (Track0) and
/// IngestConfigurations contains data for all tracks.
pub const IngestConfiguration = struct {
    /// Encoder settings for audio.
    audio: ?AudioConfiguration = null,

    /// Encoder settings for video.
    video: ?VideoConfiguration = null,

    pub const json_field_names = .{
        .audio = "audio",
        .video = "video",
    };
};
