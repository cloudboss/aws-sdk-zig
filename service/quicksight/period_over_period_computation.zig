const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The period over period computation configuration.
pub const PeriodOverPeriodComputation = struct {
    /// The ID for a computation.
    computation_id: []const u8,

    /// The name of a computation.
    name: ?[]const u8,

    /// The time field that is used in a computation.
    time: ?DimensionField,

    /// The value field that is used in a computation.
    value: ?MeasureField,

    pub const json_field_names = .{
        .computation_id = "ComputationId",
        .name = "Name",
        .time = "Time",
        .value = "Value",
    };
};
