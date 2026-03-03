const RealtimeMetricsSubscriptionConfig = @import("realtime_metrics_subscription_config.zig").RealtimeMetricsSubscriptionConfig;

/// A monitoring subscription. This structure contains information about whether
/// additional CloudWatch metrics are enabled for a given CloudFront
/// distribution.
pub const MonitoringSubscription = struct {
    /// A subscription configuration for additional CloudWatch metrics.
    realtime_metrics_subscription_config: ?RealtimeMetricsSubscriptionConfig = null,
};
