const ConditionalFormattingIcon = @import("conditional_formatting_icon.zig").ConditionalFormattingIcon;
const ConditionalFormattingColor = @import("conditional_formatting_color.zig").ConditionalFormattingColor;

/// The conditional formatting for the actual value of a KPI visual.
pub const KPIActualValueConditionalFormatting = struct {
    /// The conditional formatting of the actual value's icon.
    icon: ?ConditionalFormattingIcon,

    /// The conditional formatting of the actual value's text color.
    text_color: ?ConditionalFormattingColor,

    pub const json_field_names = .{
        .icon = "Icon",
        .text_color = "TextColor",
    };
};
