pub const AuditFrequency = enum {
    daily,
    weekly,
    biweekly,
    monthly,

    pub const json_field_names = .{
        .daily = "DAILY",
        .weekly = "WEEKLY",
        .biweekly = "BIWEEKLY",
        .monthly = "MONTHLY",
    };
};
