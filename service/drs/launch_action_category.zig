/// Launch action category.
pub const LaunchActionCategory = enum {
    monitoring,
    validation,
    configuration,
    security,
    other,

    pub const json_field_names = .{
        .monitoring = "MONITORING",
        .validation = "VALIDATION",
        .configuration = "CONFIGURATION",
        .security = "SECURITY",
        .other = "OTHER",
    };
};
