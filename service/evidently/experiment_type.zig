pub const ExperimentType = enum {
    online_ab_experiment,

    pub const json_field_names = .{
        .online_ab_experiment = "ONLINE_AB_EXPERIMENT",
    };
};
