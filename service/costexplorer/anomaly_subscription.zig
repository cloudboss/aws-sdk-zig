const AnomalySubscriptionFrequency = @import("anomaly_subscription_frequency.zig").AnomalySubscriptionFrequency;
const Subscriber = @import("subscriber.zig").Subscriber;
const Expression = @import("expression.zig").Expression;

/// An `AnomalySubscription` resource (also referred to as an alert
/// subscription) sends notifications about specific anomalies that meet an
/// alerting
/// criteria defined by you.
///
/// You can specify the frequency of the alerts and the subscribers to notify.
///
/// Anomaly subscriptions can be associated with one or more [
/// `AnomalyMonitor`
/// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_AnomalyMonitor.html) resources, and they only send
/// notifications about anomalies detected by those associated monitors. You can
/// also
/// configure a threshold to further control which anomalies are included in the
/// notifications.
///
/// Anomalies that don’t exceed the chosen threshold and therefore don’t trigger
/// notifications from an anomaly subscription will still be available on the
/// console and
/// from the [
/// `GetAnomalies`
/// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_GetAnomalies.html) API.
pub const AnomalySubscription = struct {
    /// Your unique account identifier.
    account_id: ?[]const u8 = null,

    /// The frequency that anomaly notifications are sent. Notifications are sent
    /// either over
    /// email (for DAILY and WEEKLY frequencies) or SNS (for IMMEDIATE frequency).
    /// For more
    /// information, see [Creating an Amazon SNS topic for
    /// anomaly
    /// notifications](https://docs.aws.amazon.com/cost-management/latest/userguide/ad-SNS.html).
    frequency: AnomalySubscriptionFrequency,

    /// A list of cost anomaly monitors.
    monitor_arn_list: []const []const u8,

    /// A list of subscribers to notify.
    subscribers: []const Subscriber,

    /// The `AnomalySubscription` Amazon Resource Name (ARN).
    subscription_arn: ?[]const u8 = null,

    /// The name for the subscription.
    subscription_name: []const u8,

    /// (deprecated)
    ///
    /// An absolute dollar value that must be exceeded by the anomaly's total impact
    /// (see
    /// [Impact](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Impact.html) for
    /// more details) for an anomaly notification to be generated.
    ///
    /// This field has been deprecated. To specify a threshold, use
    /// ThresholdExpression.
    /// Continued use of Threshold will be treated as shorthand syntax for a
    /// ThresholdExpression.
    ///
    /// One of Threshold or ThresholdExpression is required for this resource. You
    /// cannot
    /// specify both.
    threshold: ?f64 = null,

    /// An
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html)
    /// object used to specify the anomalies that you want to generate alerts for.
    /// This supports
    /// dimensions and nested expressions. The supported dimensions are
    /// `ANOMALY_TOTAL_IMPACT_ABSOLUTE` and
    /// `ANOMALY_TOTAL_IMPACT_PERCENTAGE`, corresponding to an anomaly’s
    /// TotalImpact and TotalImpactPercentage, respectively (see
    /// [Impact](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Impact.html) for
    /// more details). The supported nested expression types are `AND` and
    /// `OR`. The match option `GREATER_THAN_OR_EQUAL` is required.
    /// Values must be numbers between 0 and 10,000,000,000 in string format.
    ///
    /// One of Threshold or ThresholdExpression is required for this resource. You
    /// cannot
    /// specify both.
    ///
    /// The following are examples of valid ThresholdExpressions:
    ///
    /// * Absolute threshold: `{ "Dimensions": { "Key":
    /// "ANOMALY_TOTAL_IMPACT_ABSOLUTE", "MatchOptions": [ "GREATER_THAN_OR_EQUAL"
    /// ], "Values": [ "100" ] } }`
    ///
    /// * Percentage threshold: `{ "Dimensions": { "Key":
    /// "ANOMALY_TOTAL_IMPACT_PERCENTAGE", "MatchOptions": [ "GREATER_THAN_OR_EQUAL"
    /// ], "Values": [ "100" ] } }`
    ///
    /// * `AND` two thresholds together: `{ "And": [ { "Dimensions": {
    /// "Key": "ANOMALY_TOTAL_IMPACT_ABSOLUTE", "MatchOptions": [
    /// "GREATER_THAN_OR_EQUAL" ], "Values": [ "100" ] } }, { "Dimensions": { "Key":
    /// "ANOMALY_TOTAL_IMPACT_PERCENTAGE", "MatchOptions": [ "GREATER_THAN_OR_EQUAL"
    /// ], "Values": [ "100" ] } } ] }`
    ///
    /// * `OR` two thresholds together: `{ "Or": [ { "Dimensions": {
    /// "Key": "ANOMALY_TOTAL_IMPACT_ABSOLUTE", "MatchOptions": [
    /// "GREATER_THAN_OR_EQUAL" ], "Values": [ "100" ] } }, { "Dimensions": { "Key":
    /// "ANOMALY_TOTAL_IMPACT_PERCENTAGE", "MatchOptions": [ "GREATER_THAN_OR_EQUAL"
    /// ], "Values": [ "100" ] } } ] }`
    threshold_expression: ?Expression = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .frequency = "Frequency",
        .monitor_arn_list = "MonitorArnList",
        .subscribers = "Subscribers",
        .subscription_arn = "SubscriptionArn",
        .subscription_name = "SubscriptionName",
        .threshold = "Threshold",
        .threshold_expression = "ThresholdExpression",
    };
};
