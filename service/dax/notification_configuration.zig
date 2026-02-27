/// Describes a notification topic and its status. Notification topics are used
/// for
/// publishing DAX events to subscribers using Amazon Simple Notification
/// Service
/// (SNS).
pub const NotificationConfiguration = struct {
    /// The Amazon Resource Name (ARN) that identifies the topic.
    topic_arn: ?[]const u8,

    /// The current state of the topic. A value of “active” means that notifications
    /// will
    /// be sent to the topic. A value of “inactive” means that notifications will
    /// not be sent to
    /// the topic.
    topic_status: ?[]const u8,

    pub const json_field_names = .{
        .topic_arn = "TopicArn",
        .topic_status = "TopicStatus",
    };
};
