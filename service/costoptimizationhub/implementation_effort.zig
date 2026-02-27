pub const ImplementationEffort = enum {
    very_low,
    low,
    medium,
    high,
    very_high,

    pub const json_field_names = .{
        .very_low = "VERY_LOW",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .very_high = "VERY_HIGH",
    };
};
