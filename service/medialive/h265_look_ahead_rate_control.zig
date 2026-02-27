/// H265 Look Ahead Rate Control
pub const H265LookAheadRateControl = enum {
    high,
    low,
    medium,

    pub const json_field_names = .{
        .high = "HIGH",
        .low = "LOW",
        .medium = "MEDIUM",
    };
};
