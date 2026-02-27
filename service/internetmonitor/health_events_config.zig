const LocalHealthEventsConfig = @import("local_health_events_config.zig").LocalHealthEventsConfig;

/// A complex type with the configuration information that determines the
/// threshold and other conditions for when Internet Monitor creates a health
/// event
/// for an overall performance or availability issue, across an application's
/// geographies.
///
/// Defines the percentages, for overall performance scores and availability
/// scores for an application, that are the thresholds
/// for when Amazon CloudWatch Internet Monitor creates a health event. You can
/// override the defaults to set a custom threshold for overall performance or
/// availability scores,
/// or both.
///
/// You can also set thresholds for local health scores,, where Internet Monitor
/// creates a health event when scores cross a threshold for one or more
/// city-networks,
/// in addition to creating an event when an overall score crosses a threshold.
///
/// If you don't set a health event threshold, the default value is 95%.
///
/// For local thresholds, you also set a minimum percentage of overall traffic
/// that is impacted by an issue before Internet Monitor creates an event.
/// In addition, you can disable local thresholds, for performance scores,
/// availability scores, or both.
///
/// For more information, see [
/// Change health event
/// thresholds](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-overview.html#IMUpdateThresholdFromOverview) in the Internet Monitor section of the *CloudWatch User Guide*.
pub const HealthEventsConfig = struct {
    /// The configuration that determines the threshold and other conditions for
    /// when Internet Monitor creates a health event for a local availability issue.
    availability_local_health_events_config: ?LocalHealthEventsConfig,

    /// The health event threshold percentage set for availability scores.
    availability_score_threshold: f64 = 0,

    /// The configuration that determines the threshold and other conditions for
    /// when Internet Monitor creates a health event for a local performance issue.
    performance_local_health_events_config: ?LocalHealthEventsConfig,

    /// The health event threshold percentage set for performance scores.
    performance_score_threshold: f64 = 0,

    pub const json_field_names = .{
        .availability_local_health_events_config = "AvailabilityLocalHealthEventsConfig",
        .availability_score_threshold = "AvailabilityScoreThreshold",
        .performance_local_health_events_config = "PerformanceLocalHealthEventsConfig",
        .performance_score_threshold = "PerformanceScoreThreshold",
    };
};
