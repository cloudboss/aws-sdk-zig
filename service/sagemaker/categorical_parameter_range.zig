/// A list of categorical hyperparameters to tune.
pub const CategoricalParameterRange = struct {
    /// The name of the categorical hyperparameter to tune.
    name: []const u8,

    /// A list of the categories for the hyperparameter.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
