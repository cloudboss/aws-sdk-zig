const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const ColorScale = @import("color_scale.zig").ColorScale;
const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const TreeMapFieldWells = @import("tree_map_field_wells.zig").TreeMapFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const TreeMapSortConfiguration = @import("tree_map_sort_configuration.zig").TreeMapSortConfiguration;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;

/// The configuration of a tree map.
pub const TreeMapConfiguration = struct {
    /// The label options (label text, label visibility) for the colors displayed in
    /// a tree map.
    color_label_options: ?ChartAxisLabelOptions,

    /// The color options (gradient color, point of divergence) of a tree map.
    color_scale: ?ColorScale,

    /// The options that determine if visual data labels are displayed.
    data_labels: ?DataLabelOptions,

    /// The field wells of the visual.
    field_wells: ?TreeMapFieldWells,

    /// The label options (label text, label visibility) of the groups that are
    /// displayed in a tree map.
    group_label_options: ?ChartAxisLabelOptions,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions,

    /// The legend display setup of the visual.
    legend: ?LegendOptions,

    /// The label options (label text, label visibility) of the sizes that are
    /// displayed in a tree map.
    size_label_options: ?ChartAxisLabelOptions,

    /// The sort configuration of a tree map.
    sort_configuration: ?TreeMapSortConfiguration,

    /// The tooltip display setup of the visual.
    tooltip: ?TooltipOptions,

    pub const json_field_names = .{
        .color_label_options = "ColorLabelOptions",
        .color_scale = "ColorScale",
        .data_labels = "DataLabels",
        .field_wells = "FieldWells",
        .group_label_options = "GroupLabelOptions",
        .interactions = "Interactions",
        .legend = "Legend",
        .size_label_options = "SizeLabelOptions",
        .sort_configuration = "SortConfiguration",
        .tooltip = "Tooltip",
    };
};
