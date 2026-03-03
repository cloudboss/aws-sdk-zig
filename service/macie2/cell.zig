/// Specifies the location of an occurrence of sensitive data in a Microsoft
/// Excel workbook, CSV file, or TSV file.
pub const Cell = struct {
    /// The location of the cell, as an absolute cell reference, that contains the
    /// sensitive data, for example Sheet2!C5 for cell C5 on Sheet2 in a Microsoft
    /// Excel workbook. This value is null for CSV and TSV files.
    cell_reference: ?[]const u8 = null,

    /// The column number of the column that contains the sensitive data. For a
    /// Microsoft Excel workbook, this value correlates to the alphabetical
    /// character(s) for a column identifier, for example: 1 for column A, 2 for
    /// column B, and so on.
    column: ?i64 = null,

    /// The name of the column that contains the sensitive data, if available.
    column_name: ?[]const u8 = null,

    /// The row number of the row that contains the sensitive data.
    row: ?i64 = null,

    pub const json_field_names = .{
        .cell_reference = "cellReference",
        .column = "column",
        .column_name = "columnName",
        .row = "row",
    };
};
