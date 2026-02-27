const aws = @import("aws");

/// The configuration object that allows encrypting local disks.
pub const DiskEncryptionConfiguration = struct {
    /// Specifies the optional encryption context that will be used when encrypting
    /// the data. An encryption context is a collection of non-secret key-value
    /// pairs that represent additional authenticated data.
    encryption_context: ?[]const aws.map.StringMapEntry,

    /// The KMS key ARN to encrypt local disks.
    encryption_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .encryption_context = "encryptionContext",
        .encryption_key_arn = "encryptionKeyArn",
    };
};
