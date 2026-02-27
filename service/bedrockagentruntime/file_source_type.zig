pub const FileSourceType = enum {
    s3,
    byte_content,

    pub const json_field_names = .{
        .s3 = "S3",
        .byte_content = "BYTE_CONTENT",
    };
};
