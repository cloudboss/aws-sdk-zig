const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// A bucket-level setting for Amazon S3 general purpose buckets used to prevent
/// the upload of new objects encrypted with the specified server-side
/// encryption type. For example, blocking an encryption type will block
/// `PutObject`, `CopyObject`, `PostObject`, multipart upload, and replication
/// requests to the bucket for objects with the specified encryption type.
/// However, you can continue to read and list any pre-existing objects already
/// encrypted with the specified encryption type. For more information, see
/// [Blocking or unblocking SSE-C for a general purpose
/// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/blocking-unblocking-s3-c-encryption-gpb.html).
///
/// This data type is used with the following actions:
///
/// *
///   [PutBucketEncryption](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketEncryption.html)
///
/// *
///   [GetBucketEncryption](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketEncryption.html)
///
/// *
///   [DeleteBucketEncryption](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketEncryption.html)
///
/// **Permissions**
///
/// You must have the `s3:PutEncryptionConfiguration` permission to block or
/// unblock an encryption type for a bucket.
///
/// You must have the `s3:GetEncryptionConfiguration` permission to view a
/// bucket's encryption type.
pub const BlockedEncryptionTypes = struct {
    /// The object encryption type that you want to block or unblock for an Amazon
    /// S3 general purpose bucket.
    ///
    /// **Note:**
    ///
    /// Currently, this parameter only supports blocking or unblocking server side
    /// encryption with customer-provided keys (SSE-C). For more information about
    /// SSE-C, see [Using server-side encryption with customer-provided keys
    /// (SSE-C)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/ServerSideEncryptionCustomerKeys.html).
    encryption_type: ?[]const EncryptionType,
};
