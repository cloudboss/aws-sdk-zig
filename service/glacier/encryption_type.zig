pub const EncryptionType = enum {
    kms,
    s3,

    pub const json_field_names = .{
        .kms = "KMS",
        .s3 = "S3",
    };
};
