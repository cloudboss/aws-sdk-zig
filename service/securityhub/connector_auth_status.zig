pub const ConnectorAuthStatus = enum {
    active,
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};
