pub const EncryptionType = enum {
    sse_s3,
    sse_kms,
    dsse_kms,

    pub const json_field_names = .{
        .sse_s3 = "SseS3",
        .sse_kms = "SseKms",
        .dsse_kms = "DsseKms",
    };
};
