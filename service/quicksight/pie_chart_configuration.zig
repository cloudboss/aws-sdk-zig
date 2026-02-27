const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const ContributionAnalysisDefault = @import("contribution_analysis_default.zig").ContributionAnalysisDefault;
const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const DonutOptions = @import("donut_options.zig").DonutOptions;
const PieChartFieldWells = @import("pie_chart_field_wells.zig").PieChartFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const SmallMultiplesOptions = @import("small_multiples_options.zig").SmallMultiplesOptions;
const PieChartSortConfiguration = @import("pie_chart_sort_configuration.zig").PieChartSortConfiguration;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const VisualPalette = @import("visual_palette.zig").VisualPalette;

/// The configuration of a pie chart.
pub const PieChartConfiguration = struct {
    /// The label options of the group/color that is displayed in a pie chart.
    category_label_options: ?ChartAxisLabelOptions,

    /// The contribution analysis (anomaly configuration) setup of the visual.
    contribution_analysis_defaults: ?[]const ContributionAnalysisDefault,

    /// The options that determine if visual data labels are displayed.
    data_labels: ?DataLabelOptions,

    /// The options that determine the shape of the chart. This option determines
    /// whether the chart is a pie chart or a donut chart.
    donut_options: ?DonutOptions,

    /// The field wells of the visual.
    field_wells: ?PieChartFieldWells,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions,

    /// The legend display setup of the visual.
    legend: ?LegendOptions,

    /// The small multiples setup for the visual.
    small_multiples_options: ?SmallMultiplesOptions,

    /// The sort configuration of a pie chart.
    sort_configuration: ?PieChartSortConfiguration,

    /// The tooltip display setup of the visual.
    tooltip: ?TooltipOptions,

    /// The label options for the value that is displayed in a pie chart.
    value_label_options: ?ChartAxisLabelOptions,

    /// The palette (chart color) display setup of the visual.
    visual_palette: ?VisualPalette,

    pub const json_field_names = .{
        .category_label_options = "CategoryLabelOptions",
        .contribution_analysis_defaults = "ContributionAnalysisDefaults",
        .data_labels = "DataLabels",
        .donut_options = "DonutOptions",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .legend = "Legend",
        .small_multiples_options = "SmallMultiplesOptions",
        .sort_configuration = "SortConfiguration",
        .tooltip = "Tooltip",
        .value_label_options = "ValueLabelOptions",
        .visual_palette = "VisualPalette",
    };
};
