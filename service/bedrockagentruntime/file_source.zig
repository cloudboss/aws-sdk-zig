const ByteContentFile = @import("byte_content_file.zig").ByteContentFile;
const S3ObjectFile = @import("s3_object_file.zig").S3ObjectFile;
const FileSourceType = @import("file_source_type.zig").FileSourceType;

/// The source file of the content contained in the wrapper object.
pub const FileSource = struct {
    /// The data and the text of the attached files.
    byte_content: ?ByteContentFile,

    /// The s3 location of the files to attach.
    s_3_location: ?S3ObjectFile,

    /// The source type of the files to attach.
    source_type: FileSourceType,

    pub const json_field_names = .{
        .byte_content = "byteContent",
        .s_3_location = "s3Location",
        .source_type = "sourceType",
    };
};
