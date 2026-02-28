const EncryptionStatus = @import("encryption_status.zig").EncryptionStatus;
const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// A configuration document that specifies encryption configuration settings.
pub const EncryptionConfig = struct {
    /// The ID of the KMS key used for encryption, if applicable.
    key_id: ?[]const u8,

    /// The encryption status. While the status is `UPDATING`, X-Ray may encrypt
    /// data with a combination of the new and old settings.
    status: ?EncryptionStatus,

    /// The type of encryption. Set to `KMS` for encryption with KMS keys. Set to
    /// `NONE` for
    /// default encryption.
    @"type": ?EncryptionType,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .status = "Status",
        .@"type" = "Type",
    };
};
