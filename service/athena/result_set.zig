const ResultSetMetadata = @import("result_set_metadata.zig").ResultSetMetadata;
const Row = @import("row.zig").Row;

/// The metadata and rows that make up a query result set. The metadata
/// describes the
/// column structure and data types. To return a `ResultSet` object, use
/// GetQueryResults.
pub const ResultSet = struct {
    /// The metadata that describes the column structure and data types of a table
    /// of query
    /// results.
    result_set_metadata: ?ResultSetMetadata = null,

    /// The rows in the table.
    rows: ?[]const Row = null,

    pub const json_field_names = .{
        .result_set_metadata = "ResultSetMetadata",
        .rows = "Rows",
    };
};
