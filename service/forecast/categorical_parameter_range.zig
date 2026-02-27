/// Specifies a categorical hyperparameter and it's range of tunable values.
/// This object is part of the ParameterRanges object.
pub const CategoricalParameterRange = struct {
    /// The name of the categorical hyperparameter to tune.
    name: []const u8,

    /// A list of the tunable categories for the hyperparameter.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
