const FilterOperator = @import("filter_operator.zig").FilterOperator;

/// A specific result obtained by specifying the name, value, and operator.
pub const Filter = struct {
    /// The name of the filter. Filter names are case-sensitive.
    name: []const u8,

    /// The operator for the filter.
    operator: FilterOperator,

    /// The filter values. Filter values are case-sensitive. If you specify multiple
    /// values for a filter, the values are joined with an OR, and the request
    /// returns all results that match any of the specified values
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .value = "Value",
    };
};
