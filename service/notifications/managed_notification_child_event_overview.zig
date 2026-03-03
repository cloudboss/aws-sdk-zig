const ManagedNotificationChildEventSummary = @import("managed_notification_child_event_summary.zig").ManagedNotificationChildEventSummary;

/// Describes an overview and metadata for a `ManagedNotificationChildEvent`.
pub const ManagedNotificationChildEventOverview = struct {
    /// The Amazon Resource Name (ARN) of the ManagedNotificationEvent that is
    /// associated with this `ManagedNotificationChildEvent`.
    aggregate_managed_notification_event_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the `ManagedNotificationChildEvent`.
    arn: []const u8,

    /// The content of the `ManagedNotificationChildEvent`.
    child_event: ManagedNotificationChildEventSummary,

    /// The creation time of the `ManagedNotificationChildEvent`.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the `ManagedNotificationConfiguration`.
    managed_notification_configuration_arn: []const u8,

    /// The Organizational Unit Id that an AWS account belongs to.
    organizational_unit_id: ?[]const u8 = null,

    /// The account that related to the `ManagedNotificationChildEvent`.
    related_account: []const u8,

    pub const json_field_names = .{
        .aggregate_managed_notification_event_arn = "aggregateManagedNotificationEventArn",
        .arn = "arn",
        .child_event = "childEvent",
        .creation_time = "creationTime",
        .managed_notification_configuration_arn = "managedNotificationConfigurationArn",
        .organizational_unit_id = "organizationalUnitId",
        .related_account = "relatedAccount",
    };
};
