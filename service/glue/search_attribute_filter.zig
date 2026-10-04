const SearchFilterOperator = @import("search_filter_operator.zig").SearchFilterOperator;
const SearchFilterValue = @import("search_filter_value.zig").SearchFilterValue;

/// A filter that compares an attribute value using an operator.
pub const SearchAttributeFilter = struct {
    /// The attribute name to filter on.
    attribute: []const u8,

    /// The comparison operator. Valid values are `equals`, `greaterThan`,
    /// `greaterThanOrEquals`, `lessThan`, `lessThanOrEquals`, and `notExists`.
    operator: SearchFilterOperator,

    /// The value to compare against.
    value: ?SearchFilterValue = null,

    pub const json_field_names = .{
        .attribute = "Attribute",
        .operator = "Operator",
        .value = "Value",
    };
};
