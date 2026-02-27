/// M3u8 Nielsen Id3 Behavior
pub const M3u8NielsenId3Behavior = enum {
    no_passthrough,
    passthrough,

    pub const json_field_names = .{
        .no_passthrough = "NO_PASSTHROUGH",
        .passthrough = "PASSTHROUGH",
    };
};
