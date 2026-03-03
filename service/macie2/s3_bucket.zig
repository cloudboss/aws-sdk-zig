const AllowsUnencryptedObjectUploads = @import("allows_unencrypted_object_uploads.zig").AllowsUnencryptedObjectUploads;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const S3BucketOwner = @import("s3_bucket_owner.zig").S3BucketOwner;
const BucketPublicAccess = @import("bucket_public_access.zig").BucketPublicAccess;
const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;

/// Provides information about the S3 bucket that a finding applies to. If a
/// quota prevented Amazon Macie from retrieving and processing all the bucket's
/// information prior to generating the finding, the following values are
/// UNKNOWN or null: allowsUnencryptedObjectUploads,
/// defaultServerSideEncryption, publicAccess, and tags.
pub const S3Bucket = struct {
    /// Specifies whether the bucket policy for the bucket requires server-side
    /// encryption of objects when objects are added to the bucket. Possible values
    /// are:
    ///
    /// * FALSE - The bucket policy requires server-side encryption of new objects.
    ///   PutObject requests must include a valid server-side encryption header.
    /// * TRUE - The bucket doesn't have a bucket policy or it has a bucket policy
    ///   that doesn't require server-side encryption of new objects. If a bucket
    ///   policy exists, it doesn't require PutObject requests to include a valid
    ///   server-side encryption header.
    /// * UNKNOWN - Amazon Macie can't determine whether the bucket policy requires
    ///   server-side encryption of new objects.
    ///
    /// Valid server-side encryption headers are: x-amz-server-side-encryption with
    /// a value of AES256 or aws:kms, and
    /// x-amz-server-side-encryption-customer-algorithm with a value of AES256.
    allows_unencrypted_object_uploads: ?AllowsUnencryptedObjectUploads = null,

    /// The Amazon Resource Name (ARN) of the bucket.
    arn: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the bucket was
    /// created. This value can also indicate when changes such as edits to the
    /// bucket's policy were most recently made to the bucket, relative to when the
    /// finding was created or last updated.
    created_at: ?i64 = null,

    /// The default server-side encryption settings for the bucket.
    default_server_side_encryption: ?ServerSideEncryption = null,

    /// The name of the bucket.
    name: ?[]const u8 = null,

    /// The display name and canonical user ID for the Amazon Web Services account
    /// that owns the bucket.
    owner: ?S3BucketOwner = null,

    /// The permissions settings that determine whether the bucket is publicly
    /// accessible.
    public_access: ?BucketPublicAccess = null,

    /// The tags that are associated with the bucket.
    tags: ?[]const KeyValuePair = null,

    pub const json_field_names = .{
        .allows_unencrypted_object_uploads = "allowsUnencryptedObjectUploads",
        .arn = "arn",
        .created_at = "createdAt",
        .default_server_side_encryption = "defaultServerSideEncryption",
        .name = "name",
        .owner = "owner",
        .public_access = "publicAccess",
        .tags = "tags",
    };
};
