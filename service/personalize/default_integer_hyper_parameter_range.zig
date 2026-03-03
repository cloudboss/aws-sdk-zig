/// Provides the name and default range of a integer-valued hyperparameter
/// and whether the hyperparameter is tunable. A tunable hyperparameter can
/// have its value determined during hyperparameter optimization (HPO).
pub const DefaultIntegerHyperParameterRange = struct {
    /// Indicates whether the hyperparameter is tunable.
    is_tunable: bool = false,

    /// The maximum allowable value for the hyperparameter.
    max_value: i32 = 0,

    /// The minimum allowable value for the hyperparameter.
    min_value: i32 = 0,

    /// The name of the hyperparameter.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_tunable = "isTunable",
        .max_value = "maxValue",
        .min_value = "minValue",
        .name = "name",
    };
};
