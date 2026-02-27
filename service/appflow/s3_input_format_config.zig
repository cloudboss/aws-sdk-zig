const S3InputFileType = @import("s3_input_file_type.zig").S3InputFileType;

/// When you use Amazon S3 as the source, the configuration format that you
/// provide
/// the flow input data.
pub const S3InputFormatConfig = struct {
    /// The file type that Amazon AppFlow gets from your Amazon S3 bucket.
    s_3_input_file_type: ?S3InputFileType,

    pub const json_field_names = .{
        .s_3_input_file_type = "s3InputFileType",
    };
};
