/// Enumeration for query score confidence.
pub const ScoreConfidence = enum {
    very_high,
    high,
    medium,
    low,
    not_available,

    pub const json_field_names = .{
        .very_high = "VERY_HIGH",
        .high = "HIGH",
        .medium = "MEDIUM",
        .low = "LOW",
        .not_available = "NOT_AVAILABLE",
    };
};
