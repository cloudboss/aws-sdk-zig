/// Desired Modality types
pub const DesiredModality = enum {
    image,
    document,
    audio,
    video,

    pub const json_field_names = .{
        .image = "IMAGE",
        .document = "DOCUMENT",
        .audio = "AUDIO",
        .video = "VIDEO",
    };
};
