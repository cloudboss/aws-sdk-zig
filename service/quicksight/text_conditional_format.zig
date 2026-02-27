const ConditionalFormattingColor = @import("conditional_formatting_color.zig").ConditionalFormattingColor;
const ConditionalFormattingIcon = @import("conditional_formatting_icon.zig").ConditionalFormattingIcon;

/// The conditional formatting for the text.
pub const TextConditionalFormat = struct {
    /// The conditional formatting for the text background color.
    background_color: ?ConditionalFormattingColor,

    /// The conditional formatting for the icon.
    icon: ?ConditionalFormattingIcon,

    /// The conditional formatting for the text color.
    text_color: ?ConditionalFormattingColor,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
        .icon = "Icon",
        .text_color = "TextColor",
    };
};
