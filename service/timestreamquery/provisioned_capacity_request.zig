const AccountSettingsNotificationConfiguration = @import("account_settings_notification_configuration.zig").AccountSettingsNotificationConfiguration;

/// A request to update the provisioned capacity settings for querying data.
pub const ProvisionedCapacityRequest = struct {
    /// Configuration settings for notifications related to the provisioned capacity
    /// update.
    notification_configuration: ?AccountSettingsNotificationConfiguration = null,

    /// The target compute capacity for querying data, specified in Timestream
    /// Compute Units (TCUs).
    target_query_tcu: i32,

    pub const json_field_names = .{
        .notification_configuration = "NotificationConfiguration",
        .target_query_tcu = "TargetQueryTCU",
    };
};
