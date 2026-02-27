/// The strategy hyperparameter tuning uses to find the best combination of
/// hyperparameters for your model.
pub const HyperParameterTuningJobStrategyType = enum {
    bayesian,
    random,
    hyperband,
    grid,

    pub const json_field_names = .{
        .bayesian = "BAYESIAN",
        .random = "RANDOM",
        .hyperband = "HYPERBAND",
        .grid = "GRID",
    };
};
