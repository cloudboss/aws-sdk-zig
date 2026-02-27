pub const Severity = enum {
    critical,
    high,
    medium,
    low,
    info,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .high = "HIGH",
        .medium = "MEDIUM",
        .low = "LOW",
        .info = "INFO",
    };
};
