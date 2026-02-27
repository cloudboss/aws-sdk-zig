pub const PlaylistType = enum {
    none,
    event,
    vod,

    pub const json_field_names = .{
        .none = "NONE",
        .event = "EVENT",
        .vod = "VOD",
    };
};
