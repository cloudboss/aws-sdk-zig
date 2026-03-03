const EncryptionOption = @import("encryption_option.zig").EncryptionOption;

/// If query and calculation results are encrypted in Amazon S3, indicates the
/// encryption option used (for example, `SSE_KMS` or `CSE_KMS`) and
/// key information.
pub const EncryptionConfiguration = struct {
    /// Indicates whether Amazon S3 server-side encryption with Amazon S3-managed
    /// keys (`SSE_S3`), server-side encryption with KMS-managed keys
    /// (`SSE_KMS`), or client-side encryption with KMS-managed keys
    /// (`CSE_KMS`) is used.
    ///
    /// If a query runs in a workgroup and the workgroup overrides client-side
    /// settings, then
    /// the workgroup's setting for encryption is used. It specifies whether query
    /// results must
    /// be encrypted, for all queries that run in this workgroup.
    encryption_option: EncryptionOption,

    /// For `SSE_KMS` and `CSE_KMS`, this is the KMS key ARN or
    /// ID.
    kms_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_option = "EncryptionOption",
        .kms_key = "KmsKey",
    };
};
