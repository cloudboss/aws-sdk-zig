pub const PoolsRunningMode = enum {
    auto_stop,
    always_on,

    pub const json_field_names = .{
        .auto_stop = "AUTO_STOP",
        .always_on = "ALWAYS_ON",
    };
};
