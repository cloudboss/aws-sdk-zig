/// Provides the name and range of a continuous hyperparameter.
pub const ContinuousHyperParameterRange = struct {
    /// The maximum allowable value for the hyperparameter.
    max_value: f64 = 0,

    /// The minimum allowable value for the hyperparameter.
    min_value: f64 = 0,

    /// The name of the hyperparameter.
    name: ?[]const u8,

    pub const json_field_names = .{
        .max_value = "maxValue",
        .min_value = "minValue",
        .name = "name",
    };
};
