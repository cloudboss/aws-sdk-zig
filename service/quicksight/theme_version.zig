const ThemeConfiguration = @import("theme_configuration.zig").ThemeConfiguration;
const ThemeError = @import("theme_error.zig").ThemeError;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// A version of a theme.
pub const ThemeVersion = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8 = null,

    /// The Quick Sight-defined ID of the theme that a custom theme inherits from.
    /// All
    /// themes initially inherit from a default Quick Sight theme.
    base_theme_id: ?[]const u8 = null,

    /// The theme configuration, which contains all the theme display properties.
    configuration: ?ThemeConfiguration = null,

    /// The date and time that this theme version was created.
    created_time: ?i64 = null,

    /// The description of the theme.
    description: ?[]const u8 = null,

    /// Errors associated with the theme.
    errors: ?[]const ThemeError = null,

    /// The status of the theme version.
    status: ?ResourceStatus = null,

    /// The version number of the theme.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .base_theme_id = "BaseThemeId",
        .configuration = "Configuration",
        .created_time = "CreatedTime",
        .description = "Description",
        .errors = "Errors",
        .status = "Status",
        .version_number = "VersionNumber",
    };
};
