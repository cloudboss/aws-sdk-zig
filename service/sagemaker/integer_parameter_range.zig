const HyperParameterScalingType = @import("hyper_parameter_scaling_type.zig").HyperParameterScalingType;

/// For a hyperparameter of the integer type, specifies the range that a
/// hyperparameter tuning job searches.
pub const IntegerParameterRange = struct {
    /// The maximum value of the hyperparameter to search.
    max_value: []const u8,

    /// The minimum value of the hyperparameter to search.
    min_value: []const u8,

    /// The name of the hyperparameter to search.
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
    scaling_type: ?HyperParameterScalingType,

    pub const json_field_names = .{
        .max_value = "MaxValue",
        .min_value = "MinValue",
        .name = "Name",
        .scaling_type = "ScalingType",
    };
};
