const ReadSetS3Access = @import("read_set_s3_access.zig").ReadSetS3Access;

/// Details about a file.
pub const FileInformation = struct {
    /// The file's content length.
    content_length: ?i64 = null,

    /// The file's part size.
    part_size: ?i64 = null,

    /// The S3 URI metadata of a sequence store.
    s_3_access: ?ReadSetS3Access = null,

    /// The file's total parts.
    total_parts: ?i32 = null,

    pub const json_field_names = .{
        .content_length = "contentLength",
        .part_size = "partSize",
        .s_3_access = "s3Access",
        .total_parts = "totalParts",
    };
};
