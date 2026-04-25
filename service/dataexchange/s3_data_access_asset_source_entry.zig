const KmsKeyToGrant = @import("kms_key_to_grant.zig").KmsKeyToGrant;

/// Source details for an Amazon S3 data access asset.
pub const S3DataAccessAssetSourceEntry = struct {
    /// The Amazon S3 bucket used for hosting shared data in the Amazon S3 data
    /// access.
    bucket: []const u8,

    /// Organizes Amazon S3 asset key prefixes stored in an Amazon S3 bucket.
    key_prefixes: ?[]const []const u8 = null,

    /// The keys used to create the Amazon S3 data access.
    keys: ?[]const []const u8 = null,

    /// List of AWS KMS CMKs (Key Management System Customer Managed Keys) and ARNs
    /// used to encrypt S3 objects being shared in this S3 Data Access asset.
    kms_keys_to_grant: ?[]const KmsKeyToGrant = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key_prefixes = "KeyPrefixes",
        .keys = "Keys",
        .kms_keys_to_grant = "KmsKeysToGrant",
    };
};
