const RealTimeAlertRule = @import("real_time_alert_rule.zig").RealTimeAlertRule;

/// A structure that contains the configuration settings for real-time alerts.
pub const RealTimeAlertConfiguration = struct {
    /// Turns off real-time alerts.
    disabled: bool = false,

    /// The rules in the alert. Rules specify the words or phrases that you want to
    /// be notified about.
    rules: ?[]const RealTimeAlertRule = null,

    pub const json_field_names = .{
        .disabled = "Disabled",
        .rules = "Rules",
    };
};
