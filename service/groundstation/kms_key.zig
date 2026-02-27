/// KMS key info.
pub const KmsKey = union(enum) {
    /// KMS Alias Arn.
    kms_alias_arn: ?[]const u8,
    /// KMS Alias Name.
    kms_alias_name: ?[]const u8,
    /// KMS Key Arn.
    kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .kms_alias_arn = "kmsAliasArn",
        .kms_alias_name = "kmsAliasName",
        .kms_key_arn = "kmsKeyArn",
    };
};
