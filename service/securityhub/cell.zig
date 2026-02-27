/// An occurrence of sensitive data detected in a Microsoft Excel workbook,
/// comma-separated value (CSV) file, or tab-separated value (TSV) file.
pub const Cell = struct {
    /// For a Microsoft Excel workbook, provides the location of the cell, as an
    /// absolute cell reference, that contains the data. For example, Sheet2!C5 for
    /// cell C5 on Sheet2.
    cell_reference: ?[]const u8,

    /// The column number of the column that contains the data. For a Microsoft
    /// Excel workbook, the column number corresponds to the alphabetical column
    /// identifiers. For example, a value of 1 for Column corresponds to the A
    /// column in the workbook.
    column: ?i64,

    /// The name of the column that contains the data.
    column_name: ?[]const u8,

    /// The row number of the row that contains the data.
    row: ?i64,

    pub const json_field_names = .{
        .cell_reference = "CellReference",
        .column = "Column",
        .column_name = "ColumnName",
        .row = "Row",
    };
};
