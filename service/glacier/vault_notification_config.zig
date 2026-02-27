/// Represents a vault's notification configuration.
pub const VaultNotificationConfig = struct {
    /// A list of one or more events for which Amazon Glacier will send a
    /// notification to the
    /// specified Amazon SNS topic.
    events: ?[]const []const u8,

    /// The Amazon Simple Notification Service (Amazon SNS) topic Amazon Resource
    /// Name
    /// (ARN).
    sns_topic: ?[]const u8,

    pub const json_field_names = .{
        .events = "Events",
        .sns_topic = "SNSTopic",
    };
};
