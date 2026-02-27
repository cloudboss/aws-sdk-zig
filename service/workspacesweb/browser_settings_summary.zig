/// The summary for browser settings.
pub const BrowserSettingsSummary = struct {
    /// The ARN of the browser settings.
    browser_settings_arn: []const u8,

    pub const json_field_names = .{
        .browser_settings_arn = "browserSettingsArn",
    };
};
