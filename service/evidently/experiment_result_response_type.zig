pub const ExperimentResultResponseType = enum {
    mean,
    treatment_effect,
    confidence_interval_upperbound,
    confidence_interval_lowerbound,
    p_value,

    pub const json_field_names = .{
        .mean = "MEAN",
        .treatment_effect = "TREATMENT_EFFECT",
        .confidence_interval_upperbound = "CONFIDENCE_INTERVAL_UPPERBOUND",
        .confidence_interval_lowerbound = "CONFIDENCE_INTERVAL_LOWERBOUND",
        .p_value = "P_VALUE",
    };
};
