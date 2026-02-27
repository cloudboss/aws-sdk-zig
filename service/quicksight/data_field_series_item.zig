const AxisBinding = @import("axis_binding.zig").AxisBinding;
const LineChartSeriesSettings = @import("line_chart_series_settings.zig").LineChartSeriesSettings;

/// The data field series item configuration of a line chart.
pub const DataFieldSeriesItem = struct {
    /// The axis that you are binding the field to.
    axis_binding: AxisBinding,

    /// The field ID of the field that you are setting the axis binding to.
    field_id: []const u8,

    /// The field value of the field that you are setting the axis binding to.
    field_value: ?[]const u8,

    /// The options that determine the presentation of line series associated to the
    /// field.
    settings: ?LineChartSeriesSettings,

    pub const json_field_names = .{
        .axis_binding = "AxisBinding",
        .field_id = "FieldId",
        .field_value = "FieldValue",
        .settings = "Settings",
    };
};
