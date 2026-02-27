/// Represents a set of options that define how DataBrew will interpret a
/// Microsoft Excel file when
/// creating a dataset from that file.
pub const ExcelOptions = struct {
    /// A variable that specifies whether the first row in the file is parsed as the
    /// header. If this value is false, column names are auto-generated.
    header_row: ?bool,

    /// One or more sheet numbers in the Excel file that will be included in the
    /// dataset.
    sheet_indexes: ?[]const i32,

    /// One or more named sheets in the Excel file that will be included in the
    /// dataset.
    sheet_names: ?[]const []const u8,

    pub const json_field_names = .{
        .header_row = "HeaderRow",
        .sheet_indexes = "SheetIndexes",
        .sheet_names = "SheetNames",
    };
};
