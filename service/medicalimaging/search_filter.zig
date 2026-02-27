const Operator = @import("operator.zig").Operator;
const SearchByAttributeValue = @import("search_by_attribute_value.zig").SearchByAttributeValue;

/// The search filter.
pub const SearchFilter = struct {
    /// The search filter operator for `imageSetDateTime`.
    operator: Operator,

    /// The search filter values.
    values: []const SearchByAttributeValue,

    pub const json_field_names = .{
        .operator = "operator",
        .values = "values",
    };
};
