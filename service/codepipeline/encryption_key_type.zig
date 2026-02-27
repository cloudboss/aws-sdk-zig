pub const EncryptionKeyType = enum {
    kms,

    pub const json_field_names = .{
        .kms = "KMS",
    };
};
