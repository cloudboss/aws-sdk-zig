const PublicAccessStatus = @import("public_access_status.zig").PublicAccessStatus;
const PublicAclIgnoreBehavior = @import("public_acl_ignore_behavior.zig").PublicAclIgnoreBehavior;
const PublicBucketRestrictBehavior = @import("public_bucket_restrict_behavior.zig").PublicBucketRestrictBehavior;

/// Describes public access policies that apply to the Amazon S3 bucket.
///
/// For information about each of the following settings, see
/// [Blocking public access to your Amazon S3
/// storage](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html) in the *Amazon S3 User Guide*.
pub const PublicAccessConfiguration = struct {
    /// Indicates whether or not there is a setting that allows public access to the
    /// Amazon S3 buckets through access
    /// control lists (ACLs).
    public_acl_access: ?PublicAccessStatus = null,

    /// Indicates whether or not there is a setting that ignores all public access
    /// control lists (ACLs)
    /// on the Amazon S3 bucket and the objects that it contains.
    public_acl_ignore_behavior: ?PublicAclIgnoreBehavior = null,

    /// Indicates whether or not there is a setting that restricts access to the
    /// bucket with specified policies.
    public_bucket_restrict_behavior: ?PublicBucketRestrictBehavior = null,

    /// Indicates whether or not there is a setting that allows public access to the
    /// Amazon S3 bucket policy.
    public_policy_access: ?PublicAccessStatus = null,

    pub const json_field_names = .{
        .public_acl_access = "PublicAclAccess",
        .public_acl_ignore_behavior = "PublicAclIgnoreBehavior",
        .public_bucket_restrict_behavior = "PublicBucketRestrictBehavior",
        .public_policy_access = "PublicPolicyAccess",
    };
};
