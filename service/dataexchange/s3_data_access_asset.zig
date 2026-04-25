const KmsKeyToGrant = @import("kms_key_to_grant.zig").KmsKeyToGrant;

/// The Amazon S3 data access that is the asset.
pub const S3DataAccessAsset = struct {
    /// The Amazon S3 bucket hosting data to be shared in the S3 data access.
    bucket: []const u8,

    /// The Amazon S3 bucket used for hosting shared data in the Amazon S3 data
    /// access.
    key_prefixes: ?[]const []const u8 = null,

    /// S3 keys made available using this asset.
    keys: ?[]const []const u8 = null,

    /// List of AWS KMS CMKs (Key Management System Customer Managed Keys) and ARNs
    /// used to encrypt S3 objects being shared in this S3 Data Access asset.
    /// Providers must include all AWS KMS keys used to encrypt these shared S3
    /// objects.
    kms_keys_to_grant: ?[]const KmsKeyToGrant = null,

    /// The automatically-generated bucket-style alias for your Amazon S3 Access
    /// Point. Customers can access their entitled data using the S3 Access Point
    /// alias.
    s3_access_point_alias: ?[]const u8 = null,

    /// The ARN for your Amazon S3 Access Point. Customers can also access their
    /// entitled data using the S3 Access Point ARN.
    s3_access_point_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key_prefixes = "KeyPrefixes",
        .keys = "Keys",
        .kms_keys_to_grant = "KmsKeysToGrant",
        .s3_access_point_alias = "S3AccessPointAlias",
        .s3_access_point_arn = "S3AccessPointArn",
    };
};
