const OptInStatus = @import("opt_in_status.zig").OptInStatus;
const ServerSideEncryptionType = @import("server_side_encryption_type.zig").ServerSideEncryptionType;

/// Information about whether DevOps Guru is configured to encrypt server-side
/// data using KMS.
pub const KMSServerSideEncryptionIntegrationConfig = struct {
    /// Describes the specified KMS key.
    ///
    /// To specify a KMS key, use its key ID, key ARN,
    /// alias name, or alias ARN. When using an alias name,
    /// prefix it with "alias/". If you specify a predefined Amazon Web Services
    /// alias
    /// (an Amazon Web Services alias with no key ID), Amazon Web Services KMS
    /// associates the alias with an
    /// Amazon Web Services managed key and returns its KeyId and Arn in the
    /// response.
    /// To specify a KMS key in a different Amazon Web Services account, you must
    /// use the key ARN or alias ARN.
    ///
    /// For example:
    ///
    /// Key ID: 1234abcd-12ab-34cd-56ef-1234567890ab
    ///
    /// Key ARN:
    /// arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab
    ///
    /// Alias name: alias/ExampleAlias
    ///
    /// Alias ARN: arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias
    kms_key_id: ?[]const u8,

    /// Specifies if DevOps Guru is enabled for KMS integration.
    opt_in_status: ?OptInStatus,

    /// The type of KMS key used. Customer managed keys are the KMS keys that you
    /// create. Amazon Web Services owned keys are keys that are owned and managed
    /// by DevOps Guru.
    @"type": ?ServerSideEncryptionType,

    pub const json_field_names = .{
        .kms_key_id = "KMSKeyId",
        .opt_in_status = "OptInStatus",
        .@"type" = "Type",
    };
};
