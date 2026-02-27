const ColumnDataType = @import("column_data_type.zig").ColumnDataType;

/// The definition of a column in a tabular Dataset.
pub const ColumnDefinition = struct {
    /// Description for a column.
    column_description: ?[]const u8,

    /// The name of a column.
    column_name: ?[]const u8,

    /// Data type of a column.
    ///
    /// * `STRING` – A String data type.
    ///
    /// `CHAR` – A char data type.
    ///
    /// `INTEGER` – An integer data type.
    ///
    /// `TINYINT` – A tinyint data type.
    ///
    /// `SMALLINT` – A smallint data type.
    ///
    /// `BIGINT` – A bigint data type.
    ///
    /// `FLOAT` – A float data type.
    ///
    /// `DOUBLE` – A double data type.
    ///
    /// `DATE` – A date data type.
    ///
    /// `DATETIME` – A datetime data type.
    ///
    /// `BOOLEAN` – A boolean data type.
    ///
    /// `BINARY` – A binary data type.
    data_type: ?ColumnDataType,

    pub const json_field_names = .{
        .column_description = "columnDescription",
        .column_name = "columnName",
        .data_type = "dataType",
    };
};
