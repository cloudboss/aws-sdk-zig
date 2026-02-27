/// The configuration containing information about the customer managed key used
/// for
/// encrypting customer data.
pub const ServerSideEncryptionConfiguration = struct {
    /// The identifier of the KMS key to use to encrypt data stored by
    /// Voice ID. Voice ID doesn't support asymmetric customer managed keys.
    kms_key_id: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
    };
};
