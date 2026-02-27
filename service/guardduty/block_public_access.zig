/// Contains information on how the bucker owner's S3 Block Public Access
/// settings are being
/// applied to the S3 bucket. See [S3 Block Public
/// Access](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html) for more information.
pub const BlockPublicAccess = struct {
    /// Indicates if S3 Block Public Access is set to `BlockPublicAcls`.
    block_public_acls: ?bool,

    /// Indicates if S3 Block Public Access is set to `BlockPublicPolicy`.
    block_public_policy: ?bool,

    /// Indicates if S3 Block Public Access is set to `IgnorePublicAcls`.
    ignore_public_acls: ?bool,

    /// Indicates if S3 Block Public Access is set to `RestrictPublicBuckets`.
    restrict_public_buckets: ?bool,

    pub const json_field_names = .{
        .block_public_acls = "BlockPublicAcls",
        .block_public_policy = "BlockPublicPolicy",
        .ignore_public_acls = "IgnorePublicAcls",
        .restrict_public_buckets = "RestrictPublicBuckets",
    };
};
