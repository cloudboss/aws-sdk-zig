const RefreshFailureAlertStatus = @import("refresh_failure_alert_status.zig").RefreshFailureAlertStatus;

/// The configuration settings for the email alerts that are sent when a dataset
/// refresh fails.
pub const RefreshFailureEmailAlert = struct {
    /// The status value that determines if email alerts are sent.
    alert_status: ?RefreshFailureAlertStatus,

    pub const json_field_names = .{
        .alert_status = "AlertStatus",
    };
};
