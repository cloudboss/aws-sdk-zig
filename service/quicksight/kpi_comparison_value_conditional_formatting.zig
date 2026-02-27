const ConditionalFormattingIcon = @import("conditional_formatting_icon.zig").ConditionalFormattingIcon;
const ConditionalFormattingColor = @import("conditional_formatting_color.zig").ConditionalFormattingColor;

/// The conditional formatting for the comparison value of a KPI visual.
pub const KPIComparisonValueConditionalFormatting = struct {
    /// The conditional formatting of the comparison value's icon.
    icon: ?ConditionalFormattingIcon,

    /// The conditional formatting of the comparison value's text color.
    text_color: ?ConditionalFormattingColor,

    pub const json_field_names = .{
        .icon = "Icon",
        .text_color = "TextColor",
    };
};
