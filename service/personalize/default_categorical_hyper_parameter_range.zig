/// Provides the name and default range of a categorical hyperparameter
/// and whether the hyperparameter is tunable. A tunable hyperparameter can
/// have its value determined during hyperparameter optimization (HPO).
pub const DefaultCategoricalHyperParameterRange = struct {
    /// Whether the hyperparameter is tunable.
    is_tunable: bool = false,

    /// The name of the hyperparameter.
    name: ?[]const u8,

    /// A list of the categories for the hyperparameter.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .is_tunable = "isTunable",
        .name = "name",
        .values = "values",
    };
};
