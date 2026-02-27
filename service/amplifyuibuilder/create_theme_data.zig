const aws = @import("aws");

const ThemeValues = @import("theme_values.zig").ThemeValues;

/// Represents all of the information that is required to create a theme.
pub const CreateThemeData = struct {
    /// The name of the theme.
    name: []const u8,

    /// Describes the properties that can be overriden to customize an instance of
    /// the
    /// theme.
    overrides: ?[]const ThemeValues,

    /// One or more key-value pairs to use when tagging the theme data.
    tags: ?[]const aws.map.StringMapEntry,

    /// A list of key-value pairs that deﬁnes the properties of the theme.
    values: []const ThemeValues,

    pub const json_field_names = .{
        .name = "name",
        .overrides = "overrides",
        .tags = "tags",
        .values = "values",
    };
};
