/// Provides the name and range of a categorical hyperparameter.
pub const CategoricalHyperParameterRange = struct {
    /// The name of the hyperparameter.
    name: ?[]const u8 = null,

    /// A list of the categories for the hyperparameter.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
