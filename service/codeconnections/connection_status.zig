pub const ConnectionStatus = enum {
    pending,
    available,
    @"error",

    pub const json_field_names = .{
        .pending = "PENDING",
        .available = "AVAILABLE",
        .@"error" = "ERROR",
    };
};
