const MeasureField = @import("measure_field.zig").MeasureField;

/// The total aggregation computation configuration.
pub const TotalAggregationComputation = struct {
    /// The ID for a computation.
    computation_id: []const u8,

    /// The name of a computation.
    name: ?[]const u8,

    /// The value field that is used in a computation.
    value: ?MeasureField,

    pub const json_field_names = .{
        .computation_id = "ComputationId",
        .name = "Name",
        .value = "Value",
    };
};
