pub const KxClusterType = enum {
    hdb,
    rdb,
    gateway,
    gp,
    tickerplant,

    pub const json_field_names = .{
        .hdb = "HDB",
        .rdb = "RDB",
        .gateway = "GATEWAY",
        .gp = "GP",
        .tickerplant = "TICKERPLANT",
    };
};
