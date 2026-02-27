/// Server-side encryption type.
pub const EncryptionType = enum {
    kms,

    pub const json_field_names = .{
        .kms = "KMS",
    };
};
