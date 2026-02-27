pub const DocumentAttributeBoostingLevel = enum {
    none,
    low,
    medium,
    high,
    very_high,
    one,
    two,

    pub const json_field_names = .{
        .none = "NONE",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .very_high = "VERY_HIGH",
        .one = "ONE",
        .two = "TWO",
    };
};
