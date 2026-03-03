const ContributionAnalysisDefault = @import("contribution_analysis_default.zig").ContributionAnalysisDefault;
const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const LineChartDefaultSeriesSettings = @import("line_chart_default_series_settings.zig").LineChartDefaultSeriesSettings;
const LineChartFieldWells = @import("line_chart_field_wells.zig").LineChartFieldWells;
const ForecastConfiguration = @import("forecast_configuration.zig").ForecastConfiguration;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const LineSeriesAxisDisplayOptions = @import("line_series_axis_display_options.zig").LineSeriesAxisDisplayOptions;
const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const ReferenceLine = @import("reference_line.zig").ReferenceLine;
const SeriesItem = @import("series_item.zig").SeriesItem;
const SingleAxisOptions = @import("single_axis_options.zig").SingleAxisOptions;
const SmallMultiplesOptions = @import("small_multiples_options.zig").SmallMultiplesOptions;
const LineChartSortConfiguration = @import("line_chart_sort_configuration.zig").LineChartSortConfiguration;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const LineChartType = @import("line_chart_type.zig").LineChartType;
const VisualPalette = @import("visual_palette.zig").VisualPalette;
const AxisDisplayOptions = @import("axis_display_options.zig").AxisDisplayOptions;

/// The configuration of a line chart.
pub const LineChartConfiguration = struct {
    /// The default configuration of a line chart's contribution analysis.
    contribution_analysis_defaults: ?[]const ContributionAnalysisDefault = null,

    /// The data label configuration of a line chart.
    data_labels: ?DataLabelOptions = null,

    /// The options that determine the default presentation of all line series in
    /// `LineChartVisual`.
    default_series_settings: ?LineChartDefaultSeriesSettings = null,

    /// The field well configuration of a line chart.
    field_wells: ?LineChartFieldWells = null,

    /// The forecast configuration of a line chart.
    forecast_configurations: ?[]const ForecastConfiguration = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The legend configuration of a line chart.
    legend: ?LegendOptions = null,

    /// The series axis configuration of a line chart.
    primary_y_axis_display_options: ?LineSeriesAxisDisplayOptions = null,

    /// The options that determine the presentation of the y-axis label.
    primary_y_axis_label_options: ?ChartAxisLabelOptions = null,

    /// The reference lines configuration of a line chart.
    reference_lines: ?[]const ReferenceLine = null,

    /// The series axis configuration of a line chart.
    secondary_y_axis_display_options: ?LineSeriesAxisDisplayOptions = null,

    /// The options that determine the presentation of the secondary y-axis label.
    secondary_y_axis_label_options: ?ChartAxisLabelOptions = null,

    /// The series item configuration of a line chart.
    series: ?[]const SeriesItem = null,

    single_axis_options: ?SingleAxisOptions = null,

    /// The small multiples setup for the visual.
    small_multiples_options: ?SmallMultiplesOptions = null,

    /// The sort configuration of a line chart.
    sort_configuration: ?LineChartSortConfiguration = null,

    /// The tooltip configuration of a line chart.
    tooltip: ?TooltipOptions = null,

    /// Determines the type of the line chart.
    @"type": ?LineChartType = null,

    /// The visual palette configuration of a line chart.
    visual_palette: ?VisualPalette = null,

    /// The options that determine the presentation of the x-axis.
    x_axis_display_options: ?AxisDisplayOptions = null,

    /// The options that determine the presentation of the x-axis label.
    x_axis_label_options: ?ChartAxisLabelOptions = null,

    pub const json_field_names = .{
        .contribution_analysis_defaults = "ContributionAnalysisDefaults",
        .data_labels = "DataLabels",
        .default_series_settings = "DefaultSeriesSettings",
        .field_wells = "FieldWells",
        .forecast_configurations = "ForecastConfigurations",
        .interactions = "Interactions",
        .legend = "Legend",
        .primary_y_axis_display_options = "PrimaryYAxisDisplayOptions",
        .primary_y_axis_label_options = "PrimaryYAxisLabelOptions",
        .reference_lines = "ReferenceLines",
        .secondary_y_axis_display_options = "SecondaryYAxisDisplayOptions",
        .secondary_y_axis_label_options = "SecondaryYAxisLabelOptions",
        .series = "Series",
        .single_axis_options = "SingleAxisOptions",
        .small_multiples_options = "SmallMultiplesOptions",
        .sort_configuration = "SortConfiguration",
        .tooltip = "Tooltip",
        .@"type" = "Type",
        .visual_palette = "VisualPalette",
        .x_axis_display_options = "XAxisDisplayOptions",
        .x_axis_label_options = "XAxisLabelOptions",
    };
};
