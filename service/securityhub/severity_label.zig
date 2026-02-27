pub const SeverityLabel = enum {
    informational,
    low,
    medium,
    high,
    critical,

    pub const json_field_names = .{
        .informational = "INFORMATIONAL",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .critical = "CRITICAL",
    };
};
