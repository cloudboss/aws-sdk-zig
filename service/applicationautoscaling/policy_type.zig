pub const PolicyType = enum {
    step_scaling,
    target_tracking_scaling,
    predictive_scaling,

    pub const json_field_names = .{
        .step_scaling = "StepScaling",
        .target_tracking_scaling = "TargetTrackingScaling",
        .predictive_scaling = "PredictiveScaling",
    };
};
