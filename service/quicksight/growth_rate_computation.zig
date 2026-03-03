const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The growth rate computation configuration.
pub const GrowthRateComputation = struct {
    /// The ID for a computation.
    computation_id: []const u8,

    /// The name of a computation.
    name: ?[]const u8 = null,

    /// The period size setup of a growth rate computation.
    period_size: ?i32 = null,

    /// The time field that is used in a computation.
    time: ?DimensionField = null,

    /// The value field that is used in a computation.
    value: ?MeasureField = null,

    pub const json_field_names = .{
        .computation_id = "ComputationId",
        .name = "Name",
        .period_size = "PeriodSize",
        .time = "Time",
        .value = "Value",
    };
};
