/// Provides information about stream encryption.
pub const AwsKinesisStreamStreamEncryptionDetails = struct {
    /// The encryption type to use.
    encryption_type: ?[]const u8,

    /// The globally unique identifier for the customer-managed KMS key to use for
    /// encryption.
    key_id: ?[]const u8,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .key_id = "KeyId",
    };
};
