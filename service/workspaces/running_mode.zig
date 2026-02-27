pub const RunningMode = enum {
    auto_stop,
    always_on,
    manual,

    pub const json_field_names = .{
        .auto_stop = "AUTO_STOP",
        .always_on = "ALWAYS_ON",
        .manual = "MANUAL",
    };
};
