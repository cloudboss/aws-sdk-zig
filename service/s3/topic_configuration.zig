const Event = @import("event.zig").Event;
const NotificationConfigurationFilter = @import("notification_configuration_filter.zig").NotificationConfigurationFilter;

/// A container for specifying the configuration for publication of messages to
/// an Amazon Simple
/// Notification Service (Amazon SNS) topic when Amazon S3 detects specified
/// events.
pub const TopicConfiguration = struct {
    /// The Amazon S3 bucket event about which to send notifications. For more
    /// information, see [Supported Event
    /// Types](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in
    /// the *Amazon S3 User Guide*.
    events: []const Event,

    filter: ?NotificationConfigurationFilter,

    id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic to which Amazon S3
    /// publishes a message when it
    /// detects events of the specified type.
    topic_arn: []const u8,
};
