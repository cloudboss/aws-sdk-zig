const TableCell = @import("table_cell.zig").TableCell;

/// Information about a row in a table excerpt.
pub const TableRow = struct {
    /// A list of table cells in a row.
    cells: ?[]const TableCell = null,

    pub const json_field_names = .{
        .cells = "Cells",
    };
};
