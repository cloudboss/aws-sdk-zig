pub const GroupingRecommendationConfidenceLevel = enum {
    high,
    medium,

    pub const json_field_names = .{
        .high = "HIGH",
        .medium = "MEDIUM",
    };
};
