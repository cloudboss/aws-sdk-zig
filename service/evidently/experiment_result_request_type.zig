pub const ExperimentResultRequestType = enum {
    base_stat,
    treatment_effect,
    confidence_interval,
    p_value,

    pub const json_field_names = .{
        .base_stat = "BASE_STAT",
        .treatment_effect = "TREATMENT_EFFECT",
        .confidence_interval = "CONFIDENCE_INTERVAL",
        .p_value = "P_VALUE",
    };
};
