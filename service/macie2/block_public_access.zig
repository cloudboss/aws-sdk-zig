/// Provides information about the block public access settings for an S3
/// bucket. These settings can apply to a bucket at the account or bucket level.
/// For detailed information about each setting, see [Blocking public access to
/// your Amazon S3
/// storage](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html) in the *Amazon Simple Storage Service User Guide*.
pub const BlockPublicAccess = struct {
    /// Specifies whether Amazon S3 blocks public access control lists (ACLs) for
    /// the bucket and objects in the bucket.
    block_public_acls: ?bool,

    /// Specifies whether Amazon S3 blocks public bucket policies for the bucket.
    block_public_policy: ?bool,

    /// Specifies whether Amazon S3 ignores public ACLs for the bucket and objects
    /// in the bucket.
    ignore_public_acls: ?bool,

    /// Specifies whether Amazon S3 restricts public bucket policies for the bucket.
    restrict_public_buckets: ?bool,

    pub const json_field_names = .{
        .block_public_acls = "blockPublicAcls",
        .block_public_policy = "blockPublicPolicy",
        .ignore_public_acls = "ignorePublicAcls",
        .restrict_public_buckets = "restrictPublicBuckets",
    };
};
