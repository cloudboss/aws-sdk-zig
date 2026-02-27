const S3Grant = @import("s3_grant.zig").S3Grant;
const S3CannedAccessControlList = @import("s3_canned_access_control_list.zig").S3CannedAccessControlList;
const S3ChecksumAlgorithm = @import("s3_checksum_algorithm.zig").S3ChecksumAlgorithm;
const S3MetadataDirective = @import("s3_metadata_directive.zig").S3MetadataDirective;
const S3ObjectMetadata = @import("s3_object_metadata.zig").S3ObjectMetadata;
const S3Tag = @import("s3_tag.zig").S3Tag;
const S3ObjectLockLegalHoldStatus = @import("s3_object_lock_legal_hold_status.zig").S3ObjectLockLegalHoldStatus;
const S3ObjectLockMode = @import("s3_object_lock_mode.zig").S3ObjectLockMode;
const S3StorageClass = @import("s3_storage_class.zig").S3StorageClass;

/// Contains
/// the configuration parameters for a PUT Copy object operation. S3 Batch
/// Operations passes every
/// object to the underlying
/// `CopyObject`
/// API
/// operation. For more information about the parameters for this operation,
/// see
/// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectCOPY.html).
pub const S3CopyObjectOperation = struct {
    /// This functionality is not supported by directory buckets.
    access_control_grants: ?[]const S3Grant,

    /// Specifies whether Amazon S3 should use an S3 Bucket Key for object
    /// encryption with
    /// server-side encryption using Amazon Web Services KMS (SSE-KMS). Setting this
    /// header to `true`
    /// causes Amazon S3 to use an S3 Bucket Key for object encryption with SSE-KMS.
    ///
    /// Specifying this header with an *Copy* action doesn’t affect
    /// *bucket-level* settings for S3 Bucket Key.
    ///
    /// **Directory buckets** - S3 Bucket Keys aren't supported, when you copy
    /// SSE-KMS encrypted objects from general purpose buckets
    /// to directory buckets, from directory buckets to general purpose buckets, or
    /// between directory buckets, through [the Copy operation in Batch
    /// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-objects-Batch-Ops). In this case, Amazon S3 makes a call to KMS every time a copy request is made for a KMS-encrypted object.
    bucket_key_enabled: bool = false,

    /// This functionality is not supported by directory buckets.
    canned_access_control_list: ?S3CannedAccessControlList,

    /// Indicates the algorithm
    /// that
    /// you want Amazon S3 to use to create the checksum. For more
    /// information,
    /// see [ Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_algorithm: ?S3ChecksumAlgorithm,

    metadata_directive: ?S3MetadataDirective,

    modified_since_constraint: ?i64,

    /// If you don't provide this parameter, Amazon S3 copies all the metadata from
    /// the original
    /// objects. If you specify an empty set, the new objects will have no tags.
    /// Otherwise, Amazon S3
    /// assigns the supplied tags to the new objects.
    new_object_metadata: ?S3ObjectMetadata,

    /// Specifies a list of tags to add to the destination objects after they are
    /// copied.
    /// If `NewObjectTagging` is not specified, the tags of the source objects are
    /// copied to destination objects by default.
    ///
    /// **Directory buckets** - Tags aren't supported by directory buckets.
    /// If your source objects have tags and your destination bucket is a directory
    /// bucket, specify an empty tag set in the `NewObjectTagging` field
    /// to prevent copying the source object tags to the directory bucket.
    new_object_tagging: ?[]const S3Tag,

    /// The legal hold status to be applied to all objects in the Batch Operations
    /// job.
    ///
    /// This functionality is not supported by directory buckets.
    object_lock_legal_hold_status: ?S3ObjectLockLegalHoldStatus,

    /// The retention mode to be applied to all objects in the Batch Operations job.
    ///
    /// This functionality is not supported by directory buckets.
    object_lock_mode: ?S3ObjectLockMode,

    /// The date when the applied object retention configuration expires on all
    /// objects in the
    /// Batch Operations job.
    ///
    /// This functionality is not supported by directory buckets.
    object_lock_retain_until_date: ?i64,

    /// If the destination bucket is configured as a website, specifies an optional
    /// metadata property for website redirects,
    /// `x-amz-website-redirect-location`. Allows webpage redirects if the object
    /// copy is
    /// accessed through a website endpoint.
    ///
    /// This functionality is not supported by directory buckets.
    redirect_location: ?[]const u8,

    /// This functionality is not supported by directory buckets.
    requester_pays: bool = false,

    /// Specifies the KMS key ID (Key ID, Key ARN, or Key Alias) to use for object
    /// encryption. If the KMS key doesn't exist in the same
    /// account that's issuing the command, you must use the full Key ARN not the
    /// Key ID.
    ///
    /// **Directory buckets** - If you specify `SSEAlgorithm` with `KMS`, you must
    /// specify the `
    /// SSEAwsKmsKeyId` parameter with the ID (Key ID or Key ARN) of the KMS
    /// symmetric encryption customer managed key to use. Otherwise, you get an HTTP
    /// `400 Bad Request` error. The key alias format of the KMS key isn't
    /// supported. To encrypt new object copies in a directory bucket with SSE-KMS,
    /// you must specify SSE-KMS as the directory bucket's default encryption
    /// configuration with a KMS key (specifically, a [customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk)).
    /// The [Amazon Web Services managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk) (`aws/s3`) isn't supported. Your SSE-KMS configuration can only support 1 [customer managed key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk) per directory bucket for the lifetime of the bucket.
    /// After you specify a customer managed key for SSE-KMS as the bucket default
    /// encryption, you can't override the customer managed key for the bucket's
    /// SSE-KMS configuration.
    /// Then, when you specify server-side encryption settings for new object copies
    /// with SSE-KMS, you must make sure the encryption key is the same customer
    /// managed key that you specified for the directory bucket's default encryption
    /// configuration.
    sse_aws_kms_key_id: ?[]const u8,

    /// Specify the storage class for the destination objects in a `Copy` operation.
    ///
    /// **Directory buckets ** - This functionality is not supported by directory
    /// buckets.
    storage_class: ?S3StorageClass,

    /// Specifies the folder prefix
    /// that
    /// you
    /// want
    /// the objects to be
    /// copied
    /// into. For example, to copy objects into a folder named
    /// `Folder1` in the destination bucket, set the
    /// `TargetKeyPrefix`
    /// property
    /// to `Folder1`.
    target_key_prefix: ?[]const u8,

    /// Specifies the destination bucket
    /// Amazon Resource Name
    /// (ARN)
    /// for the batch copy operation.
    ///
    /// * **General purpose buckets** - For example, to copy objects to a general
    ///   purpose bucket named
    /// `destinationBucket`, set the `TargetResource` property to
    /// `arn:aws:s3:::destinationBucket`.
    ///
    /// * **Directory buckets** - For example, to copy objects to a directory bucket
    ///   named
    /// `destinationBucket` in the Availability Zone identified by the AZ ID
    /// `usw2-az1`, set the `TargetResource` property to
    /// `arn:aws:s3express:*region*:*account_id*:/bucket/*destination_bucket_base_name*--*usw2-az1*--x-s3`. A directory bucket as a destination bucket can be in Availability Zone or Local Zone.
    ///
    /// Copying objects across different Amazon Web Services Regions isn't supported
    /// when the source or destination bucket is in Amazon Web Services Local Zones.
    /// The source and destination buckets must have the same parent Amazon Web
    /// Services Region. Otherwise,
    /// you get an HTTP `400 Bad Request` error with the error code
    /// `InvalidRequest`.
    target_resource: ?[]const u8,

    un_modified_since_constraint: ?i64,
};
