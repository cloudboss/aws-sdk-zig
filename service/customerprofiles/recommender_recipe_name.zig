pub const RecommenderRecipeName = enum {
    recommended_for_you,
    similar_items,
    frequently_paired_items,
    popular_items,
    trending_now,

    pub const json_field_names = .{
        .recommended_for_you = "RECOMMENDED_FOR_YOU",
        .similar_items = "SIMILAR_ITEMS",
        .frequently_paired_items = "FREQUENTLY_PAIRED_ITEMS",
        .popular_items = "POPULAR_ITEMS",
        .trending_now = "TRENDING_NOW",
    };
};
