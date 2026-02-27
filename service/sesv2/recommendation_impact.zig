pub const RecommendationImpact = enum {
    low,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .high = "HIGH",
    };
};
