const DefaultCategoricalHyperParameterRange = @import("default_categorical_hyper_parameter_range.zig").DefaultCategoricalHyperParameterRange;
const DefaultContinuousHyperParameterRange = @import("default_continuous_hyper_parameter_range.zig").DefaultContinuousHyperParameterRange;
const DefaultIntegerHyperParameterRange = @import("default_integer_hyper_parameter_range.zig").DefaultIntegerHyperParameterRange;

/// Specifies the hyperparameters and their default ranges.
/// Hyperparameters can be categorical, continuous, or integer-valued.
pub const DefaultHyperParameterRanges = struct {
    /// The categorical hyperparameters and their default ranges.
    categorical_hyper_parameter_ranges: ?[]const DefaultCategoricalHyperParameterRange = null,

    /// The continuous hyperparameters and their default ranges.
    continuous_hyper_parameter_ranges: ?[]const DefaultContinuousHyperParameterRange = null,

    /// The integer-valued hyperparameters and their default ranges.
    integer_hyper_parameter_ranges: ?[]const DefaultIntegerHyperParameterRange = null,

    pub const json_field_names = .{
        .categorical_hyper_parameter_ranges = "categoricalHyperParameterRanges",
        .continuous_hyper_parameter_ranges = "continuousHyperParameterRanges",
        .integer_hyper_parameter_ranges = "integerHyperParameterRanges",
    };
};
