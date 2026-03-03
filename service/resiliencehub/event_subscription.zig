const EventType = @import("event_type.zig").EventType;

/// Indicates an event you would like to subscribe and get notification for.
/// Currently,
/// Resilience Hub supports notifications only for **Drift
/// detected** and **Scheduled assessment failure**
/// events.
pub const EventSubscription = struct {
    /// The type of event you would like to subscribe and get notification for.
    /// Currently, Resilience Hub supports notifications only for **Drift
    /// detected** (`DriftDetected`) and **Scheduled
    /// assessment failure** (`ScheduledAssessmentFailure`) events.
    event_type: EventType,

    /// Unique name to identify an event subscription.
    name: []const u8,

    /// Amazon Resource Name (ARN) of the Amazon Simple Notification Service topic.
    /// The format for this ARN
    /// is: `arn:partition:sns:region:account:topic-name`. For more information
    /// about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    sns_topic_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_type = "eventType",
        .name = "name",
        .sns_topic_arn = "snsTopicArn",
    };
};
