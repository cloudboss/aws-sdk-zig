pub const FindingStatus = enum {
    active,
    archived,
    resolved,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .archived = "ARCHIVED",
        .resolved = "RESOLVED",
    };
};
