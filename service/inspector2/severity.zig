pub const Severity = enum {
    informational,
    low,
    medium,
    high,
    critical,
    untriaged,

    pub const json_field_names = .{
        .informational = "INFORMATIONAL",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .critical = "CRITICAL",
        .untriaged = "UNTRIAGED",
    };
};
