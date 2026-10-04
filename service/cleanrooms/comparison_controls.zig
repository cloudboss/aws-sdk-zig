/// Specifies how a query can compare the columns in a table, including literal
/// comparisons and column-to-column comparisons.
pub const ComparisonControls = struct {
    /// The columns that a query can compare to another column, for example, in a
    /// join, a WHERE clause, a GROUP BY clause, or a window function. Clean Rooms
    /// rejects a query that uses any other column in a column-to-column comparison.
    /// Specify an empty list to block column-to-column comparison on every column.
    allowed_column_comparison_columns: []const []const u8,

    /// The columns that a query can compare to literal values, for example, in a
    /// WHERE clause. Clean Rooms rejects a query that compares any other column to
    /// a literal value. Specify an empty list to block literal comparison on every
    /// column. You can't specify a column that you also use as an identity column
    /// in an aggregation threshold.
    allowed_literal_comparison_columns: []const []const u8,

    pub const json_field_names = .{
        .allowed_column_comparison_columns = "allowedColumnComparisonColumns",
        .allowed_literal_comparison_columns = "allowedLiteralComparisonColumns",
    };
};
