const TableCellStyle = @import("table_cell_style.zig").TableCellStyle;
const TableOrientation = @import("table_orientation.zig").TableOrientation;
const RowAlternateColorOptions = @import("row_alternate_color_options.zig").RowAlternateColorOptions;

/// The table options for a table visual.
pub const TableOptions = struct {
    /// The table cell style of table cells.
    cell_style: ?TableCellStyle,

    /// The table cell style of a table header.
    header_style: ?TableCellStyle,

    /// The orientation (vertical, horizontal) for a table.
    orientation: ?TableOrientation,

    /// The row alternate color options (widget status, row alternate colors) for a
    /// table.
    row_alternate_color_options: ?RowAlternateColorOptions,

    pub const json_field_names = .{
        .cell_style = "CellStyle",
        .header_style = "HeaderStyle",
        .orientation = "Orientation",
        .row_alternate_color_options = "RowAlternateColorOptions",
    };
};
