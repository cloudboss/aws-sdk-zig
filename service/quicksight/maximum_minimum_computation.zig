const DimensionField = @import("dimension_field.zig").DimensionField;
const MaximumMinimumComputationType = @import("maximum_minimum_computation_type.zig").MaximumMinimumComputationType;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The maximum and minimum computation configuration.
pub const MaximumMinimumComputation = struct {
    /// The ID for a computation.
    computation_id: []const u8,

    /// The name of a computation.
    name: ?[]const u8 = null,

    /// The time field that is used in a computation.
    time: ?DimensionField = null,

    /// The type of computation. Choose one of the following options:
    ///
    /// * MAXIMUM: A maximum computation.
    ///
    /// * MINIMUM: A minimum computation.
    @"type": MaximumMinimumComputationType,

    /// The value field that is used in a computation.
    value: ?MeasureField = null,

    pub const json_field_names = .{
        .computation_id = "ComputationId",
        .name = "Name",
        .time = "Time",
        .@"type" = "Type",
        .value = "Value",
    };
};
