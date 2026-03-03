const ThemeType = @import("theme_type.zig").ThemeType;
const ThemeVersion = @import("theme_version.zig").ThemeVersion;

/// Summary information about a theme.
pub const Theme = struct {
    /// The Amazon Resource Name (ARN) of the theme.
    arn: ?[]const u8 = null,

    /// The date and time that the theme was created.
    created_time: ?i64 = null,

    /// The date and time that the theme was last updated.
    last_updated_time: ?i64 = null,

    /// The name that the user gives to the theme.
    name: ?[]const u8 = null,

    /// The identifier that the user gives to the theme.
    theme_id: ?[]const u8 = null,

    /// The type of theme, based on how it was created. Valid values include:
    /// `QUICKSIGHT` and `CUSTOM`.
    @"type": ?ThemeType = null,

    version: ?ThemeVersion = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .theme_id = "ThemeId",
        .@"type" = "Type",
        .version = "Version",
    };
};
