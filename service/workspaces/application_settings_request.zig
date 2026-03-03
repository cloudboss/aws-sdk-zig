const ApplicationSettingsStatusEnum = @import("application_settings_status_enum.zig").ApplicationSettingsStatusEnum;

/// The persistent application settings for WorkSpaces Pools users.
pub const ApplicationSettingsRequest = struct {
    /// The path prefix for the S3 bucket where users’ persistent application
    /// settings are stored.
    /// You can allow the same persistent application settings to be used across
    /// multiple pools by specifying
    /// the same settings group for each pool.
    settings_group: ?[]const u8 = null,

    /// Enables or disables persistent application settings for users during their
    /// pool sessions.
    status: ApplicationSettingsStatusEnum,

    pub const json_field_names = .{
        .settings_group = "SettingsGroup",
        .status = "Status",
    };
};
