const Visibility = @import("visibility.zig").Visibility;
const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const FunnelChartMeasureDataLabelStyle = @import("funnel_chart_measure_data_label_style.zig").FunnelChartMeasureDataLabelStyle;
const DataLabelPosition = @import("data_label_position.zig").DataLabelPosition;

/// The options that determine the presentation of the data labels.
pub const FunnelChartDataLabelOptions = struct {
    /// The visibility of the category labels within the data labels.
    category_label_visibility: ?Visibility = null,

    /// The color of the data label text.
    label_color: ?[]const u8 = null,

    /// The font configuration for the data labels.
    ///
    /// Only the `FontSize` attribute of the font configuration is used for data
    /// labels.
    label_font_configuration: ?FontConfiguration = null,

    /// Determines the style of the metric labels.
    measure_data_label_style: ?FunnelChartMeasureDataLabelStyle = null,

    /// The visibility of the measure labels within the data labels.
    measure_label_visibility: ?Visibility = null,

    /// Determines the positioning of the data label relative to a section of the
    /// funnel.
    position: ?DataLabelPosition = null,

    /// The visibility option that determines if data labels are displayed.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .category_label_visibility = "CategoryLabelVisibility",
        .label_color = "LabelColor",
        .label_font_configuration = "LabelFontConfiguration",
        .measure_data_label_style = "MeasureDataLabelStyle",
        .measure_label_visibility = "MeasureLabelVisibility",
        .position = "Position",
        .visibility = "Visibility",
    };
};
