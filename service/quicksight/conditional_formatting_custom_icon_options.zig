const Icon = @import("icon.zig").Icon;

/// Custom icon options for an icon set.
pub const ConditionalFormattingCustomIconOptions = struct {
    /// Determines the type of icon.
    icon: ?Icon = null,

    /// Determines the Unicode icon type.
    unicode_icon: ?[]const u8 = null,

    pub const json_field_names = .{
        .icon = "Icon",
        .unicode_icon = "UnicodeIcon",
    };
};
