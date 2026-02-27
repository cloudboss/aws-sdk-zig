const aws = @import("aws");

const ThemeValues = @import("theme_values.zig").ThemeValues;

/// A theme is a collection of style settings that apply globally to the
/// components associated
/// with an Amplify application.
pub const Theme = struct {
    /// The unique ID for the Amplify app associated with the theme.
    app_id: []const u8,

    /// The time that the theme was created.
    created_at: i64,

    /// The name of the backend environment that is a part of the Amplify
    /// app.
    environment_name: []const u8,

    /// The ID for the theme.
    id: []const u8,

    /// The time that the theme was modified.
    modified_at: ?i64,

    /// The name of the theme.
    name: []const u8,

    /// Describes the properties that can be overriden to customize a theme.
    overrides: ?[]const ThemeValues,

    /// One or more key-value pairs to use when tagging the theme.
    tags: ?[]const aws.map.StringMapEntry,

    /// A list of key-value pairs that defines the properties of the theme.
    values: []const ThemeValues,

    pub const json_field_names = .{
        .app_id = "appId",
        .created_at = "createdAt",
        .environment_name = "environmentName",
        .id = "id",
        .modified_at = "modifiedAt",
        .name = "name",
        .overrides = "overrides",
        .tags = "tags",
        .values = "values",
    };
};
