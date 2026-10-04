const AudioExtractionConfiguration = @import("audio_extraction_configuration.zig").AudioExtractionConfiguration;
const ImageExtractionConfiguration = @import("image_extraction_configuration.zig").ImageExtractionConfiguration;
const VideoExtractionConfiguration = @import("video_extraction_configuration.zig").VideoExtractionConfiguration;

/// The configuration for media extraction from knowledge base documents.
pub const MediaExtractionConfiguration = struct {
    /// The configuration for audio extraction.
    audio_extraction_configuration: ?AudioExtractionConfiguration = null,

    /// The configuration for image extraction.
    image_extraction_configuration: ?ImageExtractionConfiguration = null,

    /// The configuration for video extraction.
    video_extraction_configuration: ?VideoExtractionConfiguration = null,

    pub const json_field_names = .{
        .audio_extraction_configuration = "audioExtractionConfiguration",
        .image_extraction_configuration = "imageExtractionConfiguration",
        .video_extraction_configuration = "videoExtractionConfiguration",
    };
};
