/// The summary of the data protection settings.
pub const DataProtectionSettingsSummary = struct {
    /// The creation date timestamp of the data protection settings.
    creation_date: ?i64 = null,

    /// The ARN of the data protection settings.
    data_protection_settings_arn: []const u8,

    /// The description of the data protection settings.
    description: ?[]const u8 = null,

    /// The display name of the data protection settings.
    display_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .data_protection_settings_arn = "dataProtectionSettingsArn",
        .description = "description",
        .display_name = "displayName",
    };
};
