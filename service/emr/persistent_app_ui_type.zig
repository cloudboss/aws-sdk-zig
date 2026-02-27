pub const PersistentAppUIType = enum {
    shs,
    tez,
    yts,

    pub const json_field_names = .{
        .shs = "SHS",
        .tez = "TEZ",
        .yts = "YTS",
    };
};
