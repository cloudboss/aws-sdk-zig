pub const AttachmentsSourceKey = enum {
    source_url,
    s3_file_url,
    attachment_reference,

    pub const json_field_names = .{
        .source_url = "SourceUrl",
        .s3_file_url = "S3FileUrl",
        .attachment_reference = "AttachmentReference",
    };
};
