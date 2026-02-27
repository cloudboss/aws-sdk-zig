pub const ActionCategory = enum {
    disaster_recovery,
    operating_system,
    license_and_subscription,
    validation,
    observability,
    refactoring,
    security,
    networking,
    configuration,
    backup,
    other,

    pub const json_field_names = .{
        .disaster_recovery = "DISASTER_RECOVERY",
        .operating_system = "OPERATING_SYSTEM",
        .license_and_subscription = "LICENSE_AND_SUBSCRIPTION",
        .validation = "VALIDATION",
        .observability = "OBSERVABILITY",
        .refactoring = "REFACTORING",
        .security = "SECURITY",
        .networking = "NETWORKING",
        .configuration = "CONFIGURATION",
        .backup = "BACKUP",
        .other = "OTHER",
    };
};
