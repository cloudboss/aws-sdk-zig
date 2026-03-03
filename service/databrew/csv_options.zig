/// Represents a set of options that define how DataBrew will read a
/// comma-separated value (CSV) file when creating a dataset from that file.
pub const CsvOptions = struct {
    /// A single character that specifies the delimiter being used in the CSV file.
    delimiter: ?[]const u8 = null,

    /// A variable that specifies whether the first row in the file is parsed as the
    /// header. If this value is false, column names are auto-generated.
    header_row: ?bool = null,

    pub const json_field_names = .{
        .delimiter = "Delimiter",
        .header_row = "HeaderRow",
    };
};
