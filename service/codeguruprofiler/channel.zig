const EventPublisher = @import("event_publisher.zig").EventPublisher;

/// Notification medium for users to get alerted for events that occur in
/// application profile. We support SNS topic as a notification channel.
pub const Channel = struct {
    /// List of publishers for different type of events that may be detected in an
    /// application from the profile. Anomaly detection is the only event publisher
    /// in Profiler.
    event_publishers: []const EventPublisher,

    /// Unique identifier for each `Channel` in the notification configuration of a
    /// Profiling Group. A random UUID for channelId is used when adding a channel
    /// to the notification configuration if not specified in the request.
    id: ?[]const u8,

    /// Unique arn of the resource to be used for notifications. We support a valid
    /// SNS topic arn as a channel uri.
    uri: []const u8,

    pub const json_field_names = .{
        .event_publishers = "eventPublishers",
        .id = "id",
        .uri = "uri",
    };
};
