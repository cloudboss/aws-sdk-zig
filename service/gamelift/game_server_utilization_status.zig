pub const GameServerUtilizationStatus = enum {
    available,
    utilized,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .utilized = "UTILIZED",
    };
};
