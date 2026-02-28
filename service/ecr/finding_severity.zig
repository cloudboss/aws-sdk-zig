pub const FindingSeverity = enum {
    informational,
    low,
    medium,
    high,
    critical,
    @"undefined",

    pub const json_field_names = .{
        .informational = "INFORMATIONAL",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .critical = "CRITICAL",
        .@"undefined" = "UNDEFINED",
    };
};
