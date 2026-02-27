/// Details on SNS that are required to send the notification.
pub const SnsConfiguration = struct {
    /// SNS topic ARN that the scheduled query status notifications will be sent to.
    topic_arn: []const u8,

    pub const json_field_names = .{
        .topic_arn = "TopicArn",
    };
};
