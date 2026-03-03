const TransposedColumnType = @import("transposed_column_type.zig").TransposedColumnType;

/// The column option of the transposed table.
pub const TransposedTableOption = struct {
    /// The index of a columns in a transposed table. The index range is 0-9999.
    column_index: ?i32 = null,

    /// The column type of the column in a transposed table. Choose one of the
    /// following options:
    ///
    /// * `ROW_HEADER_COLUMN`: Refers to the leftmost column of the row header in
    ///   the transposed table.
    ///
    /// * `VALUE_COLUMN`: Refers to all value columns in the transposed table.
    column_type: TransposedColumnType,

    /// The width of a column in a transposed table.
    column_width: ?[]const u8 = null,

    pub const json_field_names = .{
        .column_index = "ColumnIndex",
        .column_type = "ColumnType",
        .column_width = "ColumnWidth",
    };
};
