pub const Severity = enum {
    critical,
    high,
    medium,
    low,
    none,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .high = "HIGH",
        .medium = "MEDIUM",
        .low = "LOW",
        .none = "NONE",
    };
};
