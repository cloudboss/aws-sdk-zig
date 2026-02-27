const GaugeChartColorConfiguration = @import("gauge_chart_color_configuration.zig").GaugeChartColorConfiguration;
const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const GaugeChartFieldWells = @import("gauge_chart_field_wells.zig").GaugeChartFieldWells;
const GaugeChartOptions = @import("gauge_chart_options.zig").GaugeChartOptions;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const VisualPalette = @import("visual_palette.zig").VisualPalette;

/// The configuration of a `GaugeChartVisual`.
pub const GaugeChartConfiguration = struct {
    /// The color configuration of a `GaugeChartVisual`.
    color_configuration: ?GaugeChartColorConfiguration,

    /// The data label configuration of a `GaugeChartVisual`.
    data_labels: ?DataLabelOptions,

    /// The field well configuration of a `GaugeChartVisual`.
    field_wells: ?GaugeChartFieldWells,

    /// The options that determine the presentation of the `GaugeChartVisual`.
    gauge_chart_options: ?GaugeChartOptions,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions,

    /// The tooltip configuration of a `GaugeChartVisual`.
    tooltip_options: ?TooltipOptions,

    /// The visual palette configuration of a `GaugeChartVisual`.
    visual_palette: ?VisualPalette,

    pub const json_field_names = .{
        .color_configuration = "ColorConfiguration",
        .data_labels = "DataLabels",
        .field_wells = "FieldWells",
        .gauge_chart_options = "GaugeChartOptions",
        .interactions = "Interactions",
        .tooltip_options = "TooltipOptions",
        .visual_palette = "VisualPalette",
    };
};
