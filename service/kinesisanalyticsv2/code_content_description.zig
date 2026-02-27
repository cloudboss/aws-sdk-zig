const S3ApplicationCodeLocationDescription = @import("s3_application_code_location_description.zig").S3ApplicationCodeLocationDescription;

/// Describes details about the code of a Managed Service for Apache Flink
/// application.
pub const CodeContentDescription = struct {
    /// The checksum that can be used to validate zip-format code.
    code_md5: ?[]const u8,

    /// The size in bytes of the application code. Can be used to validate
    /// zip-format code.
    code_size: ?i64,

    /// The S3 bucket Amazon Resource Name (ARN), file key, and object version of
    /// the application
    /// code stored in Amazon S3.
    s3_application_code_location_description: ?S3ApplicationCodeLocationDescription,

    /// The text-format code
    text_content: ?[]const u8,

    pub const json_field_names = .{
        .code_md5 = "CodeMD5",
        .code_size = "CodeSize",
        .s3_application_code_location_description = "S3ApplicationCodeLocationDescription",
        .text_content = "TextContent",
    };
};
