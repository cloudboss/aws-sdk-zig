const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const BarsArrangement = @import("bars_arrangement.zig").BarsArrangement;
const AxisDisplayOptions = @import("axis_display_options.zig").AxisDisplayOptions;
const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const ComboChartDefaultSeriesSettings = @import("combo_chart_default_series_settings.zig").ComboChartDefaultSeriesSettings;
const ComboChartFieldWells = @import("combo_chart_field_wells.zig").ComboChartFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const ReferenceLine = @import("reference_line.zig").ReferenceLine;
const ComboSeriesItem = @import("combo_series_item.zig").ComboSeriesItem;
const SingleAxisOptions = @import("single_axis_options.zig").SingleAxisOptions;
const ComboChartSortConfiguration = @import("combo_chart_sort_configuration.zig").ComboChartSortConfiguration;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const VisualPalette = @import("visual_palette.zig").VisualPalette;

/// The configuration of a `ComboChartVisual`.
pub const ComboChartConfiguration = struct {
    /// The options that determine if visual data labels are displayed.
    ///
    /// The data label options for a bar in a combo chart.
    bar_data_labels: ?DataLabelOptions,

    /// Determines the bar arrangement in a combo chart. The following are valid
    /// values in this structure:
    ///
    /// * `CLUSTERED`: For clustered bar combo charts.
    ///
    /// * `STACKED`: For stacked bar combo charts.
    ///
    /// * `STACKED_PERCENT`: Do not use. If you use this value, the operation
    ///   returns a validation error.
    bars_arrangement: ?BarsArrangement,

    /// The category axis of a combo chart.
    category_axis: ?AxisDisplayOptions,

    /// The label options (label text, label visibility, and sort icon visibility)
    /// of a combo chart category (group/color) field well.
    category_label_options: ?ChartAxisLabelOptions,

    /// The label options (label text, label visibility, and sort icon visibility)
    /// of a combo chart's color field well.
    color_label_options: ?ChartAxisLabelOptions,

    /// The options that determine the default presentation of all series in
    /// `ComboChartVisual`.
    default_series_settings: ?ComboChartDefaultSeriesSettings,

    /// The field wells of the visual.
    field_wells: ?ComboChartFieldWells,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions,

    /// The legend display setup of the visual.
    legend: ?LegendOptions,

    /// The options that determine if visual data labels are displayed.
    ///
    /// The data label options for a line in a combo chart.
    line_data_labels: ?DataLabelOptions,

    /// The label display options (grid line, range, scale, and axis step) of a
    /// combo chart's primary y-axis (bar) field well.
    primary_y_axis_display_options: ?AxisDisplayOptions,

    /// The label options (label text, label visibility, and sort icon visibility)
    /// of a combo chart's primary y-axis (bar) field well.
    primary_y_axis_label_options: ?ChartAxisLabelOptions,

    /// The reference line setup of the visual.
    reference_lines: ?[]const ReferenceLine,

    /// The label display options (grid line, range, scale, axis step) of a combo
    /// chart's secondary y-axis (line) field well.
    secondary_y_axis_display_options: ?AxisDisplayOptions,

    /// The label options (label text, label visibility, and sort icon visibility)
    /// of a combo chart's secondary y-axis(line) field well.
    secondary_y_axis_label_options: ?ChartAxisLabelOptions,

    /// The series item configuration of a `ComboChartVisual`.
    series: ?[]const ComboSeriesItem,

    single_axis_options: ?SingleAxisOptions,

    /// The sort configuration of a `ComboChartVisual`.
    sort_configuration: ?ComboChartSortConfiguration,

    /// The legend display setup of the visual.
    tooltip: ?TooltipOptions,

    /// The palette (chart color) display setup of the visual.
    visual_palette: ?VisualPalette,

    pub const json_field_names = .{
        .bar_data_labels = "BarDataLabels",
        .bars_arrangement = "BarsArrangement",
        .category_axis = "CategoryAxis",
        .category_label_options = "CategoryLabelOptions",
        .color_label_options = "ColorLabelOptions",
        .default_series_settings = "DefaultSeriesSettings",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .legend = "Legend",
        .line_data_labels = "LineDataLabels",
        .primary_y_axis_display_options = "PrimaryYAxisDisplayOptions",
        .primary_y_axis_label_options = "PrimaryYAxisLabelOptions",
        .reference_lines = "ReferenceLines",
        .secondary_y_axis_display_options = "SecondaryYAxisDisplayOptions",
        .secondary_y_axis_label_options = "SecondaryYAxisLabelOptions",
        .series = "Series",
        .single_axis_options = "SingleAxisOptions",
        .sort_configuration = "SortConfiguration",
        .tooltip = "Tooltip",
        .visual_palette = "VisualPalette",
    };
};
