pub const IsolineOptimizationObjective = enum {
    accurate_calculation,
    balanced_calculation,
    fast_calculation,

    pub const json_field_names = .{
        .accurate_calculation = "ACCURATE_CALCULATION",
        .balanced_calculation = "BALANCED_CALCULATION",
        .fast_calculation = "FAST_CALCULATION",
    };
};
