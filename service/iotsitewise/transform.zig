const TransformProcessingConfig = @import("transform_processing_config.zig").TransformProcessingConfig;
const ExpressionVariable = @import("expression_variable.zig").ExpressionVariable;

/// Contains an asset transform property. A transform is a one-to-one mapping of
/// a property's
/// data points from one form to another. For example, you can use a transform
/// to convert a
/// Celsius data stream to Fahrenheit by applying the transformation expression
/// to each data point
/// of the Celsius stream. A transform can only have a data type of `DOUBLE` and
/// consume properties with data types of `INTEGER` or `DOUBLE`.
///
/// For more information, see
/// [Transforms](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-properties.html#transforms) in the *IoT SiteWise User Guide*.
pub const Transform = struct {
    /// The mathematical expression that defines the transformation function. You
    /// can specify up
    /// to 10 variables per expression. You can specify up to 10 functions per
    /// expression.
    ///
    /// For more information, see
    /// [Quotas](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/quotas.html) in the *IoT SiteWise User Guide*.
    expression: []const u8,

    /// The processing configuration for the given transform property.
    /// You can configure transforms to be kept at the edge or forwarded to the
    /// Amazon Web Services Cloud.
    /// You can also configure transforms to be computed at the edge or in the
    /// cloud.
    processing_config: ?TransformProcessingConfig,

    /// The list of variables used in the expression.
    variables: []const ExpressionVariable,

    pub const json_field_names = .{
        .expression = "expression",
        .processing_config = "processingConfig",
        .variables = "variables",
    };
};
