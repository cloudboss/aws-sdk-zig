pub const ProfilerType = enum {
    shs,
    tezui,
    yts,

    pub const json_field_names = .{
        .shs = "SHS",
        .tezui = "TEZUI",
        .yts = "YTS",
    };
};
