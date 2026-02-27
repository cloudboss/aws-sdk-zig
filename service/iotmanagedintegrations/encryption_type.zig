pub const EncryptionType = enum {
    managed_integrations_default_encryption,
    customer_key_encryption,

    pub const json_field_names = .{
        .managed_integrations_default_encryption = "MANAGED_INTEGRATIONS_DEFAULT_ENCRYPTION",
        .customer_key_encryption = "CUSTOMER_KEY_ENCRYPTION",
    };
};
