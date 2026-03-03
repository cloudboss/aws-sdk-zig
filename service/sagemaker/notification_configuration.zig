/// Configures Amazon SNS notifications of available or expiring work items for
/// work teams.
pub const NotificationConfiguration = struct {
    /// The ARN for the Amazon SNS topic to which notifications should be published.
    notification_topic_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .notification_topic_arn = "NotificationTopicArn",
    };
};
