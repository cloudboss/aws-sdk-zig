const ConditionalFormattingColor = @import("conditional_formatting_color.zig").ConditionalFormattingColor;

/// The conditional formatting of a table row.
pub const TableRowConditionalFormatting = struct {
    /// The conditional formatting color (solid, gradient) of the background for a
    /// table row.
    background_color: ?ConditionalFormattingColor = null,

    /// The conditional formatting color (solid, gradient) of the text for a table
    /// row.
    text_color: ?ConditionalFormattingColor = null,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
        .text_color = "TextColor",
    };
};
