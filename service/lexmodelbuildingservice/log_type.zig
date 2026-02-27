pub const LogType = enum {
    audio,
    text,

    pub const json_field_names = .{
        .audio = "AUDIO",
        .text = "TEXT",
    };
};
