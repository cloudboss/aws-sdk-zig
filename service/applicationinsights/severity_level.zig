pub const SeverityLevel = enum {
    informative,
    low,
    medium,
    high,

    pub const json_field_names = .{
        .informative = "Informative",
        .low = "Low",
        .medium = "Medium",
        .high = "High",
    };
};
