pub const MigrationEffort = enum {
    very_low,
    low,
    medium,
    high,

    pub const json_field_names = .{
        .very_low = "VERY_LOW",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };
};
