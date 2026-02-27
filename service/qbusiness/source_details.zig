const AudioSourceDetails = @import("audio_source_details.zig").AudioSourceDetails;
const ImageSourceDetails = @import("image_source_details.zig").ImageSourceDetails;
const VideoSourceDetails = @import("video_source_details.zig").VideoSourceDetails;

/// Container for details about different types of media sources (image, audio,
/// or video).
pub const SourceDetails = union(enum) {
    /// Details specific to audio content within the source.
    audio_source_details: ?AudioSourceDetails,
    /// Details specific to image content within the source.
    image_source_details: ?ImageSourceDetails,
    /// Details specific to video content within the source.
    video_source_details: ?VideoSourceDetails,

    pub const json_field_names = .{
        .audio_source_details = "audioSourceDetails",
        .image_source_details = "imageSourceDetails",
        .video_source_details = "videoSourceDetails",
    };
};
