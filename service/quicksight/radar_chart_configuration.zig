const Visibility = @import("visibility.zig").Visibility;
const RadarChartAxesRangeScale = @import("radar_chart_axes_range_scale.zig").RadarChartAxesRangeScale;
const RadarChartSeriesSettings = @import("radar_chart_series_settings.zig").RadarChartSeriesSettings;
const AxisDisplayOptions = @import("axis_display_options.zig").AxisDisplayOptions;
const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const RadarChartFieldWells = @import("radar_chart_field_wells.zig").RadarChartFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const RadarChartShape = @import("radar_chart_shape.zig").RadarChartShape;
const RadarChartSortConfiguration = @import("radar_chart_sort_configuration.zig").RadarChartSortConfiguration;
const VisualPalette = @import("visual_palette.zig").VisualPalette;

/// The configuration of a `RadarChartVisual`.
pub const RadarChartConfiguration = struct {
    /// Determines the visibility of the colors of alternatign bands in a radar
    /// chart.
    alternate_band_colors_visibility: ?Visibility = null,

    /// The color of the even-numbered alternate bands of a radar chart.
    alternate_band_even_color: ?[]const u8 = null,

    /// The color of the odd-numbered alternate bands of a radar chart.
    alternate_band_odd_color: ?[]const u8 = null,

    /// The axis behavior options of a radar chart.
    axes_range_scale: ?RadarChartAxesRangeScale = null,

    /// The base sreies settings of a radar chart.
    base_series_settings: ?RadarChartSeriesSettings = null,

    /// The category axis of a radar chart.
    category_axis: ?AxisDisplayOptions = null,

    /// The category label options of a radar chart.
    category_label_options: ?ChartAxisLabelOptions = null,

    /// The color axis of a radar chart.
    color_axis: ?AxisDisplayOptions = null,

    /// The color label options of a radar chart.
    color_label_options: ?ChartAxisLabelOptions = null,

    /// The field well configuration of a `RadarChartVisual`.
    field_wells: ?RadarChartFieldWells = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The legend display setup of the visual.
    legend: ?LegendOptions = null,

    /// The shape of the radar chart.
    shape: ?RadarChartShape = null,

    /// The sort configuration of a `RadarChartVisual`.
    sort_configuration: ?RadarChartSortConfiguration = null,

    /// The start angle of a radar chart's axis.
    start_angle: ?f64 = null,

    /// The palette (chart color) display setup of the visual.
    visual_palette: ?VisualPalette = null,

    pub const json_field_names = .{
        .alternate_band_colors_visibility = "AlternateBandColorsVisibility",
        .alternate_band_even_color = "AlternateBandEvenColor",
        .alternate_band_odd_color = "AlternateBandOddColor",
        .axes_range_scale = "AxesRangeScale",
        .base_series_settings = "BaseSeriesSettings",
        .category_axis = "CategoryAxis",
        .category_label_options = "CategoryLabelOptions",
        .color_axis = "ColorAxis",
        .color_label_options = "ColorLabelOptions",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .legend = "Legend",
        .shape = "Shape",
        .sort_configuration = "SortConfiguration",
        .start_angle = "StartAngle",
        .visual_palette = "VisualPalette",
    };
};
