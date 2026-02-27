pub const Severity = enum {
    low,
    medium,
    high,
    informational,
    undefined,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .informational = "INFORMATIONAL",
        .undefined = "UNDEFINED",
    };
};
