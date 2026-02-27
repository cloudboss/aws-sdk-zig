/// M3u8 Scte35 Behavior
pub const M3u8Scte35Behavior = enum {
    no_passthrough,
    passthrough,

    pub const json_field_names = .{
        .no_passthrough = "NO_PASSTHROUGH",
        .passthrough = "PASSTHROUGH",
    };
};
