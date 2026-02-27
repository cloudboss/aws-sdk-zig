pub const SensitivityLevel = enum {
    low,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .high = "HIGH",
    };
};
