const ServerSideEncryptionByDefault = @import("server_side_encryption_by_default.zig").ServerSideEncryptionByDefault;
const BlockedEncryptionTypes = @import("blocked_encryption_types.zig").BlockedEncryptionTypes;

/// Specifies the default server-side encryption configuration.
///
/// * **General purpose buckets** - If you're specifying a customer
/// managed KMS key, we recommend using a fully qualified KMS key ARN. If you
/// use a KMS key
/// alias instead, then KMS resolves the key within the requester’s account.
/// This behavior can
/// result in data that's encrypted with a KMS key that belongs to the
/// requester, and not the bucket
/// owner.
///
/// * **Directory buckets** -
/// When you specify an [KMS customer managed
/// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk) for encryption in your directory bucket, only use the key ID or key ARN. The key alias format of the KMS key isn't supported.
pub const ServerSideEncryptionRule = struct {
    /// Specifies the default server-side encryption to apply to new objects in the
    /// bucket. If a PUT Object
    /// request doesn't specify any server-side encryption, this default encryption
    /// will be applied.
    apply_server_side_encryption_by_default: ?ServerSideEncryptionByDefault = null,

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
    /// Currently, this parameter only supports blocking or unblocking server-side
    /// encryption with customer-provided keys (SSE-C). For more information about
    /// SSE-C, see [Using server-side encryption with customer-provided keys
    /// (SSE-C)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/ServerSideEncryptionCustomerKeys.html).
    blocked_encryption_types: ?BlockedEncryptionTypes = null,

    /// Specifies whether Amazon S3 should use an S3 Bucket Key with server-side
    /// encryption using KMS (SSE-KMS)
    /// for new objects in the bucket. Existing objects are not affected. Setting
    /// the
    /// `BucketKeyEnabled` element to `true` causes Amazon S3 to use an S3 Bucket
    /// Key.
    ///
    /// * **General purpose buckets** - By default, S3 Bucket Key is not
    /// enabled. For more information, see [Amazon S3 Bucket
    /// Keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-key.html) in
    /// the
    /// *Amazon S3 User Guide*.
    ///
    /// * **Directory buckets** -
    /// S3 Bucket Keys are always enabled for `GET` and `PUT` operations in a
    /// directory bucket and can’t be disabled. S3 Bucket Keys aren't supported,
    /// when you copy SSE-KMS encrypted objects from general purpose buckets
    /// to directory buckets, from directory buckets to general purpose buckets, or
    /// between directory buckets, through
    /// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html), [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html), [the Copy operation in Batch Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-objects-Batch-Ops), or
    /// [the import
    /// jobs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-import-job). In this case, Amazon S3 makes a call to KMS every time a copy request is made for a KMS-encrypted object.
    bucket_key_enabled: ?bool = null,
};
