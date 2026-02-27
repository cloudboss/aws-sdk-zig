const BoxPlotOptions = @import("box_plot_options.zig").BoxPlotOptions;
const AxisDisplayOptions = @import("axis_display_options.zig").AxisDisplayOptions;
const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const BoxPlotFieldWells = @import("box_plot_field_wells.zig").BoxPlotFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const ReferenceLine = @import("reference_line.zig").ReferenceLine;
const BoxPlotSortConfiguration = @import("box_plot_sort_configuration.zig").BoxPlotSortConfiguration;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const VisualPalette = @import("visual_palette.zig").VisualPalette;

/// The configuration of a `BoxPlotVisual`.
pub const BoxPlotChartConfiguration = struct {
    /// The box plot chart options for a box plot visual
    box_plot_options: ?BoxPlotOptions,

    /// The label display options (grid line, range, scale, axis step) of a box plot
    /// category.
    category_axis: ?AxisDisplayOptions,

    /// The label options (label text, label visibility and sort Icon visibility) of
    /// a box plot category.
    category_label_options: ?ChartAxisLabelOptions,

    /// The field wells of the visual.
    field_wells: ?BoxPlotFieldWells,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions,

    legend: ?LegendOptions,

    /// The label display options (grid line, range, scale, axis step) of a box plot
    /// category.
    primary_y_axis_display_options: ?AxisDisplayOptions,

    /// The label options (label text, label visibility and sort icon visibility) of
    /// a box plot value.
    primary_y_axis_label_options: ?ChartAxisLabelOptions,

    /// The reference line setup of the visual.
    reference_lines: ?[]const ReferenceLine,

    /// The sort configuration of a `BoxPlotVisual`.
    sort_configuration: ?BoxPlotSortConfiguration,

    /// The tooltip display setup of the visual.
    tooltip: ?TooltipOptions,

    /// The palette (chart color) display setup of the visual.
    visual_palette: ?VisualPalette,

    pub const json_field_names = .{
        .box_plot_options = "BoxPlotOptions",
        .category_axis = "CategoryAxis",
        .category_label_options = "CategoryLabelOptions",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .legend = "Legend",
        .primary_y_axis_display_options = "PrimaryYAxisDisplayOptions",
        .primary_y_axis_label_options = "PrimaryYAxisLabelOptions",
        .reference_lines = "ReferenceLines",
        .sort_configuration = "SortConfiguration",
        .tooltip = "Tooltip",
        .visual_palette = "VisualPalette",
    };
};
