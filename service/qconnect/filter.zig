const FilterField = @import("filter_field.zig").FilterField;
const FilterOperator = @import("filter_operator.zig").FilterOperator;

/// A search filter.
pub const Filter = struct {
    /// The field on which to filter.
    field: FilterField,

    /// The operator to use for comparing the field’s value with the provided value.
    operator: FilterOperator,

    /// The desired field value on which to filter.
    value: []const u8,

    pub const json_field_names = .{
        .field = "field",
        .operator = "operator",
        .value = "value",
    };
};
