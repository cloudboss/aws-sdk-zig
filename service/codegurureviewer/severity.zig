pub const Severity = enum {
    info,
    low,
    medium,
    high,
    critical,

    pub const json_field_names = .{
        .info = "INFO",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .critical = "CRITICAL",
    };
};
