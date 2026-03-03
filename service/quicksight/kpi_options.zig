const ComparisonConfiguration = @import("comparison_configuration.zig").ComparisonConfiguration;
const PrimaryValueDisplayType = @import("primary_value_display_type.zig").PrimaryValueDisplayType;
const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const ProgressBarOptions = @import("progress_bar_options.zig").ProgressBarOptions;
const SecondaryValueOptions = @import("secondary_value_options.zig").SecondaryValueOptions;
const KPISparklineOptions = @import("kpi_sparkline_options.zig").KPISparklineOptions;
const TrendArrowOptions = @import("trend_arrow_options.zig").TrendArrowOptions;
const KPIVisualLayoutOptions = @import("kpi_visual_layout_options.zig").KPIVisualLayoutOptions;

/// The options that determine the presentation of a KPI visual.
pub const KPIOptions = struct {
    /// The comparison configuration of a KPI visual.
    comparison: ?ComparisonConfiguration = null,

    /// The options that determine the primary value display type.
    primary_value_display_type: ?PrimaryValueDisplayType = null,

    /// The options that determine the primary value font configuration.
    primary_value_font_configuration: ?FontConfiguration = null,

    /// The options that determine the presentation of the progress bar of a KPI
    /// visual.
    progress_bar: ?ProgressBarOptions = null,

    /// The options that determine the presentation of the secondary value of a KPI
    /// visual.
    secondary_value: ?SecondaryValueOptions = null,

    /// The options that determine the secondary value font configuration.
    secondary_value_font_configuration: ?FontConfiguration = null,

    /// The options that determine the visibility, color, type, and tooltip
    /// visibility of the sparkline of a KPI visual.
    sparkline: ?KPISparklineOptions = null,

    /// The options that determine the presentation of trend arrows in a KPI visual.
    trend_arrows: ?TrendArrowOptions = null,

    /// The options that determine the layout a KPI visual.
    visual_layout_options: ?KPIVisualLayoutOptions = null,

    pub const json_field_names = .{
        .comparison = "Comparison",
        .primary_value_display_type = "PrimaryValueDisplayType",
        .primary_value_font_configuration = "PrimaryValueFontConfiguration",
        .progress_bar = "ProgressBar",
        .secondary_value = "SecondaryValue",
        .secondary_value_font_configuration = "SecondaryValueFontConfiguration",
        .sparkline = "Sparkline",
        .trend_arrows = "TrendArrows",
        .visual_layout_options = "VisualLayoutOptions",
    };
};
