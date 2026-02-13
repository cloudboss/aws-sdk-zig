pub const AttachmentsSourceKey = enum {
    source_url,
    s_3_file_url,
    attachment_reference,

    pub const json_field_names = .{
        .source_url = "SourceUrl",
        .s_3_file_url = "S3FileUrl",
        .attachment_reference = "AttachmentReference",
    };
};
