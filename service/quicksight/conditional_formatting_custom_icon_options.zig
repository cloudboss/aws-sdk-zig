const Icon = @import("icon.zig").Icon;

/// Custom icon options for an icon set.
pub const ConditionalFormattingCustomIconOptions = struct {
    /// Determines the type of icon.
    icon: ?Icon,

    /// Determines the Unicode icon type.
    unicode_icon: ?[]const u8,

    pub const json_field_names = .{
        .icon = "Icon",
        .unicode_icon = "UnicodeIcon",
    };
};
