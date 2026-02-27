/// Specifies the customer managed KMS key that is used to encrypt the user's
/// data stores
/// in Athena. When an Amazon Web Services managed key is used, this value is
/// null. This setting does not apply to Athena SQL workgroups.
pub const CustomerContentEncryptionConfiguration = struct {
    /// The customer managed KMS key that is used to encrypt the user's data stores
    /// in Athena.
    kms_key: []const u8,

    pub const json_field_names = .{
        .kms_key = "KmsKey",
    };
};
