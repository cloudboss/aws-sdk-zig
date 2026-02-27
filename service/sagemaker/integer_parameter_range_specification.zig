/// Defines the possible values for an integer hyperparameter.
pub const IntegerParameterRangeSpecification = struct {
    /// The maximum integer value allowed.
    max_value: []const u8,

    /// The minimum integer value allowed.
    min_value: []const u8,

    pub const json_field_names = .{
        .max_value = "MaxValue",
        .min_value = "MinValue",
    };
};
