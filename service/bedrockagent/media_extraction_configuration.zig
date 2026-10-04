const AudioExtractionConfiguration = @import("audio_extraction_configuration.zig").AudioExtractionConfiguration;
const ImageExtractionConfiguration = @import("image_extraction_configuration.zig").ImageExtractionConfiguration;
const VideoExtractionConfiguration = @import("video_extraction_configuration.zig").VideoExtractionConfiguration;

/// Configuration for media extraction settings.
pub const MediaExtractionConfiguration = struct {
    /// Configuration for audio extraction.
    audio_extraction_configuration: ?AudioExtractionConfiguration = null,

    /// Configuration for image extraction.
    image_extraction_configuration: ?ImageExtractionConfiguration = null,

    /// Configuration for video extraction.
    video_extraction_configuration: ?VideoExtractionConfiguration = null,

    pub const json_field_names = .{
        .audio_extraction_configuration = "audioExtractionConfiguration",
        .image_extraction_configuration = "imageExtractionConfiguration",
        .video_extraction_configuration = "videoExtractionConfiguration",
    };
};
