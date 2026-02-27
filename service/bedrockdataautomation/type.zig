/// Type
pub const Type = enum {
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
