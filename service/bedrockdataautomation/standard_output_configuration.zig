const AudioStandardOutputConfiguration = @import("audio_standard_output_configuration.zig").AudioStandardOutputConfiguration;
const DocumentStandardOutputConfiguration = @import("document_standard_output_configuration.zig").DocumentStandardOutputConfiguration;
const ImageStandardOutputConfiguration = @import("image_standard_output_configuration.zig").ImageStandardOutputConfiguration;
const VideoStandardOutputConfiguration = @import("video_standard_output_configuration.zig").VideoStandardOutputConfiguration;

/// Standard output configuration
pub const StandardOutputConfiguration = struct {
    audio: ?AudioStandardOutputConfiguration,

    document: ?DocumentStandardOutputConfiguration,

    image: ?ImageStandardOutputConfiguration,

    video: ?VideoStandardOutputConfiguration,

    pub const json_field_names = .{
        .audio = "audio",
        .document = "document",
        .image = "image",
        .video = "video",
    };
};
