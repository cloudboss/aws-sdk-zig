const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const ContactProtocol = @import("contact_protocol.zig").ContactProtocol;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const MetricName = @import("metric_name.zig").MetricName;
const MonitoredResourceInfo = @import("monitored_resource_info.zig").MonitoredResourceInfo;
const AlarmState = @import("alarm_state.zig").AlarmState;
const ResourceType = @import("resource_type.zig").ResourceType;
const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;
const TreatMissingData = @import("treat_missing_data.zig").TreatMissingData;
const MetricUnit = @import("metric_unit.zig").MetricUnit;

/// Describes an alarm.
///
/// An alarm is a way to monitor your Lightsail resource metrics. For more
/// information, see
/// [Alarms in Amazon
/// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-alarms).
pub const Alarm = struct {
    /// The Amazon Resource Name (ARN) of the alarm.
    arn: ?[]const u8 = null,

    /// The arithmetic operation used when comparing the specified statistic and
    /// threshold.
    comparison_operator: ?ComparisonOperator = null,

    /// The contact protocols for the alarm, such as `Email`, `SMS` (text
    /// messaging), or both.
    contact_protocols: ?[]const ContactProtocol = null,

    /// The timestamp when the alarm was created.
    created_at: ?i64 = null,

    /// The number of data points that must not within the specified threshold to
    /// trigger the
    /// alarm.
    datapoints_to_alarm: ?i32 = null,

    /// The number of periods over which data is compared to the specified
    /// threshold.
    evaluation_periods: ?i32 = null,

    /// An object that lists information about the location of the alarm.
    location: ?ResourceLocation = null,

    /// The name of the metric associated with the alarm.
    metric_name: ?MetricName = null,

    /// An object that lists information about the resource monitored by the alarm.
    monitored_resource_info: ?MonitoredResourceInfo = null,

    /// The name of the alarm.
    name: ?[]const u8 = null,

    /// Indicates whether the alarm is enabled.
    notification_enabled: ?bool = null,

    /// The alarm states that trigger a notification.
    notification_triggers: ?[]const AlarmState = null,

    /// The period, in seconds, over which the statistic is applied.
    period: ?i32 = null,

    /// The Lightsail resource type of the alarm.
    resource_type: ?ResourceType = null,

    /// The current state of the alarm.
    ///
    /// An alarm has the following possible states:
    ///
    /// * `ALARM` - The metric is outside of the defined threshold.
    ///
    /// * `INSUFFICIENT_DATA` - The alarm has just started, the metric is not
    /// available, or not enough data is available for the metric to determine the
    /// alarm
    /// state.
    ///
    /// * `OK` - The metric is within the defined threshold.
    state: ?AlarmState = null,

    /// The statistic for the metric associated with the alarm.
    ///
    /// The following statistics are available:
    ///
    /// * `Minimum` - The lowest value observed during the specified period. Use
    ///   this
    /// value to determine low volumes of activity for your application.
    ///
    /// * `Maximum` - The highest value observed during the specified period. Use
    /// this value to determine high volumes of activity for your application.
    ///
    /// * `Sum` - All values submitted for the matching metric added together. You
    /// can use this statistic to determine the total volume of a metric.
    ///
    /// * `Average` - The value of Sum / SampleCount during the specified period. By
    /// comparing this statistic with the Minimum and Maximum values, you can
    /// determine the full
    /// scope of a metric and how close the average use is to the Minimum and
    /// Maximum values. This
    /// comparison helps you to know when to increase or decrease your resources.
    ///
    /// * `SampleCount` - The count, or number, of data points used for the
    /// statistical calculation.
    statistic: ?MetricStatistic = null,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// your Lightsail alarm. This code enables our support team to look up your
    /// Lightsail
    /// information more easily.
    support_code: ?[]const u8 = null,

    /// The value against which the specified statistic is compared.
    threshold: ?f64 = null,

    /// Specifies how the alarm handles missing data points.
    ///
    /// An alarm can treat missing data in the following ways:
    ///
    /// * `breaching` - Assume the missing data is not within the threshold. Missing
    /// data counts towards the number of times the metric is not within the
    /// threshold.
    ///
    /// * `notBreaching` - Assume the missing data is within the threshold. Missing
    /// data does not count towards the number of times the metric is not within the
    /// threshold.
    ///
    /// * `ignore` - Ignore the missing data. Maintains the current alarm
    /// state.
    ///
    /// * `missing` - Missing data is treated as missing.
    treat_missing_data: ?TreatMissingData = null,

    /// The unit of the metric associated with the alarm.
    unit: ?MetricUnit = null,

    pub const json_field_names = .{
        .arn = "arn",
        .comparison_operator = "comparisonOperator",
        .contact_protocols = "contactProtocols",
        .created_at = "createdAt",
        .datapoints_to_alarm = "datapointsToAlarm",
        .evaluation_periods = "evaluationPeriods",
        .location = "location",
        .metric_name = "metricName",
        .monitored_resource_info = "monitoredResourceInfo",
        .name = "name",
        .notification_enabled = "notificationEnabled",
        .notification_triggers = "notificationTriggers",
        .period = "period",
        .resource_type = "resourceType",
        .state = "state",
        .statistic = "statistic",
        .support_code = "supportCode",
        .threshold = "threshold",
        .treat_missing_data = "treatMissingData",
        .unit = "unit",
    };
};
