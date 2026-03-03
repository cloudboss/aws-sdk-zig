/// Provides information about the number of S3 buckets whose bucket policies do
/// or don't require server-side encryption of objects when objects are added to
/// the buckets.
pub const BucketCountPolicyAllowsUnencryptedObjectUploads = struct {
    /// The total number of buckets that don't have a bucket policy or have a bucket
    /// policy that doesn't require server-side encryption of new objects. If a
    /// bucket policy exists, the policy doesn't require PutObject requests to
    /// include a valid server-side encryption header: the
    /// x-amz-server-side-encryption header with a value of AES256 or aws:kms, or
    /// the x-amz-server-side-encryption-customer-algorithm header with a value of
    /// AES256.
    allows_unencrypted_object_uploads: ?i64 = null,

    /// The total number of buckets whose bucket policies require server-side
    /// encryption of new objects. PutObject requests for these buckets must include
    /// a valid server-side encryption header: the x-amz-server-side-encryption
    /// header with a value of AES256 or aws:kms, or the
    /// x-amz-server-side-encryption-customer-algorithm header with a value of
    /// AES256.
    denies_unencrypted_object_uploads: ?i64 = null,

    /// The total number of buckets that Amazon Macie wasn't able to evaluate
    /// server-side encryption requirements for. For example, the buckets'
    /// permissions settings or a quota prevented Macie from retrieving the
    /// requisite data. Macie can't determine whether bucket policies for the
    /// buckets require server-side encryption of new objects.
    unknown: ?i64 = null,

    pub const json_field_names = .{
        .allows_unencrypted_object_uploads = "allowsUnencryptedObjectUploads",
        .denies_unencrypted_object_uploads = "deniesUnencryptedObjectUploads",
        .unknown = "unknown",
    };
};
