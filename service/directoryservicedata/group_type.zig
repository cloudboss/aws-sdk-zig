pub const GroupType = enum {
    distribution,
    security,

    pub const json_field_names = .{
        .distribution = "DISTRIBUTION",
        .security = "SECURITY",
    };
};
