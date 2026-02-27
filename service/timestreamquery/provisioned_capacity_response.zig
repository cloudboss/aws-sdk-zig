const LastUpdate = @import("last_update.zig").LastUpdate;
const AccountSettingsNotificationConfiguration = @import("account_settings_notification_configuration.zig").AccountSettingsNotificationConfiguration;

/// The response to a request to update the provisioned capacity settings for
/// querying data.
pub const ProvisionedCapacityResponse = struct {
    /// The number of Timestream Compute Units (TCUs) provisioned in the account.
    /// This field is only visible when the compute mode is `PROVISIONED`.
    active_query_tcu: ?i32,

    /// Information about the last update to the provisioned capacity settings.
    last_update: ?LastUpdate,

    /// An object that contains settings for notifications that are sent whenever
    /// the provisioned capacity settings are modified. This field is only visible
    /// when the compute mode is `PROVISIONED`.
    notification_configuration: ?AccountSettingsNotificationConfiguration,

    pub const json_field_names = .{
        .active_query_tcu = "ActiveQueryTCU",
        .last_update = "LastUpdate",
        .notification_configuration = "NotificationConfiguration",
    };
};
