pub const SSEAlgorithm = enum {
    sse_kms,
    sse_s3,

    pub const json_field_names = .{
        .sse_kms = "SSE_KMS",
        .sse_s3 = "SSE_S3",
    };
};
