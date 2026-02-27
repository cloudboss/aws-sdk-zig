const AutoParameter = @import("auto_parameter.zig").AutoParameter;
const CategoricalParameterRange = @import("categorical_parameter_range.zig").CategoricalParameterRange;
const ContinuousParameterRange = @import("continuous_parameter_range.zig").ContinuousParameterRange;
const IntegerParameterRange = @import("integer_parameter_range.zig").IntegerParameterRange;

/// Specifies ranges of integer, continuous, and categorical hyperparameters
/// that a hyperparameter tuning job searches. The hyperparameter tuning job
/// launches training jobs with hyperparameter values within these ranges to
/// find the combination of values that result in the training job with the best
/// performance as measured by the objective metric of the hyperparameter tuning
/// job.
///
/// The maximum number of items specified for `Array Members` refers to the
/// maximum number of hyperparameters for each range and also the maximum for
/// the hyperparameter tuning job itself. That is, the sum of the number of
/// hyperparameters for all the ranges can't exceed the maximum number
/// specified.
pub const ParameterRanges = struct {
    /// A list containing hyperparameter names and example values to be used by
    /// Autotune to determine optimal ranges for your tuning job.
    auto_parameters: ?[]const AutoParameter,

    /// The array of
    /// [CategoricalParameterRange](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CategoricalParameterRange.html) objects that specify ranges of categorical hyperparameters that a hyperparameter tuning job searches.
    categorical_parameter_ranges: ?[]const CategoricalParameterRange,

    /// The array of
    /// [ContinuousParameterRange](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ContinuousParameterRange.html) objects that specify ranges of continuous hyperparameters that a hyperparameter tuning job searches.
    continuous_parameter_ranges: ?[]const ContinuousParameterRange,

    /// The array of
    /// [IntegerParameterRange](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_IntegerParameterRange.html) objects that specify ranges of integer hyperparameters that a hyperparameter tuning job searches.
    integer_parameter_ranges: ?[]const IntegerParameterRange,

    pub const json_field_names = .{
        .auto_parameters = "AutoParameters",
        .categorical_parameter_ranges = "CategoricalParameterRanges",
        .continuous_parameter_ranges = "ContinuousParameterRanges",
        .integer_parameter_ranges = "IntegerParameterRanges",
    };
};
