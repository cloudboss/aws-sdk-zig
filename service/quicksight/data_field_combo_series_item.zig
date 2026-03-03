const ComboChartSeriesSettings = @import("combo_chart_series_settings.zig").ComboChartSeriesSettings;

/// The data field series item configuration of a `ComboChartVisual`.
pub const DataFieldComboSeriesItem = struct {
    /// Field ID of the field that you are setting the series configuration for.
    field_id: []const u8,

    /// Field value of the field that you are setting the series configuration for.
    field_value: ?[]const u8 = null,

    /// Options that determine the presentation of series associated to the field.
    settings: ?ComboChartSeriesSettings = null,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .field_value = "FieldValue",
        .settings = "Settings",
    };
};
