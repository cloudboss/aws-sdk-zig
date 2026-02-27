const EventNotificationTopicStatus = @import("event_notification_topic_status.zig").EventNotificationTopicStatus;

/// `SidewalkEventNotificationConfigurations` object, which is the event
/// configuration object for Sidewalk-related event topics.
pub const SidewalkEventNotificationConfigurations = struct {
    /// Denotes whether the Amazon ID event topic is enabled or disabled.
    amazon_id_event_topic: ?EventNotificationTopicStatus,

    pub const json_field_names = .{
        .amazon_id_event_topic = "AmazonIdEventTopic",
    };
};
