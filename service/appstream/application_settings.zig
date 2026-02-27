/// The persistent application settings for users of a stack.
pub const ApplicationSettings = struct {
    /// Enables or disables persistent application settings for users during their
    /// streaming sessions.
    enabled: bool,

    /// The path prefix for the S3 bucket where users’ persistent application
    /// settings are stored. You can allow the same persistent application settings
    /// to be used across multiple stacks by specifying the same settings group for
    /// each stack.
    settings_group: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .settings_group = "SettingsGroup",
    };
};
