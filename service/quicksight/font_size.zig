const RelativeFontSize = @import("relative_font_size.zig").RelativeFontSize;

/// The option that determines the text display size.
pub const FontSize = struct {
    /// The font size that you want to use in px.
    absolute: ?[]const u8,

    /// The lexical name for the text size, proportional to its surrounding context.
    relative: ?RelativeFontSize,

    pub const json_field_names = .{
        .absolute = "Absolute",
        .relative = "Relative",
    };
};
