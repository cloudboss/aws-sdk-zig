const CmkType = @import("cmk_type.zig").CmkType;

/// The customer-managed-key (CMK) used when creating a data store. If a
/// customer-owned key
/// is not specified, an AWS-owned key is used for encryption.
pub const KmsEncryptionConfig = struct {
    /// The type of customer-managed-key (CMK) used for encryption.
    cmk_type: CmkType,

    /// The Key Management Service (KMS) encryption key id/alias used to encrypt the
    /// data store contents at
    /// rest.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cmk_type = "CmkType",
        .kms_key_id = "KmsKeyId",
    };
};
