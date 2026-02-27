const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const FunnelChartDataLabelOptions = @import("funnel_chart_data_label_options.zig").FunnelChartDataLabelOptions;
const FunnelChartFieldWells = @import("funnel_chart_field_wells.zig").FunnelChartFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const FunnelChartSortConfiguration = @import("funnel_chart_sort_configuration.zig").FunnelChartSortConfiguration;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const VisualPalette = @import("visual_palette.zig").VisualPalette;

/// The configuration of a `FunnelChartVisual`.
pub const FunnelChartConfiguration = struct {
    /// The label options of the categories that are displayed in a
    /// `FunnelChartVisual`.
    category_label_options: ?ChartAxisLabelOptions,

    /// The options that determine the presentation of the data labels.
    data_label_options: ?FunnelChartDataLabelOptions,

    /// The field well configuration of a `FunnelChartVisual`.
    field_wells: ?FunnelChartFieldWells,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions,

    /// The sort configuration of a `FunnelChartVisual`.
    sort_configuration: ?FunnelChartSortConfiguration,

    /// The tooltip configuration of a `FunnelChartVisual`.
    tooltip: ?TooltipOptions,

    /// The label options for the values that are displayed in a
    /// `FunnelChartVisual`.
    value_label_options: ?ChartAxisLabelOptions,

    /// The visual palette configuration of a `FunnelChartVisual`.
    visual_palette: ?VisualPalette,

    pub const json_field_names = .{
        .category_label_options = "CategoryLabelOptions",
        .data_label_options = "DataLabelOptions",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .sort_configuration = "SortConfiguration",
        .tooltip = "Tooltip",
        .value_label_options = "ValueLabelOptions",
        .visual_palette = "VisualPalette",
    };
};
