/// Contains metadata about the event that caused the `NotificationEvent`. For
/// other specific values, see `sourceEventMetadata`.
pub const SourceEventMetadataSummary = struct {
    /// The Region where the notification originated.
    ///
    /// Unavailable for aggregated notifications.
    event_origin_region: ?[]const u8 = null,

    /// The event type to match.
    ///
    /// Must match one of the valid Amazon EventBridge event types. For example, EC2
    /// Instance State-change Notification and Amazon CloudWatch Alarm State Change.
    /// For more information, see [Event delivery from Amazon Web Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event.html#eb-service-event-delivery-level) in the *Amazon EventBridge User Guide*.
    event_type: []const u8,

    /// The matched event source.
    ///
    /// Must match one of the valid EventBridge sources. Only Amazon Web Services
    /// service sourced events are supported. For example, `aws.ec2` and
    /// `aws.cloudwatch`. For more information, see [Event delivery from Amazon Web
    /// Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event.html#eb-service-event-delivery-level) in the *Amazon EventBridge User Guide*.
    source: []const u8,

    pub const json_field_names = .{
        .event_origin_region = "eventOriginRegion",
        .event_type = "eventType",
        .source = "source",
    };
};
