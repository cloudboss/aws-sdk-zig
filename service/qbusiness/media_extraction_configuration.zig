const AudioExtractionConfiguration = @import("audio_extraction_configuration.zig").AudioExtractionConfiguration;
const ImageExtractionConfiguration = @import("image_extraction_configuration.zig").ImageExtractionConfiguration;
const VideoExtractionConfiguration = @import("video_extraction_configuration.zig").VideoExtractionConfiguration;

/// The configuration for extracting information from media in documents.
pub const MediaExtractionConfiguration = struct {
    /// Configuration settings for extracting and processing audio content from
    /// media files.
    audio_extraction_configuration: ?AudioExtractionConfiguration,

    /// The configuration for extracting semantic meaning from images in documents.
    /// For more information, see [Extracting semantic meaning from images and
    /// visuals](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/extracting-meaning-from-images.html).
    image_extraction_configuration: ?ImageExtractionConfiguration,

    /// Configuration settings for extracting and processing video content from
    /// media files.
    video_extraction_configuration: ?VideoExtractionConfiguration,

    pub const json_field_names = .{
        .audio_extraction_configuration = "audioExtractionConfiguration",
        .image_extraction_configuration = "imageExtractionConfiguration",
        .video_extraction_configuration = "videoExtractionConfiguration",
    };
};
