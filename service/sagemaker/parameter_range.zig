const CategoricalParameterRangeSpecification = @import("categorical_parameter_range_specification.zig").CategoricalParameterRangeSpecification;
const ContinuousParameterRangeSpecification = @import("continuous_parameter_range_specification.zig").ContinuousParameterRangeSpecification;
const IntegerParameterRangeSpecification = @import("integer_parameter_range_specification.zig").IntegerParameterRangeSpecification;

/// Defines the possible values for categorical, continuous, and integer
/// hyperparameters to be used by an algorithm.
pub const ParameterRange = struct {
    /// A `CategoricalParameterRangeSpecification` object that defines the possible
    /// values for a categorical hyperparameter.
    categorical_parameter_range_specification: ?CategoricalParameterRangeSpecification,

    /// A `ContinuousParameterRangeSpecification` object that defines the possible
    /// values for a continuous hyperparameter.
    continuous_parameter_range_specification: ?ContinuousParameterRangeSpecification,

    /// A `IntegerParameterRangeSpecification` object that defines the possible
    /// values for an integer hyperparameter.
    integer_parameter_range_specification: ?IntegerParameterRangeSpecification,

    pub const json_field_names = .{
        .categorical_parameter_range_specification = "CategoricalParameterRangeSpecification",
        .continuous_parameter_range_specification = "ContinuousParameterRangeSpecification",
        .integer_parameter_range_specification = "IntegerParameterRangeSpecification",
    };
};
