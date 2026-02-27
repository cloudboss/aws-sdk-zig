pub const RecommendationJobType = enum {
    default,
    advanced,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .advanced = "ADVANCED",
    };
};
