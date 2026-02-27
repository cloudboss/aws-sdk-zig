const QueryConditionComparisonOperator = @import("query_condition_comparison_operator.zig").QueryConditionComparisonOperator;
const QueryConditionFieldName = @import("query_condition_field_name.zig").QueryConditionFieldName;

/// The condition for the query.
pub const QueryConditionItem = struct {
    /// The comparison operator for query condition to query on.
    comparator: QueryConditionComparisonOperator,

    /// The name of the field for query condition to query on.
    field: QueryConditionFieldName,

    /// The value for the query condition to query on.
    value: []const u8,

    pub const json_field_names = .{
        .comparator = "comparator",
        .field = "field",
        .value = "value",
    };
};
