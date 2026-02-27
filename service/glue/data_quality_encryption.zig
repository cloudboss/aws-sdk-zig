const DataQualityEncryptionMode = @import("data_quality_encryption_mode.zig").DataQualityEncryptionMode;

/// Specifies how Data Quality assets in your account should be encrypted.
pub const DataQualityEncryption = struct {
    /// The encryption mode to use for encrypting Data Quality assets. These assets
    /// include data quality rulesets, results, statistics, anomaly detection models
    /// and observations.
    ///
    /// Valid values are `SSEKMS` for encryption using a customer-managed KMS key,
    /// or `DISABLED`.
    data_quality_encryption_mode: ?DataQualityEncryptionMode,

    /// The Amazon Resource Name (ARN) of the KMS key to be used to encrypt the
    /// data.
    kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .data_quality_encryption_mode = "DataQualityEncryptionMode",
        .kms_key_arn = "KmsKeyArn",
    };
};
