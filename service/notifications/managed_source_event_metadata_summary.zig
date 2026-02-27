/// A short summary and metadata for a managed notification event.
pub const ManagedSourceEventMetadataSummary = struct {
    /// The Region where the notification originated.
    event_origin_region: ?[]const u8,

    /// The event Type of the notification.
    event_type: []const u8,

    /// The source service of the notification.
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
