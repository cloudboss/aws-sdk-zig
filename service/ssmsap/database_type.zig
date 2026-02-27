pub const DatabaseType = enum {
    system,
    tenant,

    pub const json_field_names = .{
        .system = "SYSTEM",
        .tenant = "TENANT",
    };
};
