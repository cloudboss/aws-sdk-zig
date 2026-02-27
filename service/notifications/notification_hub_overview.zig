const NotificationHubStatusSummary = @import("notification_hub_status_summary.zig").NotificationHubStatusSummary;

/// Describes an overview of a `NotificationHub`.
///
/// A `NotificationConfiguration` is an account-level setting used to select the
/// Regions where you want to store, process and replicate your notifications.
pub const NotificationHubOverview = struct {
    /// The date and time the `NotificationHubOverview` was created.
    creation_time: i64,

    /// The most recent time this `NotificationHub` had an `ACTIVE` status.
    last_activation_time: ?i64,

    /// The Region of the resource.
    notification_hub_region: []const u8,

    /// The status summary of the resource.
    status_summary: NotificationHubStatusSummary,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .last_activation_time = "lastActivationTime",
        .notification_hub_region = "notificationHubRegion",
        .status_summary = "statusSummary",
    };
};
