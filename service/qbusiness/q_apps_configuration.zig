const QAppsControlMode = @import("q_apps_control_mode.zig").QAppsControlMode;

/// Configuration information about Amazon Q Apps.
pub const QAppsConfiguration = struct {
    /// Status information about whether end users can create and use Amazon Q Apps
    /// in the web experience.
    q_apps_control_mode: QAppsControlMode,

    pub const json_field_names = .{
        .q_apps_control_mode = "qAppsControlMode",
    };
};
