pub const MediaStreamType = enum {
    audio,
    video,

    pub const json_field_names = .{
        .audio = "AUDIO",
        .video = "VIDEO",
    };
};
