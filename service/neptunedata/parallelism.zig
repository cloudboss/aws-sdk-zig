pub const Parallelism = enum {
    low,
    medium,
    high,
    oversubscribe,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .oversubscribe = "OVERSUBSCRIBE",
    };
};
