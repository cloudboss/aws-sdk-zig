const ArcConfiguration = @import("arc_configuration.zig").ArcConfiguration;
const ArcAxisConfiguration = @import("arc_axis_configuration.zig").ArcAxisConfiguration;
const ComparisonConfiguration = @import("comparison_configuration.zig").ComparisonConfiguration;
const PrimaryValueDisplayType = @import("primary_value_display_type.zig").PrimaryValueDisplayType;
const FontConfiguration = @import("font_configuration.zig").FontConfiguration;

/// The options that determine the presentation of the `GaugeChartVisual`.
pub const GaugeChartOptions = struct {
    /// The arc configuration of a `GaugeChartVisual`.
    arc: ?ArcConfiguration = null,

    /// The arc axis configuration of a `GaugeChartVisual`.
    arc_axis: ?ArcAxisConfiguration = null,

    /// The comparison configuration of a `GaugeChartVisual`.
    comparison: ?ComparisonConfiguration = null,

    /// The options that determine the primary value display type.
    primary_value_display_type: ?PrimaryValueDisplayType = null,

    /// The options that determine the primary value font configuration.
    primary_value_font_configuration: ?FontConfiguration = null,

    pub const json_field_names = .{
        .arc = "Arc",
        .arc_axis = "ArcAxis",
        .comparison = "Comparison",
        .primary_value_display_type = "PrimaryValueDisplayType",
        .primary_value_font_configuration = "PrimaryValueFontConfiguration",
    };
};
