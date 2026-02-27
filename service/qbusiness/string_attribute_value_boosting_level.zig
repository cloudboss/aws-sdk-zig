pub const StringAttributeValueBoostingLevel = enum {
    low,
    medium,
    high,
    very_high,
    one,
    two,
    three,
    four,
    five,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .very_high = "VERY_HIGH",
        .one = "ONE",
        .two = "TWO",
        .three = "THREE",
        .four = "FOUR",
        .five = "FIVE",
    };
};
