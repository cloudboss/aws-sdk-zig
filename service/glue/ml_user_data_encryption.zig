const MLUserDataEncryptionModeString = @import("ml_user_data_encryption_mode_string.zig").MLUserDataEncryptionModeString;

/// The encryption-at-rest settings of the transform that apply to accessing
/// user data.
pub const MLUserDataEncryption = struct {
    /// The ID for the customer-provided KMS key.
    kms_key_id: ?[]const u8,

    /// The encryption mode applied to user data. Valid values are:
    ///
    /// * DISABLED: encryption is disabled
    ///
    /// * SSEKMS: use of server-side encryption with Key Management Service
    ///   (SSE-KMS) for user data stored in Amazon S3.
    ml_user_data_encryption_mode: MLUserDataEncryptionModeString,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .ml_user_data_encryption_mode = "MlUserDataEncryptionMode",
    };
};
