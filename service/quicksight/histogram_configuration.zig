const HistogramBinOptions = @import("histogram_bin_options.zig").HistogramBinOptions;
const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const HistogramFieldWells = @import("histogram_field_wells.zig").HistogramFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const VisualPalette = @import("visual_palette.zig").VisualPalette;
const AxisDisplayOptions = @import("axis_display_options.zig").AxisDisplayOptions;
const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;

/// The configuration for a `HistogramVisual`.
pub const HistogramConfiguration = struct {
    /// The options that determine the presentation of histogram bins.
    bin_options: ?HistogramBinOptions,

    /// The data label configuration of a histogram.
    data_labels: ?DataLabelOptions,

    /// The field well configuration of a histogram.
    field_wells: ?HistogramFieldWells,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions,

    /// The tooltip configuration of a histogram.
    tooltip: ?TooltipOptions,

    /// The visual palette configuration of a histogram.
    visual_palette: ?VisualPalette,

    /// The options that determine the presentation of the x-axis.
    x_axis_display_options: ?AxisDisplayOptions,

    /// The options that determine the presentation of the x-axis label.
    x_axis_label_options: ?ChartAxisLabelOptions,

    /// The options that determine the presentation of the y-axis.
    y_axis_display_options: ?AxisDisplayOptions,

    pub const json_field_names = .{
        .bin_options = "BinOptions",
        .data_labels = "DataLabels",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .tooltip = "Tooltip",
        .visual_palette = "VisualPalette",
        .x_axis_display_options = "XAxisDisplayOptions",
        .x_axis_label_options = "XAxisLabelOptions",
        .y_axis_display_options = "YAxisDisplayOptions",
    };
};
