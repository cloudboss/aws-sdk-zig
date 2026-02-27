pub const ConnectionType = enum {
    indirect,
    direct,

    pub const json_field_names = .{
        .indirect = "INDIRECT",
        .direct = "DIRECT",
    };
};
