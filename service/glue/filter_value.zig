const FilterValueType = @import("filter_value_type.zig").FilterValueType;

/// Represents a single entry in the list of values for a `FilterExpression`.
pub const FilterValue = struct {
    /// The type of filter value.
    type: FilterValueType,

    /// The value to be associated.
    value: []const []const u8,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
