pub const SeverityRating = enum {
    low,
    medium,
    high,
    critical,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .critical = "CRITICAL",
    };
};
