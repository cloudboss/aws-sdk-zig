pub const LambdaFunctionRecommendationFinding = enum {
    optimized,
    not_optimized,
    unavailable,

    pub const json_field_names = .{
        .optimized = "OPTIMIZED",
        .not_optimized = "NOT_OPTIMIZED",
        .unavailable = "UNAVAILABLE",
    };
};
