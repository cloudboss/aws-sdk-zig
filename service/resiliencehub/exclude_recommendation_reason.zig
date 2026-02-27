pub const ExcludeRecommendationReason = enum {
    already_implemented,
    not_relevant,
    complexity_of_implementation,

    pub const json_field_names = .{
        .already_implemented = "ALREADY_IMPLEMENTED",
        .not_relevant = "NOT_RELEVANT",
        .complexity_of_implementation = "COMPLEXITY_OF_IMPLEMENTATION",
    };
};
