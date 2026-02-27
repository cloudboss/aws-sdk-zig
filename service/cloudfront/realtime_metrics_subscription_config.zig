const RealtimeMetricsSubscriptionStatus = @import("realtime_metrics_subscription_status.zig").RealtimeMetricsSubscriptionStatus;

/// A subscription configuration for additional CloudWatch metrics.
pub const RealtimeMetricsSubscriptionConfig = struct {
    /// A flag that indicates whether additional CloudWatch metrics are enabled for
    /// a given CloudFront distribution.
    realtime_metrics_subscription_status: RealtimeMetricsSubscriptionStatus,
};
