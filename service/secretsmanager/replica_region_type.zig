/// A custom type that specifies a `Region` and the `KmsKeyId` for a
/// replica secret.
pub const ReplicaRegionType = struct {
    /// The ARN, key ID, or alias of the KMS key to encrypt the secret. If you don't
    /// include
    /// this field, Secrets Manager uses `aws/secretsmanager`.
    kms_key_id: ?[]const u8 = null,

    /// A Region code. For a list of Region codes, see [Name and code of
    /// Regions](https://docs.aws.amazon.com/general/latest/gr/rande.html#regional-endpoints).
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .region = "Region",
    };
};
