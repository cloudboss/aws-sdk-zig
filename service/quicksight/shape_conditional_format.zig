const ConditionalFormattingColor = @import("conditional_formatting_color.zig").ConditionalFormattingColor;

/// The shape conditional formatting of a filled map visual.
pub const ShapeConditionalFormat = struct {
    /// The conditional formatting for the shape background color of a filled map
    /// visual.
    background_color: ConditionalFormattingColor,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
    };
};
