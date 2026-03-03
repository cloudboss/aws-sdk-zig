/// Describes the storage parameters for Amazon S3 and Amazon S3 buckets for an
/// instance store-backed
/// AMI.
pub const S3Storage = struct {
    /// The access key ID of the owner of the bucket. Before you specify a value for
    /// your access
    /// key ID, review and follow the guidance in [Best Practices for Amazon Web
    /// Services
    /// accounts](https://docs.aws.amazon.com/accounts/latest/reference/best-practices.html) in the *Account ManagementReference Guide*.
    aws_access_key_id: ?[]const u8 = null,

    /// The bucket in which to store the AMI. You can specify a bucket that you
    /// already own or a
    /// new bucket that Amazon EC2 creates on your behalf. If you specify a bucket
    /// that belongs to someone
    /// else, Amazon EC2 returns an error.
    bucket: ?[]const u8 = null,

    /// The beginning of the file name of the AMI.
    prefix: ?[]const u8 = null,

    /// An Amazon S3 upload policy that gives Amazon EC2 permission to upload items
    /// into Amazon S3 on your
    /// behalf.
    upload_policy: ?[]const u8 = null,

    /// The signature of the JSON document.
    upload_policy_signature: ?[]const u8 = null,
};
