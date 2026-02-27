pub const LogLevel = enum {
    off,
    basic,
    transfer,

    pub const json_field_names = .{
        .off = "OFF",
        .basic = "BASIC",
        .transfer = "TRANSFER",
    };
};
