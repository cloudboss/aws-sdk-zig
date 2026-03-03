const RefreshFailureEmailAlert = @import("refresh_failure_email_alert.zig").RefreshFailureEmailAlert;

/// The failure configuration of a dataset.
pub const RefreshFailureConfiguration = struct {
    /// The email alert configuration for a dataset refresh failure.
    email_alert: ?RefreshFailureEmailAlert = null,

    pub const json_field_names = .{
        .email_alert = "EmailAlert",
    };
};
