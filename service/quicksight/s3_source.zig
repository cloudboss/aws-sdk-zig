const InputColumn = @import("input_column.zig").InputColumn;
const UploadSettings = @import("upload_settings.zig").UploadSettings;

/// A physical table type for an S3 data source.
pub const S3Source = struct {
    /// The Amazon Resource Name (ARN) for the data source.
    data_source_arn: []const u8,

    /// A physical table type for an S3 data source.
    ///
    /// For files that aren't JSON, only `STRING` data types are supported in input
    /// columns.
    input_columns: []const InputColumn,

    /// Information about the format for the S3 source file or files.
    upload_settings: ?UploadSettings,

    pub const json_field_names = .{
        .data_source_arn = "DataSourceArn",
        .input_columns = "InputColumns",
        .upload_settings = "UploadSettings",
    };
};
