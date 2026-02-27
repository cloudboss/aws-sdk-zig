const BarChartSeriesSettings = @import("bar_chart_series_settings.zig").BarChartSeriesSettings;

/// The field series item configuration of a `BarChartVisual`.
pub const FieldBarSeriesItem = struct {
    /// Field ID of the field for which you are setting the series configuration.
    field_id: []const u8,

    /// Options that determine the presentation of bar series associated to the
    /// field.
    settings: ?BarChartSeriesSettings,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .settings = "Settings",
    };
};
