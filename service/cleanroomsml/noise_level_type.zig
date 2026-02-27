pub const NoiseLevelType = enum {
    high,
    medium,
    low,
    none,

    pub const json_field_names = .{
        .high = "HIGH",
        .medium = "MEDIUM",
        .low = "LOW",
        .none = "NONE",
    };
};
