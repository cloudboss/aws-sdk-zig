pub const RankingInfluenceType = enum {
    popularity,
    freshness,

    pub const json_field_names = .{
        .popularity = "POPULARITY",
        .freshness = "FRESHNESS",
    };
};
