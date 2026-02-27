const BarChartSeriesSettings = @import("bar_chart_series_settings.zig").BarChartSeriesSettings;

/// The data field series item configuration of a `BarChartVisual`.
pub const DataFieldBarSeriesItem = struct {
    /// Field ID of the field that you are setting the series configuration for.
    field_id: []const u8,

    /// Field value of the field that you are setting the series configuration for.
    field_value: ?[]const u8,

    /// Options that determine the presentation of bar series associated to the
    /// field.
    settings: ?BarChartSeriesSettings,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .field_value = "FieldValue",
        .settings = "Settings",
    };
};
