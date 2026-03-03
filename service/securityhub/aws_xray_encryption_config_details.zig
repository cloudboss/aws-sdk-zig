/// Information about the encryption configuration for X-Ray.
pub const AwsXrayEncryptionConfigDetails = struct {
    /// The identifier of the KMS key that is used for encryption. Provided if
    /// `Type` is `KMS`.
    key_id: ?[]const u8 = null,

    /// The current status of the encryption configuration. Valid values are
    /// `ACTIVE` or `UPDATING`.
    ///
    /// When `Status` is equal to `UPDATING`, X-Ray might use both the old and new
    /// encryption.
    status: ?[]const u8 = null,

    /// The type of encryption. `KMS` indicates that the encryption uses KMS keys.
    /// `NONE` indicates the default encryption.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .status = "Status",
        .@"type" = "Type",
    };
};
