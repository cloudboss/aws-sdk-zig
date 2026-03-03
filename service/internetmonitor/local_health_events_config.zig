const LocalHealthEventsConfigStatus = @import("local_health_events_config_status.zig").LocalHealthEventsConfigStatus;

/// A complex type with the configuration information that determines the
/// threshold and other conditions for when Internet Monitor creates a health
/// event
/// for a local performance or availability issue, when scores cross a threshold
/// for one or more city-networks.
///
/// Defines the percentages, for performance scores or availability scores, that
/// are the local thresholds
/// for when Amazon CloudWatch Internet Monitor creates a health event. Also
/// defines whether a local threshold is enabled or disabled, and the minimum
/// percentage
/// of overall traffic that must be impacted by an issue before Internet Monitor
/// creates an event when a threshold is crossed for a local health score.
///
/// If you don't set a local health event threshold, the default value is 60%.
///
/// For more information, see [
/// Change health event
/// thresholds](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-overview.html#IMUpdateThresholdFromOverview) in the Internet Monitor section of the *CloudWatch User Guide*.
pub const LocalHealthEventsConfig = struct {
    /// The health event threshold percentage set for a local health score.
    health_score_threshold: f64 = 0,

    /// The minimum percentage of overall traffic for an application that must be
    /// impacted by an issue before Internet Monitor creates an event when a
    /// threshold is crossed for a local health score.
    ///
    /// If you don't set a minimum traffic impact threshold, the default value is
    /// 0.1%.
    min_traffic_impact: f64 = 0,

    /// The status of whether Internet Monitor creates a health event based on a
    /// threshold percentage set for a local health score. The status can be
    /// `ENABLED`
    /// or `DISABLED`.
    status: ?LocalHealthEventsConfigStatus = null,

    pub const json_field_names = .{
        .health_score_threshold = "HealthScoreThreshold",
        .min_traffic_impact = "MinTrafficImpact",
        .status = "Status",
    };
};
