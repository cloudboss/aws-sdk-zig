const EncryptionStatus = @import("encryption_status.zig").EncryptionStatus;
const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Configuration details about encryption for the cluster including the KMS key
/// ARN, encryption type, and encryption status.
pub const EncryptionDetails = struct {
    /// The status of encryption for the cluster.
    encryption_status: EncryptionStatus,

    /// The type of encryption that protects the data on your cluster.
    encryption_type: EncryptionType,

    /// The ARN of the KMS key that encrypts data in the cluster.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_status = "encryptionStatus",
        .encryption_type = "encryptionType",
        .kms_key_arn = "kmsKeyArn",
    };
};
