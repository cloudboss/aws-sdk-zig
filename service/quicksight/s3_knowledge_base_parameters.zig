/// The parameters that are required to connect to an S3 knowledge base data
/// source.
///
/// **Prerequisites: Amazon S3 bucket access**
///
/// Before you call `CreateKnowledgeBase` for an Amazon S3 knowledge base, an
/// administrator must grant Amazon QuickSight access to the source S3 bucket.
/// If access has not been granted for the bucket, knowledge base creation
/// fails.
///
/// To grant access, an administrator adds the bucket in the Amazon QuickSight
/// admin console, under Permissions, Amazon Web Services resources, Amazon S3,
/// Select S3 buckets. This authorizes the Amazon QuickSight service role to
/// read the bucket. The bucket can be in the same Amazon Web Services account
/// or, when the bucket owner has authorized your account, in a different
/// account.
///
/// The service role requires at least the following permissions on the bucket:
///
/// * `s3:GetObject`
///
/// * `s3:ListBucket`
///
/// * `s3:GetBucketLocation`
///
/// * `s3:GetObjectVersion`
///
/// * `s3:ListBucketVersions`
///
/// For the full procedure, including cross-account buckets and KMS-encrypted
/// buckets, see the Amazon S3 knowledge base administrator setup guide.
///
/// To grant access for a specific S3 knowledge base data source without
/// granting account-wide S3 access, provide a custom IAM role on the data
/// source by using `RoleArn`.
pub const S3KnowledgeBaseParameters = struct {
    /// The URL of the S3 bucket that contains the knowledge base data.
    bucket_url: []const u8,

    /// The Amazon S3 location (prefix) of per-document metadata files. Each
    /// metadata file describes a single source document and its indexable
    /// attributes, such as title, category, and version. This is not the global ACL
    /// configuration file. To apply a single global ACL file to the entire
    /// knowledge base, use the access control configuration instead.
    metadata_files_location: ?[]const u8 = null,

    /// Use the `RoleArn` structure to override an account-wide role for a specific
    /// S3 Knowledge Base data source. For example, say an account administrator has
    /// turned off all S3 access with an account-wide role. The administrator can
    /// then use `RoleArn` to bypass the account-wide role and allow S3 access for
    /// the single S3 Knowledge Base data source that is specified in the structure,
    /// even if the account-wide role forbidding S3 access is still active.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_url = "BucketUrl",
        .metadata_files_location = "MetadataFilesLocation",
        .role_arn = "RoleArn",
    };
};
