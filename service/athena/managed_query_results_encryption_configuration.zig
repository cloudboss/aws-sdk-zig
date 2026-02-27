/// If you encrypt query and calculation results in Athena owned storage, this
/// field
/// indicates the encryption option (for example, SSE_KMS or CSE_KMS) and key
/// information.
pub const ManagedQueryResultsEncryptionConfiguration = struct {
    /// The ARN of an KMS key for encrypting managed query results.
    kms_key: []const u8,

    pub const json_field_names = .{
        .kms_key = "KmsKey",
    };
};
