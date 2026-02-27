pub const NotificationSeverityLevel = enum {
    none,
    all,
    high,

    pub const json_field_names = .{
        .none = "NONE",
        .all = "ALL",
        .high = "HIGH",
    };
};
