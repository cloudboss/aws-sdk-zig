const UndefinedSpecifiedValueType = @import("undefined_specified_value_type.zig").UndefinedSpecifiedValueType;
const ColumnOrderingType = @import("column_ordering_type.zig").ColumnOrderingType;

/// A structure that represents a comparative order.
pub const ComparativeOrder = struct {
    /// The list of columns to be used in the ordering.
    specifed_order: ?[]const []const u8,

    /// The treat of undefined specified values. Valid values for this structure are
    /// `LEAST` and `MOST`.
    treat_undefined_specified_values: ?UndefinedSpecifiedValueType,

    /// The ordering type for a column. Valid values for this structure are
    /// `GREATER_IS_BETTER`, `LESSER_IS_BETTER` and `SPECIFIED`.
    use_ordering: ?ColumnOrderingType,

    pub const json_field_names = .{
        .specifed_order = "SpecifedOrder",
        .treat_undefined_specified_values = "TreatUndefinedSpecifiedValues",
        .use_ordering = "UseOrdering",
    };
};
