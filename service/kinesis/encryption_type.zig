pub const EncryptionType = enum {
    none,
    kms,

    pub const json_field_names = .{
        .none = "NONE",
        .kms = "KMS",
    };
};
