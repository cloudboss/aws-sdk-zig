const ColorScale = @import("color_scale.zig").ColorScale;
const AxisDisplayOptions = @import("axis_display_options.zig").AxisDisplayOptions;
const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const HeatMapFieldWells = @import("heat_map_field_wells.zig").HeatMapFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const HeatMapSortConfiguration = @import("heat_map_sort_configuration.zig").HeatMapSortConfiguration;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;

/// The configuration of a heat map.
pub const HeatMapConfiguration = struct {
    /// The color options (gradient color, point of divergence) in a heat map.
    color_scale: ?ColorScale = null,

    /// The options that determine the presentation of the row axis label.
    column_axis_display_options: ?AxisDisplayOptions = null,

    /// The label options of the column that is displayed in a heat map.
    column_label_options: ?ChartAxisLabelOptions = null,

    /// The options that determine if visual data labels are displayed.
    data_labels: ?DataLabelOptions = null,

    /// The field wells of the visual.
    field_wells: ?HeatMapFieldWells = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The legend display setup of the visual.
    legend: ?LegendOptions = null,

    /// The options that determine the presentation of the row axis label.
    row_axis_display_options: ?AxisDisplayOptions = null,

    /// The label options of the row that is displayed in a `heat map`.
    row_label_options: ?ChartAxisLabelOptions = null,

    /// The sort configuration of a heat map.
    sort_configuration: ?HeatMapSortConfiguration = null,

    /// The tooltip display setup of the visual.
    tooltip: ?TooltipOptions = null,

    pub const json_field_names = .{
        .color_scale = "ColorScale",
        .column_axis_display_options = "ColumnAxisDisplayOptions",
        .column_label_options = "ColumnLabelOptions",
        .data_labels = "DataLabels",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .legend = "Legend",
        .row_axis_display_options = "RowAxisDisplayOptions",
        .row_label_options = "RowLabelOptions",
        .sort_configuration = "SortConfiguration",
        .tooltip = "Tooltip",
    };
};
