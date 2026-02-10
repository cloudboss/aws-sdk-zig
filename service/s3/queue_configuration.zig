const Event = @import("event.zig").Event;
const NotificationConfigurationFilter = @import("notification_configuration_filter.zig").NotificationConfigurationFilter;

/// Specifies the configuration for publishing messages to an Amazon Simple
/// Queue Service (Amazon SQS)
/// queue when Amazon S3 detects specified events.
pub const QueueConfiguration = struct {
    /// A collection of bucket events for which to send notifications
    events: []const Event,

    filter: ?NotificationConfigurationFilter,

    id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Amazon SQS queue to which Amazon S3
    /// publishes a message when it
    /// detects events of the specified type.
    queue_arn: []const u8,
};
