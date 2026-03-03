const CategoricalHyperParameterRange = @import("categorical_hyper_parameter_range.zig").CategoricalHyperParameterRange;
const ContinuousHyperParameterRange = @import("continuous_hyper_parameter_range.zig").ContinuousHyperParameterRange;
const IntegerHyperParameterRange = @import("integer_hyper_parameter_range.zig").IntegerHyperParameterRange;

/// Specifies the hyperparameters and their ranges.
/// Hyperparameters can be categorical, continuous, or integer-valued.
pub const HyperParameterRanges = struct {
    /// The categorical hyperparameters and their ranges.
    categorical_hyper_parameter_ranges: ?[]const CategoricalHyperParameterRange = null,

    /// The continuous hyperparameters and their ranges.
    continuous_hyper_parameter_ranges: ?[]const ContinuousHyperParameterRange = null,

    /// The integer-valued hyperparameters and their ranges.
    integer_hyper_parameter_ranges: ?[]const IntegerHyperParameterRange = null,

    pub const json_field_names = .{
        .categorical_hyper_parameter_ranges = "categoricalHyperParameterRanges",
        .continuous_hyper_parameter_ranges = "continuousHyperParameterRanges",
        .integer_hyper_parameter_ranges = "integerHyperParameterRanges",
    };
};
