pub const S3EncryptionOption = enum {
    sse_s3,
    sse_kms,

    pub const json_field_names = .{
        .sse_s3 = "SSE_S3",
        .sse_kms = "SSE_KMS",
    };
};
