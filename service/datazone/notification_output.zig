const aws = @import("aws");

const TaskStatus = @import("task_status.zig").TaskStatus;
const Topic = @import("topic.zig").Topic;
const NotificationType = @import("notification_type.zig").NotificationType;

/// The details of a notification generated in Amazon DataZone.
pub const NotificationOutput = struct {
    /// The action link included in the notification.
    action_link: []const u8,

    /// The timestamp of when a notification was created.
    creation_timestamp: i64,

    /// The identifier of a Amazon DataZone domain in which the notification exists.
    domain_identifier: []const u8,

    /// The identifier of the notification.
    identifier: []const u8,

    /// The timestamp of when the notification was last updated.
    last_updated_timestamp: i64,

    /// The message included in the notification.
    message: []const u8,

    /// The metadata included in the notification.
    metadata: ?[]const aws.map.StringMapEntry,

    /// The status included in the notification.
    status: ?TaskStatus,

    /// The title of the notification.
    title: []const u8,

    /// The topic of the notification.
    topic: Topic,

    /// The type of the notification.
    @"type": NotificationType,

    pub const json_field_names = .{
        .action_link = "actionLink",
        .creation_timestamp = "creationTimestamp",
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .message = "message",
        .metadata = "metadata",
        .status = "status",
        .title = "title",
        .topic = "topic",
        .@"type" = "type",
    };
};
