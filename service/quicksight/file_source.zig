const InputColumn = @import("input_column.zig").InputColumn;
const UploadSettings = @import("upload_settings.zig").UploadSettings;

/// A physical table type that contains the schema and upload settings for a
/// file-based data source.
pub const FileSource = struct {
    /// The Amazon Resource Name (ARN) for the data source.
    data_source_arn: []const u8,

    /// The column schema of the file.
    input_columns: []const InputColumn,

    /// The zero-based index of the sheet to use within the file. For files that
    /// contain
    /// multiple sheets, this identifies which sheet to read. Files that contain a
    /// single sheet,
    /// or that have no concept of sheets, use sheet 0.
    sheet_index: i32 = 0,

    /// Information about the format for the source file.
    upload_settings: ?UploadSettings = null,

    pub const json_field_names = .{
        .data_source_arn = "DataSourceArn",
        .input_columns = "InputColumns",
        .sheet_index = "SheetIndex",
        .upload_settings = "UploadSettings",
    };
};
