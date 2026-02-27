/// The structure containing configurations related to insights.
pub const InsightsConfiguration = struct {
    /// Set the InsightsEnabled value to true to enable insights or false to disable
    /// insights.
    insights_enabled: ?bool,

    /// Set the NotificationsEnabled value to true to enable insights notifications.
    /// Notifications can only be
    /// enabled on a group with InsightsEnabled set to true.
    notifications_enabled: ?bool,

    pub const json_field_names = .{
        .insights_enabled = "InsightsEnabled",
        .notifications_enabled = "NotificationsEnabled",
    };
};
