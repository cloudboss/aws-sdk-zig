const HyperParameterScalingType = @import("hyper_parameter_scaling_type.zig").HyperParameterScalingType;

/// A list of continuous hyperparameters to tune.
pub const ContinuousParameterRange = struct {
    /// The maximum value for the hyperparameter. The tuning job uses floating-point
    /// values between `MinValue` value and this value for tuning.
    max_value: []const u8,

    /// The minimum value for the hyperparameter. The tuning job uses floating-point
    /// values between this value and `MaxValue`for tuning.
    min_value: []const u8,

    /// The name of the continuous hyperparameter to tune.
    name: []const u8,

    /// The scale that hyperparameter tuning uses to search the hyperparameter
    /// range. For information about choosing a hyperparameter scale, see
    /// [Hyperparameter
    /// Scaling](https://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-define-ranges.html#scaling-type). One of the following values:
    ///
    /// **Auto**
    ///
    /// SageMaker hyperparameter tuning chooses the best scale for the
    /// hyperparameter.
    ///
    /// **Linear**
    ///
    /// Hyperparameter tuning searches the values in the hyperparameter range by
    /// using a linear scale.
    ///
    /// **Logarithmic**
    ///
    /// Hyperparameter tuning searches the values in the hyperparameter range by
    /// using a logarithmic scale.
    ///
    /// Logarithmic scaling works only for ranges that have only values greater than
    /// 0.
    ///
    /// **ReverseLogarithmic**
    ///
    /// Hyperparameter tuning searches the values in the hyperparameter range by
    /// using a reverse logarithmic scale.
    ///
    /// Reverse logarithmic scaling works only for ranges that are entirely within
    /// the range 0<=x<1.0.
    scaling_type: ?HyperParameterScalingType,

    pub const json_field_names = .{
        .max_value = "MaxValue",
        .min_value = "MinValue",
        .name = "Name",
        .scaling_type = "ScalingType",
    };
};
