pub const ConfigRecommendationOptimizationType = enum {
    least_cost,
    least_change,
    best_az_recovery,
    least_errors,
    best_attainable,
    best_region_recovery,

    pub const json_field_names = .{
        .least_cost = "LEAST_COST",
        .least_change = "LEAST_CHANGE",
        .best_az_recovery = "BEST_AZ_RECOVERY",
        .least_errors = "LEAST_ERRORS",
        .best_attainable = "BEST_ATTAINABLE",
        .best_region_recovery = "BEST_REGION_RECOVERY",
    };
};
