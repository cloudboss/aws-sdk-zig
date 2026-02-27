/// Av1 Look Ahead Rate Control
pub const Av1LookAheadRateControl = enum {
    high,
    low,
    medium,

    pub const json_field_names = .{
        .high = "HIGH",
        .low = "LOW",
        .medium = "MEDIUM",
    };
};
