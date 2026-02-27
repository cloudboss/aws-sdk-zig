pub const RelevanceLevel = enum {
    high,
    medium,
    low,

    pub const json_field_names = .{
        .high = "HIGH",
        .medium = "MEDIUM",
        .low = "LOW",
    };
};
