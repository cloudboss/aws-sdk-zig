const RadarChartAreaStyleSettings = @import("radar_chart_area_style_settings.zig").RadarChartAreaStyleSettings;

/// The series settings of a radar chart.
pub const RadarChartSeriesSettings = struct {
    /// The area style settings of a radar chart.
    area_style_settings: ?RadarChartAreaStyleSettings,

    pub const json_field_names = .{
        .area_style_settings = "AreaStyleSettings",
    };
};
