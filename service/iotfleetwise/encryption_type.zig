pub const EncryptionType = enum {
    kms_based_encryption,
    fleetwise_default_encryption,

    pub const json_field_names = .{
        .kms_based_encryption = "KMS_BASED_ENCRYPTION",
        .fleetwise_default_encryption = "FLEETWISE_DEFAULT_ENCRYPTION",
    };
};
