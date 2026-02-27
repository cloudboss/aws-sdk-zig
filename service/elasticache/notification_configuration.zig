/// Describes a notification topic and its status. Notification topics are used
/// for
/// publishing ElastiCache events to subscribers using Amazon Simple
/// Notification Service
/// (SNS).
pub const NotificationConfiguration = struct {
    /// The Amazon Resource Name (ARN) that identifies the topic.
    topic_arn: ?[]const u8,

    /// The current state of the topic.
    topic_status: ?[]const u8,
};
