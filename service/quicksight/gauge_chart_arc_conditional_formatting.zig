const ConditionalFormattingColor = @import("conditional_formatting_color.zig").ConditionalFormattingColor;

/// The options that determine the presentation of the arc of a
/// `GaugeChartVisual`.
pub const GaugeChartArcConditionalFormatting = struct {
    /// The conditional formatting of the arc foreground color.
    foreground_color: ?ConditionalFormattingColor = null,

    pub const json_field_names = .{
        .foreground_color = "ForegroundColor",
    };
};
