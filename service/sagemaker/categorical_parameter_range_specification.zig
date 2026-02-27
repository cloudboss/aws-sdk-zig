/// Defines the possible values for a categorical hyperparameter.
pub const CategoricalParameterRangeSpecification = struct {
    /// The allowed categories for the hyperparameter.
    values: []const []const u8,

    pub const json_field_names = .{
        .values = "Values",
    };
};
