pub const Mode = enum {
    off,
    behind_live_edge,
    after_live_edge,

    pub const json_field_names = .{
        .off = "OFF",
        .behind_live_edge = "BEHIND_LIVE_EDGE",
        .after_live_edge = "AFTER_LIVE_EDGE",
    };
};
