/// The SNS targets that are notified when updates are made to an incident.
pub const NotificationTargetItem = union(enum) {
    /// The Amazon Resource Name (ARN) of the SNS topic.
    sns_topic_arn: ?[]const u8,

    pub const json_field_names = .{
        .sns_topic_arn = "snsTopicArn",
    };
};
