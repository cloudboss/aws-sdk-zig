const AllRowsWildcard = @import("all_rows_wildcard.zig").AllRowsWildcard;

/// A PartiQL predicate.
pub const RowFilter = struct {
    /// A wildcard for all rows.
    all_rows_wildcard: ?AllRowsWildcard = null,

    /// A filter expression.
    filter_expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .all_rows_wildcard = "AllRowsWildcard",
        .filter_expression = "FilterExpression",
    };
};
