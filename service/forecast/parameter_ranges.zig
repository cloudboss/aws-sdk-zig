const CategoricalParameterRange = @import("categorical_parameter_range.zig").CategoricalParameterRange;
const ContinuousParameterRange = @import("continuous_parameter_range.zig").ContinuousParameterRange;
const IntegerParameterRange = @import("integer_parameter_range.zig").IntegerParameterRange;

/// Specifies the categorical, continuous, and integer hyperparameters, and
/// their ranges of
/// tunable values. The range of tunable values determines which values that a
/// hyperparameter
/// tuning job can choose for the specified hyperparameter. This object is part
/// of the
/// HyperParameterTuningJobConfig object.
pub const ParameterRanges = struct {
    /// Specifies the tunable range for each categorical hyperparameter.
    categorical_parameter_ranges: ?[]const CategoricalParameterRange,

    /// Specifies the tunable range for each continuous hyperparameter.
    continuous_parameter_ranges: ?[]const ContinuousParameterRange,

    /// Specifies the tunable range for each integer hyperparameter.
    integer_parameter_ranges: ?[]const IntegerParameterRange,

    pub const json_field_names = .{
        .categorical_parameter_ranges = "CategoricalParameterRanges",
        .continuous_parameter_ranges = "ContinuousParameterRanges",
        .integer_parameter_ranges = "IntegerParameterRanges",
    };
};
