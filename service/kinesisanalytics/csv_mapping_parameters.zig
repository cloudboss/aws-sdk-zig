/// Provides additional mapping information when the record format
/// uses delimiters, such as CSV. For example, the following sample records
/// use CSV format, where the records use the *'\n'* as the row delimiter and a
/// comma (",") as the column delimiter:
///
/// `"name1", "address1"`
///
/// `"name2", "address2"`
pub const CSVMappingParameters = struct {
    /// Column delimiter. For example, in a CSV format, a comma (",") is the typical
    /// column delimiter.
    record_column_delimiter: []const u8,

    /// Row delimiter. For example, in a CSV format, *'\n'* is the typical row
    /// delimiter.
    record_row_delimiter: []const u8,

    pub const json_field_names = .{
        .record_column_delimiter = "RecordColumnDelimiter",
        .record_row_delimiter = "RecordRowDelimiter",
    };
};
