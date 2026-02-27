const ThemeValues = @import("theme_values.zig").ThemeValues;

/// Describes the configuration of a theme's properties.
pub const ThemeValue = struct {
    /// A list of key-value pairs that define the theme's properties.
    children: ?[]const ThemeValues,

    /// The value of a theme property.
    value: ?[]const u8,

    pub const json_field_names = .{
        .children = "children",
        .value = "value",
    };
};
