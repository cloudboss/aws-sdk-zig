const AudioOverrideConfiguration = @import("audio_override_configuration.zig").AudioOverrideConfiguration;
const DocumentOverrideConfiguration = @import("document_override_configuration.zig").DocumentOverrideConfiguration;
const ImageOverrideConfiguration = @import("image_override_configuration.zig").ImageOverrideConfiguration;
const ModalityRoutingConfiguration = @import("modality_routing_configuration.zig").ModalityRoutingConfiguration;
const VideoOverrideConfiguration = @import("video_override_configuration.zig").VideoOverrideConfiguration;

/// Override configuration
pub const OverrideConfiguration = struct {
    audio: ?AudioOverrideConfiguration,

    document: ?DocumentOverrideConfiguration,

    image: ?ImageOverrideConfiguration,

    modality_routing: ?ModalityRoutingConfiguration,

    video: ?VideoOverrideConfiguration,

    pub const json_field_names = .{
        .audio = "audio",
        .document = "document",
        .image = "image",
        .modality_routing = "modalityRouting",
        .video = "video",
    };
};
