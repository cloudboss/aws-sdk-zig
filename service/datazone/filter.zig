const FilterOperator = @import("filter_operator.zig").FilterOperator;

/// A search filter in Amazon DataZone.
pub const Filter = struct {
    /// A search filter attribute in Amazon DataZone.
    attribute: []const u8,

    /// A search filter integer value in Amazon DataZone.
    int_value: ?i64 = null,

    /// Specifies the search filter operator.
    operator: FilterOperator = "EQ",

    /// A search filter string value in Amazon DataZone.
    value: []const u8 = "",

    pub const json_field_names = .{
        .attribute = "attribute",
        .int_value = "intValue",
        .operator = "operator",
        .value = "value",
    };
};
