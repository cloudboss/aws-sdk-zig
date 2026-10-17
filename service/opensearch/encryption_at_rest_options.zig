const EncryptionMode = @import("encryption_mode.zig").EncryptionMode;

/// Specifies whether the domain should encrypt data at rest, and if so, the Key
/// Management Service (KMS) key to use. Can only be used when creating a new
/// domain or
/// enabling encryption at rest for the first time on an existing domain. You
/// can't modify
/// this parameter after it's already been specified.
pub const EncryptionAtRestOptions = struct {
    /// True to enable encryption at rest.
    enabled: ?bool = null,

    /// The type of encryption at rest applied to the domain's data. Valid values
    /// are
    /// `DISK` and `NATIVE`. `DISK` is the default and uses
    /// volume-level encryption. `NATIVE` uses engine-native, index-level encryption
    /// and requires encryption at rest to be enabled and OpenSearch version 3.3 or
    /// later. After
    /// the mode is set to `NATIVE`, it can't be changed back to
    /// `DISK`.
    encryption_mode: ?EncryptionMode = null,

    /// The KMS key ID. Takes the form
    /// `1a2a3a4-1a2a-3a4a-5a6a-1a2a3a4a5a6a`.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .encryption_mode = "EncryptionMode",
        .kms_key_id = "KmsKeyId",
    };
};
