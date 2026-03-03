/// The theme summary.
pub const ThemeSummary = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8 = null,

    /// The date and time that this theme was created.
    created_time: ?i64 = null,

    /// The last date and time that this theme was updated.
    last_updated_time: ?i64 = null,

    /// The latest version number for the theme.
    latest_version_number: ?i64 = null,

    /// the display name for the theme.
    name: ?[]const u8 = null,

    /// The ID of the theme. This ID is unique per Amazon Web Services Region for
    /// each Amazon Web Services account.
    theme_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .last_updated_time = "LastUpdatedTime",
        .latest_version_number = "LatestVersionNumber",
        .name = "Name",
        .theme_id = "ThemeId",
    };
};
