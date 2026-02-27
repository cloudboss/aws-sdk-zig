pub const HLSPlaybackMode = enum {
    live,
    live_replay,
    on_demand,

    pub const json_field_names = .{
        .live = "LIVE",
        .live_replay = "LIVE_REPLAY",
        .on_demand = "ON_DEMAND",
    };
};
