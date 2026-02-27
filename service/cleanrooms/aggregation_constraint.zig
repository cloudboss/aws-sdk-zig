const AggregationType = @import("aggregation_type.zig").AggregationType;

/// Constraint on query output removing output rows that do not meet a minimum
/// number of distinct values of a specified column.
pub const AggregationConstraint = struct {
    /// Column in aggregation constraint for which there must be a minimum number of
    /// distinct values in an output row for it to be in the query output.
    column_name: []const u8,

    /// The minimum number of distinct values that an output row must be an
    /// aggregation of. Minimum threshold of distinct values for a specified column
    /// that must exist in an output row for it to be in the query output.
    minimum: i32,

    /// The type of aggregation the constraint allows. The only valid value is
    /// currently `COUNT_DISTINCT`.
    type: AggregationType,

    pub const json_field_names = .{
        .column_name = "columnName",
        .minimum = "minimum",
        .type = "type",
    };
};
