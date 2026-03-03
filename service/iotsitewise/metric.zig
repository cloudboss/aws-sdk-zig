const MetricProcessingConfig = @import("metric_processing_config.zig").MetricProcessingConfig;
const ExpressionVariable = @import("expression_variable.zig").ExpressionVariable;
const MetricWindow = @import("metric_window.zig").MetricWindow;

/// Contains an asset metric property. With metrics, you can calculate aggregate
/// functions,
/// such as an average, maximum, or minimum, as specified through an expression.
/// A metric maps
/// several values to a single value (such as a sum).
///
/// The maximum number of dependent/cascading variables used in any one metric
/// calculation is
/// 10. Therefore, a *root* metric can have
/// up to 10 cascading metrics in its computational dependency
/// tree. Additionally, a metric can only have a data type of `DOUBLE` and
/// consume
/// properties with data types of `INTEGER` or `DOUBLE`.
///
/// For more information, see
/// [Metrics](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-properties.html#metrics) in the *IoT SiteWise User Guide*.
pub const Metric = struct {
    /// The mathematical expression that defines the metric aggregation function.
    /// You can specify
    /// up to 10 variables per expression. You can specify up to 10 functions
    /// per expression.
    ///
    /// For more information, see
    /// [Quotas](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/quotas.html) in the *IoT SiteWise User Guide*.
    expression: []const u8 = "",

    /// The processing configuration for the given metric property.
    /// You can configure metrics to be computed at the edge or in the Amazon Web
    /// Services Cloud.
    /// By default, metrics are forwarded to the cloud.
    processing_config: ?MetricProcessingConfig = null,

    /// The list of variables used in the expression.
    variables: []const ExpressionVariable = &.{},

    /// The window (time interval) over which IoT SiteWise computes the metric's
    /// aggregation expression.
    /// IoT SiteWise computes one data point per `window`.
    window: MetricWindow,

    pub const json_field_names = .{
        .expression = "expression",
        .processing_config = "processingConfig",
        .variables = "variables",
        .window = "window",
    };
};
