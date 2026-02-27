const MeasureField = @import("measure_field.zig").MeasureField;
const DimensionField = @import("dimension_field.zig").DimensionField;

/// The metric comparison computation configuration.
pub const MetricComparisonComputation = struct {
    /// The ID for a computation.
    computation_id: []const u8,

    /// The field that is used in a metric comparison from value setup.
    from_value: ?MeasureField,

    /// The name of a computation.
    name: ?[]const u8,

    /// The field that is used in a metric comparison to value setup.
    target_value: ?MeasureField,

    /// The time field that is used in a computation.
    time: ?DimensionField,

    pub const json_field_names = .{
        .computation_id = "ComputationId",
        .from_value = "FromValue",
        .name = "Name",
        .target_value = "TargetValue",
        .time = "Time",
    };
};
