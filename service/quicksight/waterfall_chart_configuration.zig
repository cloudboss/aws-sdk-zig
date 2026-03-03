const AxisDisplayOptions = @import("axis_display_options.zig").AxisDisplayOptions;
const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const WaterfallChartColorConfiguration = @import("waterfall_chart_color_configuration.zig").WaterfallChartColorConfiguration;
const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const WaterfallChartFieldWells = @import("waterfall_chart_field_wells.zig").WaterfallChartFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const WaterfallChartSortConfiguration = @import("waterfall_chart_sort_configuration.zig").WaterfallChartSortConfiguration;
const VisualPalette = @import("visual_palette.zig").VisualPalette;
const WaterfallChartOptions = @import("waterfall_chart_options.zig").WaterfallChartOptions;

/// The configuration for a waterfall visual.
pub const WaterfallChartConfiguration = struct {
    /// The options that determine the presentation of the category axis.
    category_axis_display_options: ?AxisDisplayOptions = null,

    /// The options that determine the presentation of the category axis label.
    category_axis_label_options: ?ChartAxisLabelOptions = null,

    /// The color configuration of a waterfall visual.
    color_configuration: ?WaterfallChartColorConfiguration = null,

    /// The data label configuration of a waterfall visual.
    data_labels: ?DataLabelOptions = null,

    /// The field well configuration of a waterfall visual.
    field_wells: ?WaterfallChartFieldWells = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The legend configuration of a waterfall visual.
    legend: ?LegendOptions = null,

    /// The options that determine the presentation of the y-axis.
    primary_y_axis_display_options: ?AxisDisplayOptions = null,

    /// The options that determine the presentation of the y-axis label.
    primary_y_axis_label_options: ?ChartAxisLabelOptions = null,

    /// The sort configuration of a waterfall visual.
    sort_configuration: ?WaterfallChartSortConfiguration = null,

    /// The visual palette configuration of a waterfall visual.
    visual_palette: ?VisualPalette = null,

    /// The options that determine the presentation of a waterfall visual.
    waterfall_chart_options: ?WaterfallChartOptions = null,

    pub const json_field_names = .{
        .category_axis_display_options = "CategoryAxisDisplayOptions",
        .category_axis_label_options = "CategoryAxisLabelOptions",
        .color_configuration = "ColorConfiguration",
        .data_labels = "DataLabels",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .legend = "Legend",
        .primary_y_axis_display_options = "PrimaryYAxisDisplayOptions",
        .primary_y_axis_label_options = "PrimaryYAxisLabelOptions",
        .sort_configuration = "SortConfiguration",
        .visual_palette = "VisualPalette",
        .waterfall_chart_options = "WaterfallChartOptions",
    };
};
