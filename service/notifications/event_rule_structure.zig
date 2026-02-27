const aws = @import("aws");

const EventRuleStatusSummary = @import("event_rule_status_summary.zig").EventRuleStatusSummary;

/// Contains a complete list of fields related to an `EventRule`.
pub const EventRuleStructure = struct {
    /// The Amazon Resource Name (ARN) of the `EventRule`. CloudFormation stack
    /// generates this ARN and then uses this ARN to associate with the
    /// `NotificationConfiguration`.
    arn: []const u8,

    /// The creation time of the `EventRule`.
    creation_time: i64,

    /// An additional event pattern used to further filter the events this
    /// `EventRule` receives.
    ///
    /// For more information, see [Amazon EventBridge event
    /// patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-patterns.html) in the *Amazon EventBridge User Guide.*
    event_pattern: []const u8,

    /// The event type this rule should match with the EventBridge events. It must
    /// match with atleast one of the valid EventBridge event types. For example,
    /// Amazon EC2 Instance State change Notification and Amazon CloudWatch State
    /// Change. For more information, see [Event delivery from Amazon Web Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event.html#eb-service-event-delivery-level) in the * Amazon EventBridge User Guide*.
    event_type: []const u8,

    /// A list of Amazon EventBridge Managed Rule ARNs associated with this
    /// `EventRule`.
    ///
    /// These are created by User Notifications within your account so your
    /// `EventRules` can function.
    managed_rules: []const []const u8,

    /// The ARN for the `NotificationConfiguration` associated with this
    /// `EventRule`.
    notification_configuration_arn: []const u8,

    /// A list of Amazon Web Services Regions that send events to this `EventRule`.
    regions: []const []const u8,

    /// The event source this rule should match with the EventBridge event sources.
    /// It must match with atleast one of the valid EventBridge event sources. Only
    /// Amazon Web Services service sourced events are supported. For example,
    /// `aws.ec2` and `aws.cloudwatch`. For more information, see [Event delivery
    /// from Amazon Web Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event.html#eb-service-event-delivery-level) in the * Amazon EventBridge User Guide*.
    source: []const u8,

    /// A list of an `EventRule`'s status by Region. Regions are mapped to
    /// `EventRuleStatusSummary`.
    status_summary_by_region: []const aws.map.MapEntry(EventRuleStatusSummary),

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .event_pattern = "eventPattern",
        .event_type = "eventType",
        .managed_rules = "managedRules",
        .notification_configuration_arn = "notificationConfigurationArn",
        .regions = "regions",
        .source = "source",
        .status_summary_by_region = "statusSummaryByRegion",
    };
};
