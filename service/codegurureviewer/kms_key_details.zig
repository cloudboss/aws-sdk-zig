const EncryptionOption = @import("encryption_option.zig").EncryptionOption;

/// An object that contains:
///
/// * The encryption option for a repository association. It is either owned by
///   Amazon Web Services
/// Key Management Service (KMS) (`AWS_OWNED_CMK`) or customer managed
/// (`CUSTOMER_MANAGED_CMK`).
///
/// * The ID of the Amazon Web Services KMS key that is associated with a
///   repository
/// association.
pub const KMSKeyDetails = struct {
    /// The encryption option for a repository association. It is either owned by
    /// Amazon Web Services Key
    /// Management Service (KMS) (`AWS_OWNED_CMK`) or customer managed
    /// (`CUSTOMER_MANAGED_CMK`).
    encryption_option: ?EncryptionOption,

    /// The ID of the Amazon Web Services KMS key that is associated with a
    /// repository association.
    kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .encryption_option = "EncryptionOption",
        .kms_key_id = "KMSKeyId",
    };
};
