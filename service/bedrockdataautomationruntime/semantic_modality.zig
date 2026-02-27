/// Semantic modality enum
pub const SemanticModality = enum {
    document,
    image,
    audio,
    video,

    pub const json_field_names = .{
        .document = "DOCUMENT",
        .image = "IMAGE",
        .audio = "AUDIO",
        .video = "VIDEO",
    };
};
