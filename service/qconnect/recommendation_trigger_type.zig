pub const RecommendationTriggerType = enum {
    query,
    generative,

    pub const json_field_names = .{
        .query = "QUERY",
        .generative = "GENERATIVE",
    };
};
