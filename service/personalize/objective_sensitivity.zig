pub const ObjectiveSensitivity = enum {
    low,
    medium,
    high,
    off,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .off = "OFF",
    };
};
