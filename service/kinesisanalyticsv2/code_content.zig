const S3ContentLocation = @import("s3_content_location.zig").S3ContentLocation;

/// Specifies either the application code, or the location of the application
/// code, for a
/// Managed Service for Apache Flink application.
pub const CodeContent = struct {
    /// Information about the Amazon S3 bucket that contains the application code.
    s3_content_location: ?S3ContentLocation = null,

    /// The text-format code for a Managed Service for Apache Flink application.
    text_content: ?[]const u8 = null,

    /// The zip-format code for a Managed Service for Apache Flink application.
    zip_file_content: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_content_location = "S3ContentLocation",
        .text_content = "TextContent",
        .zip_file_content = "ZipFileContent",
    };
};
