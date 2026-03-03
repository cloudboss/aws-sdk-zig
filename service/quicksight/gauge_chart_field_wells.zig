const MeasureField = @import("measure_field.zig").MeasureField;

/// The field well configuration of a `GaugeChartVisual`.
pub const GaugeChartFieldWells = struct {
    /// The target value field wells of a `GaugeChartVisual`.
    target_values: ?[]const MeasureField = null,

    /// The value field wells of a `GaugeChartVisual`.
    values: ?[]const MeasureField = null,

    pub const json_field_names = .{
        .target_values = "TargetValues",
        .values = "Values",
    };
};
