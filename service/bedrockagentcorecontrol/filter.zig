const FilterOperator = @import("filter_operator.zig").FilterOperator;
const FilterValue = @import("filter_value.zig").FilterValue;

/// The filter that applies conditions to agent traces during online evaluation
/// to determine which traces should be evaluated.
pub const Filter = struct {
    /// The key or field name to filter on within the agent trace data.
    key: []const u8,

    /// The comparison operator to use for filtering.
    operator: FilterOperator,

    /// The value to compare against using the specified operator.
    value: FilterValue,

    pub const json_field_names = .{
        .key = "key",
        .operator = "operator",
        .value = "value",
    };
};
