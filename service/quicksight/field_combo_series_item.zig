const ComboChartSeriesSettings = @import("combo_chart_series_settings.zig").ComboChartSeriesSettings;

/// The field series item configuration of a `ComboChartVisual`.
pub const FieldComboSeriesItem = struct {
    /// Field ID of the field for which you are setting the series configuration.
    field_id: []const u8,

    /// Options that determine the presentation of series associated to the field.
    settings: ?ComboChartSeriesSettings,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .settings = "Settings",
    };
};
