pub const AuditFindingSeverity = enum {
    critical,
    high,
    medium,
    low,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .high = "HIGH",
        .medium = "MEDIUM",
        .low = "LOW",
    };
};
