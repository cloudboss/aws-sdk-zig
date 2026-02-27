const TableRow = @import("table_row.zig").TableRow;

/// An excerpt from a table within a document. The table excerpt displays up to
/// five
/// columns and three rows, depending on how many table cells are relevant to
/// the query and
/// how many columns are available in the original table. The top most relevant
/// cell is
/// displayed in the table excerpt, along with the next most relevant cells.
pub const TableExcerpt = struct {
    /// A list of rows in the table excerpt.
    rows: ?[]const TableRow,

    /// A count of the number of rows in the original table within the document.
    total_number_of_rows: ?i32,

    pub const json_field_names = .{
        .rows = "Rows",
        .total_number_of_rows = "TotalNumberOfRows",
    };
};
