const Dimension = @import("dimension.zig").Dimension;

/// Designates the CloudWatch metric and statistic that provides the time series
/// the
/// anomaly detector uses as input. If you have enabled unified cross-account
/// observability,
/// and this account is a monitoring account, the metric can be in the same
/// account or a
/// source account.
pub const SingleMetricAnomalyDetector = struct {
    /// If the CloudWatch metric that provides the time series that the anomaly
    /// detector uses as input is in another account, specify that account ID here.
    /// If you omit
    /// this parameter, the current account is used.
    account_id: ?[]const u8,

    /// The metric dimensions to create the anomaly detection model for.
    dimensions: ?[]const Dimension,

    /// The name of the metric to create the anomaly detection model for.
    metric_name: ?[]const u8,

    /// The namespace of the metric to create the anomaly detection model for.
    namespace: ?[]const u8,

    /// The statistic to use for the metric and anomaly detection model.
    stat: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .dimensions = "Dimensions",
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .stat = "Stat",
    };
};
