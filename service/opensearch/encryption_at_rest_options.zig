/// Specifies whether the domain should encrypt data at rest, and if so, the Key
/// Management Service (KMS) key to use. Can only be used when creating a new
/// domain or
/// enabling encryption at rest for the first time on an existing domain. You
/// can't modify
/// this parameter after it's already been specified.
pub const EncryptionAtRestOptions = struct {
    /// True to enable encryption at rest.
    enabled: ?bool = null,

    /// The KMS key ID. Takes the form
    /// `1a2a3a4-1a2a-3a4a-5a6a-1a2a3a4a5a6a`.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .kms_key_id = "KmsKeyId",
    };
};
