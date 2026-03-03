/// provides information about the Amazon S3 Public Access Block configuration
/// for accounts.
pub const AwsS3AccountPublicAccessBlockDetails = struct {
    /// Indicates whether to reject calls to update an S3 bucket if the calls
    /// include a public access control list (ACL).
    block_public_acls: ?bool = null,

    /// Indicates whether to reject calls to update the access policy for an S3
    /// bucket or access point if the policy allows public access.
    block_public_policy: ?bool = null,

    /// Indicates whether Amazon S3 ignores public ACLs that are associated with an
    /// S3 bucket.
    ignore_public_acls: ?bool = null,

    /// Indicates whether to restrict access to an access point or S3 bucket that
    /// has a public policy to only Amazon Web Services service principals and
    /// authorized users within the S3 bucket owner's account.
    restrict_public_buckets: ?bool = null,

    pub const json_field_names = .{
        .block_public_acls = "BlockPublicAcls",
        .block_public_policy = "BlockPublicPolicy",
        .ignore_public_acls = "IgnorePublicAcls",
        .restrict_public_buckets = "RestrictPublicBuckets",
    };
};
