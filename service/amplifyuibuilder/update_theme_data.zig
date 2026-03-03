const ThemeValues = @import("theme_values.zig").ThemeValues;

/// Saves the data binding information for a theme.
pub const UpdateThemeData = struct {
    /// The unique ID of the theme to update.
    id: ?[]const u8 = null,

    /// The name of the theme to update.
    name: ?[]const u8 = null,

    /// Describes the properties that can be overriden to customize the theme.
    overrides: ?[]const ThemeValues = null,

    /// A list of key-value pairs that define the theme's properties.
    values: []const ThemeValues,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .overrides = "overrides",
        .values = "values",
    };
};
