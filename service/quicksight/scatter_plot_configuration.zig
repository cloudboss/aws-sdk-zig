const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const ScatterPlotFieldWells = @import("scatter_plot_field_wells.zig").ScatterPlotFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const ScatterPlotSortConfiguration = @import("scatter_plot_sort_configuration.zig").ScatterPlotSortConfiguration;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const VisualPalette = @import("visual_palette.zig").VisualPalette;
const AxisDisplayOptions = @import("axis_display_options.zig").AxisDisplayOptions;
const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;

/// The configuration of a scatter plot.
pub const ScatterPlotConfiguration = struct {
    /// The options that determine if visual data labels are displayed.
    data_labels: ?DataLabelOptions = null,

    /// The field wells of the visual.
    field_wells: ?ScatterPlotFieldWells = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The legend display setup of the visual.
    legend: ?LegendOptions = null,

    /// The sort configuration of a scatter plot.
    sort_configuration: ?ScatterPlotSortConfiguration = null,

    /// The legend display setup of the visual.
    tooltip: ?TooltipOptions = null,

    /// The palette (chart color) display setup of the visual.
    visual_palette: ?VisualPalette = null,

    /// The label display options (grid line, range, scale, and axis step) of the
    /// scatter plot's x-axis.
    x_axis_display_options: ?AxisDisplayOptions = null,

    /// The label options (label text, label visibility, and sort icon visibility)
    /// of the scatter plot's x-axis.
    x_axis_label_options: ?ChartAxisLabelOptions = null,

    /// The label display options (grid line, range, scale, and axis step) of the
    /// scatter plot's y-axis.
    y_axis_display_options: ?AxisDisplayOptions = null,

    /// The label options (label text, label visibility, and sort icon visibility)
    /// of the scatter plot's y-axis.
    y_axis_label_options: ?ChartAxisLabelOptions = null,

    pub const json_field_names = .{
        .data_labels = "DataLabels",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .legend = "Legend",
        .sort_configuration = "SortConfiguration",
        .tooltip = "Tooltip",
        .visual_palette = "VisualPalette",
        .x_axis_display_options = "XAxisDisplayOptions",
        .x_axis_label_options = "XAxisLabelOptions",
        .y_axis_display_options = "YAxisDisplayOptions",
        .y_axis_label_options = "YAxisLabelOptions",
    };
};
