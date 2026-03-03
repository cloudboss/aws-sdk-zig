/// The summary of IP access settings.
pub const IpAccessSettingsSummary = struct {
    /// The creation date timestamp of the IP access settings.
    creation_date: ?i64 = null,

    /// The description of the IP access settings.
    description: ?[]const u8 = null,

    /// The display name of the IP access settings.
    display_name: ?[]const u8 = null,

    /// The ARN of IP access settings.
    ip_access_settings_arn: []const u8,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .description = "description",
        .display_name = "displayName",
        .ip_access_settings_arn = "ipAccessSettingsArn",
    };
};
