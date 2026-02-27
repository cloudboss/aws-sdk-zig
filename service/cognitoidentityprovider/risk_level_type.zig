pub const RiskLevelType = enum {
    low,
    medium,
    high,

    pub const json_field_names = .{
        .low = "Low",
        .medium = "Medium",
        .high = "High",
    };
};
