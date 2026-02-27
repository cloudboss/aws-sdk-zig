pub const EncryptionStatus = enum {
    enabled,
    updating,
    kms_key_inaccessible,
    enabling,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .updating = "UPDATING",
        .kms_key_inaccessible = "KMS_KEY_INACCESSIBLE",
        .enabling = "ENABLING",
    };
};
