pub const EncryptionType = enum {
    sitewise_default_encryption,
    kms_based_encryption,

    pub const json_field_names = .{
        .sitewise_default_encryption = "SITEWISE_DEFAULT_ENCRYPTION",
        .kms_based_encryption = "KMS_BASED_ENCRYPTION",
    };
};
