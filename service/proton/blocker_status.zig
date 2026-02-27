pub const BlockerStatus = enum {
    active,
    resolved,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .resolved = "RESOLVED",
    };
};
