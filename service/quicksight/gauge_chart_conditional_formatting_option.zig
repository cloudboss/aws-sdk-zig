const GaugeChartArcConditionalFormatting = @import("gauge_chart_arc_conditional_formatting.zig").GaugeChartArcConditionalFormatting;
const GaugeChartPrimaryValueConditionalFormatting = @import("gauge_chart_primary_value_conditional_formatting.zig").GaugeChartPrimaryValueConditionalFormatting;

/// Conditional formatting options of a `GaugeChartVisual`.
pub const GaugeChartConditionalFormattingOption = struct {
    /// The options that determine the presentation of the arc of a
    /// `GaugeChartVisual`.
    arc: ?GaugeChartArcConditionalFormatting = null,

    /// The conditional formatting for the primary value of a `GaugeChartVisual`.
    primary_value: ?GaugeChartPrimaryValueConditionalFormatting = null,

    pub const json_field_names = .{
        .arc = "Arc",
        .primary_value = "PrimaryValue",
    };
};
