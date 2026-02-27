pub const HealthEventStatus = enum {
    active,
    resolved,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .resolved = "RESOLVED",
    };
};
