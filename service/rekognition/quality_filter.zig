pub const QualityFilter = enum {
    none,
    auto,
    low,
    medium,
    high,

    pub const json_field_names = .{
        .none = "NONE",
        .auto = "AUTO",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };
};
