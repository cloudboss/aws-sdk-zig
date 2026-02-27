const ScalingType = @import("scaling_type.zig").ScalingType;

/// Specifies an integer hyperparameter and it's range of tunable values.
/// This object is part of the ParameterRanges object.
pub const IntegerParameterRange = struct {
    /// The maximum tunable value of the hyperparameter.
    max_value: i32,

    /// The minimum tunable value of the hyperparameter.
    min_value: i32,

    /// The name of the hyperparameter to tune.
    name: []const u8,

    /// The scale that hyperparameter tuning uses to search the hyperparameter
    /// range.
    /// Valid values:
    ///
    /// **Auto**
    ///
    /// Amazon Forecast hyperparameter tuning chooses the best scale for the
    /// hyperparameter.
    ///
    /// **Linear**
    ///
    /// Hyperparameter tuning searches the values in the hyperparameter range by
    /// using a
    /// linear scale.
    ///
    /// **Logarithmic**
    ///
    /// Hyperparameter tuning searches the values in the hyperparameter range by
    /// using a
    /// logarithmic scale.
    ///
    /// Logarithmic scaling works only for ranges that have values greater than 0.
    ///
    /// **ReverseLogarithmic**
    ///
    /// Not supported for `IntegerParameterRange`.
    ///
    /// Reverse logarithmic scaling works only for ranges that are entirely within
    /// the
    /// range 0 <= x < 1.0.
    ///
    /// For information about choosing a hyperparameter scale, see
    /// [Hyperparameter
    /// Scaling](http://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-define-ranges.html#scaling-type).
    /// One of the following values:
    scaling_type: ?ScalingType,

    pub const json_field_names = .{
        .max_value = "MaxValue",
        .min_value = "MinValue",
        .name = "Name",
        .scaling_type = "ScalingType",
    };
};
