pub const EncryptionType = enum {
    aes256,
    kms,
    kms_dsse,

    pub const json_field_names = .{
        .aes256 = "AES256",
        .kms = "KMS",
        .kms_dsse = "KMS_DSSE",
    };
};
