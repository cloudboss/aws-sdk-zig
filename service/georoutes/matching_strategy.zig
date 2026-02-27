pub const MatchingStrategy = enum {
    match_any,
    match_most_significant_road,

    pub const json_field_names = .{
        .match_any = "MATCH_ANY",
        .match_most_significant_road = "MATCH_MOST_SIGNIFICANT_ROAD",
    };
};
