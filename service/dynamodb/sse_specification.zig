const SSEType = @import("sse_type.zig").SSEType;

/// Represents the settings used to enable server-side encryption.
pub const SSESpecification = struct {
    /// Indicates whether server-side encryption is done using an Amazon Web
    /// Services managed
    /// key or an Amazon Web Services owned key. If enabled (true), server-side
    /// encryption type
    /// is set to `KMS` and an Amazon Web Services managed key is used (KMS charges
    /// apply). If disabled (false) or not specified, server-side
    /// encryption is set to Amazon Web Services owned key.
    enabled: ?bool,

    /// The KMS key that should be used for the KMS encryption.
    /// To specify a key, use its key ID, Amazon Resource Name (ARN), alias name, or
    /// alias ARN.
    /// Note that you should only provide this parameter if the key is different
    /// from the
    /// default DynamoDB key `alias/aws/dynamodb`.
    kms_master_key_id: ?[]const u8,

    /// Server-side encryption type. The only supported value is:
    ///
    /// * `KMS` - Server-side encryption that uses Key Management Service. The
    /// key is stored in your account and is managed by KMS (KMS charges apply).
    sse_type: ?SSEType,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .kms_master_key_id = "KMSMasterKeyId",
        .sse_type = "SSEType",
    };
};
