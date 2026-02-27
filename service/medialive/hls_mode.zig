/// Hls Mode
pub const HlsMode = enum {
    live,
    vod,

    pub const json_field_names = .{
        .live = "LIVE",
        .vod = "VOD",
    };
};
