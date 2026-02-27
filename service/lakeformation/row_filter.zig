const AllRowsWildcard = @import("all_rows_wildcard.zig").AllRowsWildcard;

/// A PartiQL predicate.
pub const RowFilter = struct {
    /// A wildcard for all rows.
    all_rows_wildcard: ?AllRowsWildcard,

    /// A filter expression.
    filter_expression: ?[]const u8,

    pub const json_field_names = .{
        .all_rows_wildcard = "AllRowsWildcard",
        .filter_expression = "FilterExpression",
    };
};
