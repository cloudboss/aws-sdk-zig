const ConditionalFormattingColor = @import("conditional_formatting_color.zig").ConditionalFormattingColor;

/// The conditional formatting for the progress bar of a KPI visual.
pub const KPIProgressBarConditionalFormatting = struct {
    /// The conditional formatting of the progress bar's foreground color.
    foreground_color: ?ConditionalFormattingColor,

    pub const json_field_names = .{
        .foreground_color = "ForegroundColor",
    };
};
