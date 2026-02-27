const BarsArrangement = @import("bars_arrangement.zig").BarsArrangement;
const AxisDisplayOptions = @import("axis_display_options.zig").AxisDisplayOptions;
const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const ContributionAnalysisDefault = @import("contribution_analysis_default.zig").ContributionAnalysisDefault;
const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const BarChartDefaultSeriesSettings = @import("bar_chart_default_series_settings.zig").BarChartDefaultSeriesSettings;
const BarChartFieldWells = @import("bar_chart_field_wells.zig").BarChartFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const BarChartOrientation = @import("bar_chart_orientation.zig").BarChartOrientation;
const ReferenceLine = @import("reference_line.zig").ReferenceLine;
const BarSeriesItem = @import("bar_series_item.zig").BarSeriesItem;
const SmallMultiplesOptions = @import("small_multiples_options.zig").SmallMultiplesOptions;
const BarChartSortConfiguration = @import("bar_chart_sort_configuration.zig").BarChartSortConfiguration;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const VisualPalette = @import("visual_palette.zig").VisualPalette;

/// The configuration of a `BarChartVisual`.
pub const BarChartConfiguration = struct {
    /// Determines the arrangement of the bars. The orientation and arrangement of
    /// bars determine the type of bar that is used in the visual.
    bars_arrangement: ?BarsArrangement,

    /// The label display options (grid line, range, scale, axis step) for bar chart
    /// category.
    category_axis: ?AxisDisplayOptions,

    /// The label options (label text, label visibility and sort icon visibility)
    /// for a bar chart.
    category_label_options: ?ChartAxisLabelOptions,

    /// The label options (label text, label visibility and sort icon visibility)
    /// for a color that is used in a bar chart.
    color_label_options: ?ChartAxisLabelOptions,

    /// The contribution analysis (anomaly configuration) setup of the visual.
    contribution_analysis_defaults: ?[]const ContributionAnalysisDefault,

    /// The options that determine if visual data labels are displayed.
    data_labels: ?DataLabelOptions,

    /// The options that determine the default presentation of all bar series in
    /// `BarChartVisual`.
    default_series_settings: ?BarChartDefaultSeriesSettings,

    /// The field wells of the visual.
    field_wells: ?BarChartFieldWells,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions,

    /// The legend display setup of the visual.
    legend: ?LegendOptions,

    /// The orientation of the bars in a bar chart visual. There are two valid
    /// values in this structure:
    ///
    /// * `HORIZONTAL`: Used for charts that have horizontal bars. Visuals that use
    ///   this value are horizontal bar charts, horizontal stacked bar charts, and
    ///   horizontal stacked 100% bar charts.
    ///
    /// * `VERTICAL`: Used for charts that have vertical bars. Visuals that use this
    ///   value are vertical bar charts, vertical stacked bar charts, and vertical
    ///   stacked 100% bar charts.
    orientation: ?BarChartOrientation,

    /// The reference line setup of the visual.
    reference_lines: ?[]const ReferenceLine,

    /// The series item configuration of a `BarChartVisual`.
    series: ?[]const BarSeriesItem,

    /// The small multiples setup for the visual.
    small_multiples_options: ?SmallMultiplesOptions,

    /// The sort configuration of a `BarChartVisual`.
    sort_configuration: ?BarChartSortConfiguration,

    /// The tooltip display setup of the visual.
    tooltip: ?TooltipOptions,

    /// The label display options (grid line, range, scale, axis step) for a bar
    /// chart value.
    value_axis: ?AxisDisplayOptions,

    /// The label options (label text, label visibility and sort icon visibility)
    /// for a bar chart value.
    value_label_options: ?ChartAxisLabelOptions,

    /// The palette (chart color) display setup of the visual.
    visual_palette: ?VisualPalette,

    pub const json_field_names = .{
        .bars_arrangement = "BarsArrangement",
        .category_axis = "CategoryAxis",
        .category_label_options = "CategoryLabelOptions",
        .color_label_options = "ColorLabelOptions",
        .contribution_analysis_defaults = "ContributionAnalysisDefaults",
        .data_labels = "DataLabels",
        .default_series_settings = "DefaultSeriesSettings",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .legend = "Legend",
        .orientation = "Orientation",
        .reference_lines = "ReferenceLines",
        .series = "Series",
        .small_multiples_options = "SmallMultiplesOptions",
        .sort_configuration = "SortConfiguration",
        .tooltip = "Tooltip",
        .value_axis = "ValueAxis",
        .value_label_options = "ValueLabelOptions",
        .visual_palette = "VisualPalette",
    };
};
