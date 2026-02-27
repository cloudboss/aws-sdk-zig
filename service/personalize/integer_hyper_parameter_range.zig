/// Provides the name and range of an integer-valued hyperparameter.
pub const IntegerHyperParameterRange = struct {
    /// The maximum allowable value for the hyperparameter.
    max_value: i32 = 0,

    /// The minimum allowable value for the hyperparameter.
    min_value: i32 = 0,

    /// The name of the hyperparameter.
    name: ?[]const u8,

    pub const json_field_names = .{
        .max_value = "maxValue",
        .min_value = "minValue",
        .name = "name",
    };
};
