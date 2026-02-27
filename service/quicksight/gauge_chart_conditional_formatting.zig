const GaugeChartConditionalFormattingOption = @import("gauge_chart_conditional_formatting_option.zig").GaugeChartConditionalFormattingOption;

/// The conditional formatting of a `GaugeChartVisual`.
pub const GaugeChartConditionalFormatting = struct {
    /// Conditional formatting options of a `GaugeChartVisual`.
    conditional_formatting_options: ?[]const GaugeChartConditionalFormattingOption,

    pub const json_field_names = .{
        .conditional_formatting_options = "ConditionalFormattingOptions",
    };
};
