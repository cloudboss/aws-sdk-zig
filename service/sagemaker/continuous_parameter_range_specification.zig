/// Defines the possible values for a continuous hyperparameter.
pub const ContinuousParameterRangeSpecification = struct {
    /// The maximum floating-point value allowed.
    max_value: []const u8,

    /// The minimum floating-point value allowed.
    min_value: []const u8,

    pub const json_field_names = .{
        .max_value = "MaxValue",
        .min_value = "MinValue",
    };
};
