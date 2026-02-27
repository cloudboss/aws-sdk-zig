const MeasureField = @import("measure_field.zig").MeasureField;

/// The field well configuration of a histogram.
pub const HistogramAggregatedFieldWells = struct {
    /// The value field wells of a histogram. Values are aggregated by `COUNT` or
    /// `DISTINCT_COUNT`.
    values: ?[]const MeasureField,

    pub const json_field_names = .{
        .values = "Values",
    };
};
