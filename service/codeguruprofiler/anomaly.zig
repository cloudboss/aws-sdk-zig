const AnomalyInstance = @import("anomaly_instance.zig").AnomalyInstance;
const Metric = @import("metric.zig").Metric;

/// Details about an anomaly in a specific metric of application profile. The
/// anomaly is detected using
/// analysis of the metric data over a period of time.
pub const Anomaly = struct {
    /// A list of the instances of the detected anomalies during the requested
    /// period.
    instances: []const AnomalyInstance,

    /// Details about the metric that the analysis used when it detected the
    /// anomaly.
    /// The metric includes the name of the frame that was analyzed with the type
    /// and
    /// thread states used to derive the metric value for that frame.
    metric: Metric,

    /// The reason for which metric was flagged as anomalous.
    reason: []const u8,

    pub const json_field_names = .{
        .instances = "instances",
        .metric = "metric",
        .reason = "reason",
    };
};
