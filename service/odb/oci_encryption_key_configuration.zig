/// The configuration of the Oracle Cloud Infrastructure (OCI) Vault encryption
/// key used for an Autonomous Database.
pub const OciEncryptionKeyConfiguration = struct {
    /// The Oracle Cloud Identifier (OCID) of the OCI Vault key to use for
    /// encryption.
    kms_key_id: []const u8,

    /// The Oracle Cloud Identifier (OCID) of the OCI Vault that contains the
    /// encryption key.
    vault_id: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .vault_id = "vaultId",
    };
};
