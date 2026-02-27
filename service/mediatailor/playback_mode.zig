pub const PlaybackMode = enum {
    loop,
    linear,

    pub const json_field_names = .{
        .loop = "LOOP",
        .linear = "LINEAR",
    };
};
