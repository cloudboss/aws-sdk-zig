pub const RetrievalResultContentType = enum {
    text,
    image,
    row,
    audio,
    video,

    pub const json_field_names = .{
        .text = "TEXT",
        .image = "IMAGE",
        .row = "ROW",
        .audio = "AUDIO",
        .video = "VIDEO",
    };
};
