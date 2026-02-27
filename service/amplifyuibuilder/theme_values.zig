const ThemeValue = @import("theme_value.zig").ThemeValue;

/// A key-value pair that defines a property of a theme.
pub const ThemeValues = struct {
    /// The name of the property.
    key: ?[]const u8,

    /// The value of the property.
    value: ?*ThemeValue = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
