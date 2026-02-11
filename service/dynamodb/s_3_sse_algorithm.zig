pub const S3SseAlgorithm = enum {
    aes256,
    kms,

    pub const json_field_names = .{
        .aes256 = "AES256",
        .kms = "KMS",
    };
};
