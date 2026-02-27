pub const TestRisk = enum {
    small,
    medium,
    high,

    pub const json_field_names = .{
        .small = "SMALL",
        .medium = "MEDIUM",
        .high = "HIGH",
    };
};
