const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ObjectCannedACL = @import("object_canned_acl.zig").ObjectCannedACL;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const MetadataDirective = @import("metadata_directive.zig").MetadataDirective;
const ObjectLockLegalHoldStatus = @import("object_lock_legal_hold_status.zig").ObjectLockLegalHoldStatus;
const ObjectLockMode = @import("object_lock_mode.zig").ObjectLockMode;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const StorageClass = @import("storage_class.zig").StorageClass;
const TaggingDirective = @import("tagging_directive.zig").TaggingDirective;
const CopyObjectResult = @import("copy_object_result.zig").CopyObjectResult;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const serde = @import("serde.zig");

pub const CopyObjectInput = struct {
    /// The canned access control list (ACL) to apply to the object.
    ///
    /// When you copy an object, the ACL metadata is not preserved and is set to
    /// `private` by
    /// default. Only the owner has full access control. To override the default ACL
    /// setting, specify a new ACL
    /// when you generate a copy request. For more information, see [Using
    /// ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html).
    ///
    /// If the destination bucket that you're copying objects to uses the bucket
    /// owner enforced setting for
    /// S3 Object Ownership, ACLs are disabled and no longer affect permissions.
    /// Buckets that use this setting
    /// only accept `PUT` requests that don't specify an ACL or `PUT` requests that
    /// specify bucket owner full control ACLs, such as the
    /// `bucket-owner-full-control` canned ACL or
    /// an equivalent form of this ACL expressed in the XML format. For more
    /// information, see [Controlling ownership
    /// of objects and disabling
    /// ACLs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html) in the *Amazon S3 User Guide*.
    ///
    /// * If your destination bucket uses the bucket owner enforced setting for
    ///   Object Ownership, all
    /// objects written to the bucket by any account will be owned by the bucket
    /// owner.
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    acl: ?ObjectCannedACL = null,

    /// The name of the destination bucket.
    ///
    /// **Directory buckets** - When you use this operation with a directory bucket,
    /// you must use virtual-hosted-style requests in the format `
    /// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`. Path-style
    /// requests are not supported. Directory bucket names must be unique in the
    /// chosen Zone (Availability Zone or Local Zone). Bucket names must follow the
    /// format `
    /// *bucket-base-name*--*zone-id*--x-s3` (for example, `
    /// *amzn-s3-demo-bucket*--*usw2-az1*--x-s3`). For information about bucket
    /// naming
    /// restrictions, see [Directory bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-bucket-naming-rules.html) in the *Amazon S3 User Guide*.
    ///
    /// Copying objects across different Amazon Web Services Regions isn't supported
    /// when the source or destination
    /// bucket is in Amazon Web Services Local Zones. The source and destination
    /// buckets must have the same parent Amazon Web Services Region.
    /// Otherwise, you get an HTTP `400 Bad Request` error with the error code
    /// `InvalidRequest`.
    ///
    /// **Access points** - When you use this action with an access point for
    /// general purpose buckets, you must provide the alias of the access point in
    /// place of the bucket name or specify the access point ARN. When you use this
    /// action with an access point for directory buckets, you must provide the
    /// access point name in place of the bucket name. When using the access point
    /// ARN, you must direct requests to the access point hostname. The access point
    /// hostname takes the form
    /// *AccessPointName*-*AccountId*.s3-accesspoint.*Region*.amazonaws.com. When
    /// using this action with an access point through the Amazon Web Services SDKs,
    /// you provide the access point ARN in place of the bucket name. For more
    /// information about access point ARNs, see [Using access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-access-points.html) in the *Amazon S3 User Guide*.
    ///
    /// Object Lambda access points are not supported by directory buckets.
    ///
    /// **S3 on Outposts** - When you use this action with S3 on Outposts,
    /// you must use the Outpost bucket access point ARN or the access point alias
    /// for the destination bucket.
    /// You can only copy objects within the same Outpost bucket. It's not supported
    /// to copy objects across
    /// different Amazon Web Services Outposts, between buckets on the same
    /// Outposts, or between Outposts buckets and any
    /// other bucket types. For more information about S3 on Outposts, see [What is
    /// S3 on
    /// Outposts?](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the
    /// *S3 on Outposts guide*. When you use this action with S3 on Outposts through
    /// the REST
    /// API, you must direct requests to the S3 on Outposts hostname, in the format
    /// `
    /// *AccessPointName*-*AccountId*.*outpostID*.s3-outposts.*Region*.amazonaws.com`.
    /// The hostname isn't required when you use the Amazon Web Services CLI or
    /// SDKs.
    bucket: []const u8,

    /// Specifies whether Amazon S3 should use an S3 Bucket Key for object
    /// encryption with server-side encryption
    /// using Key Management Service (KMS) keys (SSE-KMS). If a target object uses
    /// SSE-KMS, you can enable an S3 Bucket Key
    /// for the object.
    ///
    /// Setting this header to `true` causes Amazon S3 to use an S3 Bucket Key for
    /// object encryption
    /// with SSE-KMS. Specifying this header with a COPY action doesn’t affect
    /// bucket-level settings for S3
    /// Bucket Key.
    ///
    /// For more information, see [Amazon S3
    /// Bucket
    /// Keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-key.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// **Directory buckets** -
    /// S3 Bucket Keys aren't supported, when you copy SSE-KMS encrypted objects
    /// from general purpose buckets
    /// to directory buckets, from directory buckets to general purpose buckets, or
    /// between directory buckets, through
    /// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html). In this case, Amazon S3 makes a call to KMS every time a copy request is made for a KMS-encrypted object.
    bucket_key_enabled: ?bool = null,

    /// Specifies the caching behavior along the request/reply chain.
    cache_control: ?[]const u8 = null,

    /// Indicates the algorithm that you want Amazon S3 to use to create the
    /// checksum for the object. For more information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// When you copy an object, if the source object has a checksum, that checksum
    /// value will be copied to
    /// the new object by default. If the `CopyObject` request does not include this
    /// `x-amz-checksum-algorithm` header, the checksum algorithm will be copied
    /// from the source
    /// object to the destination object (if it's present on the source object). You
    /// can optionally specify a
    /// different checksum algorithm to use with the `x-amz-checksum-algorithm`
    /// header. Unrecognized
    /// or unsupported values will respond with the HTTP status code `400 Bad
    /// Request`.
    ///
    /// For directory buckets, when you use Amazon Web Services SDKs, `CRC32` is the
    /// default checksum algorithm that's used for performance.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// Specifies presentational information for the object. Indicates whether an
    /// object should be displayed
    /// in a web browser or downloaded as a file. It allows specifying the desired
    /// filename for the downloaded
    /// file.
    content_disposition: ?[]const u8 = null,

    /// Specifies what content encodings have been applied to the object and thus
    /// what decoding mechanisms
    /// must be applied to obtain the media-type referenced by the Content-Type
    /// header field.
    ///
    /// For directory buckets, only the `aws-chunked` value is supported in this
    /// header field.
    content_encoding: ?[]const u8 = null,

    /// The language the content is in.
    content_language: ?[]const u8 = null,

    /// A standard MIME type that describes the format of the object data.
    content_type: ?[]const u8 = null,

    /// Specifies the source object for the copy operation. The source object can be
    /// up to 5 GB. If the
    /// source object is an object that was uploaded by using a multipart upload,
    /// the object copy will be a
    /// single part object after the source object is copied to the destination
    /// bucket.
    ///
    /// You specify the value of the copy source in one of two formats, depending on
    /// whether you want to
    /// access the source object through an [access
    /// point](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points.html):
    ///
    /// * For objects not accessed through an access point, specify the name of the
    ///   source bucket and the key of
    /// the source object, separated by a slash (/). For example, to copy the object
    /// `reports/january.pdf` from the general purpose bucket `awsexamplebucket`,
    /// use
    /// `awsexamplebucket/reports/january.pdf`. The value must be URL-encoded. To
    /// copy the
    /// object `reports/january.pdf` from the directory bucket
    /// `awsexamplebucket--use1-az5--x-s3`, use
    /// `awsexamplebucket--use1-az5--x-s3/reports/january.pdf`. The value must be
    /// URL-encoded.
    ///
    /// * For objects accessed through access points, specify the Amazon Resource
    ///   Name (ARN) of the object as accessed through the access point, in the
    ///   format `arn:aws:s3:::accesspoint//object/`. For example, to copy the
    ///   object `reports/january.pdf` through access point `my-access-point` owned
    ///   by account `123456789012` in Region `us-west-2`, use the URL encoding of
    ///   `arn:aws:s3:us-west-2:123456789012:accesspoint/my-access-point/object/reports/january.pdf`. The value must be URL encoded.
    ///
    /// * Amazon S3 supports copy operations using Access points only when the
    ///   source and destination buckets are in the same Amazon Web Services Region.
    ///
    /// * Access points are not supported by directory buckets.
    ///
    /// Alternatively, for objects accessed through Amazon S3 on Outposts, specify
    /// the ARN of the object as accessed in the format
    /// `arn:aws:s3-outposts:::outpost//object/`. For example, to copy the object
    /// `reports/january.pdf` through outpost `my-outpost` owned by account
    /// `123456789012` in Region `us-west-2`, use the URL encoding of
    /// `arn:aws:s3-outposts:us-west-2:123456789012:outpost/my-outpost/object/reports/january.pdf`. The value must be URL-encoded.
    ///
    /// If your source bucket versioning is enabled, the `x-amz-copy-source` header
    /// by default
    /// identifies the current version of an object to copy. If the current version
    /// is a delete marker, Amazon S3
    /// behaves as if the object was deleted. To copy a different version, use the
    /// `versionId` query
    /// parameter. Specifically, append `?versionId=` to the value (for example,
    /// `awsexamplebucket/reports/january.pdf?versionId=QUpfdndhfd8438MNFDN93jdnJFkdmqnh893`). If
    /// you don't specify a version ID, Amazon S3 copies the latest version of the
    /// source object.
    ///
    /// If you enable versioning on the destination bucket, Amazon S3 generates a
    /// unique version ID for the
    /// copied object. This version ID is different from the version ID of the
    /// source object. Amazon S3 returns the
    /// version ID of the copied object in the `x-amz-version-id` response header in
    /// the
    /// response.
    ///
    /// If you do not enable versioning or suspend it on the destination bucket, the
    /// version ID that Amazon S3
    /// generates in the `x-amz-version-id` response header is always null.
    ///
    /// **Directory buckets** - S3 Versioning isn't enabled and supported for
    /// directory buckets.
    copy_source: []const u8,

    /// Copies the object if its entity tag (ETag) matches the specified tag.
    ///
    /// If both the `x-amz-copy-source-if-match` and
    /// `x-amz-copy-source-if-unmodified-since` headers are present in the request
    /// and evaluate as
    /// follows, Amazon S3 returns `200 OK` and copies the data:
    ///
    /// * `x-amz-copy-source-if-match` condition evaluates to true
    ///
    /// * `x-amz-copy-source-if-unmodified-since` condition evaluates to false
    copy_source_if_match: ?[]const u8 = null,

    /// Copies the object if it has been modified since the specified time.
    ///
    /// If both the `x-amz-copy-source-if-none-match` and
    /// `x-amz-copy-source-if-modified-since` headers are present in the request and
    /// evaluate as
    /// follows, Amazon S3 returns the `412 Precondition Failed` response code:
    ///
    /// * `x-amz-copy-source-if-none-match` condition evaluates to false
    ///
    /// * `x-amz-copy-source-if-modified-since` condition evaluates to true
    copy_source_if_modified_since: ?i64 = null,

    /// Copies the object if its entity tag (ETag) is different than the specified
    /// ETag.
    ///
    /// If both the `x-amz-copy-source-if-none-match` and
    /// `x-amz-copy-source-if-modified-since` headers are present in the request and
    /// evaluate as
    /// follows, Amazon S3 returns the `412 Precondition Failed` response code:
    ///
    /// * `x-amz-copy-source-if-none-match` condition evaluates to false
    ///
    /// * `x-amz-copy-source-if-modified-since` condition evaluates to true
    copy_source_if_none_match: ?[]const u8 = null,

    /// Copies the object if it hasn't been modified since the specified time.
    ///
    /// If both the `x-amz-copy-source-if-match` and
    /// `x-amz-copy-source-if-unmodified-since` headers are present in the request
    /// and evaluate as
    /// follows, Amazon S3 returns `200 OK` and copies the data:
    ///
    /// * `x-amz-copy-source-if-match` condition evaluates to true
    ///
    /// * `x-amz-copy-source-if-unmodified-since` condition evaluates to false
    copy_source_if_unmodified_since: ?i64 = null,

    /// Specifies the algorithm to use when decrypting the source object (for
    /// example,
    /// `AES256`).
    ///
    /// If the source object for the copy is stored in Amazon S3 using SSE-C, you
    /// must provide the necessary
    /// encryption information in your request so that Amazon S3 can decrypt the
    /// object for copying.
    ///
    /// This functionality is not supported when the source object is in a directory
    /// bucket.
    copy_source_sse_customer_algorithm: ?[]const u8 = null,

    /// Specifies the customer-provided encryption key for Amazon S3 to use to
    /// decrypt the source object. The
    /// encryption key provided in this header must be the same one that was used
    /// when the source object was
    /// created.
    ///
    /// If the source object for the copy is stored in Amazon S3 using SSE-C, you
    /// must provide the necessary
    /// encryption information in your request so that Amazon S3 can decrypt the
    /// object for copying.
    ///
    /// This functionality is not supported when the source object is in a directory
    /// bucket.
    copy_source_sse_customer_key: ?[]const u8 = null,

    /// Specifies the 128-bit MD5 digest of the encryption key according to RFC
    /// 1321. Amazon S3 uses this header
    /// for a message integrity check to ensure that the encryption key was
    /// transmitted without error.
    ///
    /// If the source object for the copy is stored in Amazon S3 using SSE-C, you
    /// must provide the necessary
    /// encryption information in your request so that Amazon S3 can decrypt the
    /// object for copying.
    ///
    /// This functionality is not supported when the source object is in a directory
    /// bucket.
    copy_source_sse_customer_key_md5: ?[]const u8 = null,

    /// The account ID of the expected destination bucket owner. If the account ID
    /// that you provide does not match the actual owner of the destination bucket,
    /// the request fails with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The account ID of the expected source bucket owner. If the account ID that
    /// you provide does not match the actual owner of the source bucket, the
    /// request fails with the HTTP status code `403 Forbidden` (access denied).
    expected_source_bucket_owner: ?[]const u8 = null,

    /// The date and time at which the object is no longer cacheable.
    expires: ?[]const u8 = null,

    /// Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    grant_full_control: ?[]const u8 = null,

    /// Allows grantee to read the object data and its metadata.
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    grant_read: ?[]const u8 = null,

    /// Allows grantee to read the object ACL.
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    grant_read_acp: ?[]const u8 = null,

    /// Allows grantee to write the ACL for the applicable object.
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    grant_write_acp: ?[]const u8 = null,

    /// Copies the object if the entity tag (ETag) of the destination object matches
    /// the specified
    /// tag. If the ETag values do not match, the operation returns a `412
    /// Precondition
    /// Failed` error. If a concurrent operation occurs during the upload S3 returns
    /// a
    /// `409 ConditionalRequestConflict` response. On a 409 failure you should fetch
    /// the
    /// object's ETag and retry the upload.
    ///
    /// Expects the ETag value as a string.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_match: ?[]const u8 = null,

    /// Copies the object only if the object key name at the destination does not
    /// already exist in
    /// the bucket specified. Otherwise, Amazon S3 returns a `412 Precondition
    /// Failed` error. If a
    /// concurrent operation occurs during the upload S3 returns a `409
    /// ConditionalRequestConflict`
    /// response. On a 409 failure you should retry the upload.
    ///
    /// Expects the '*' (asterisk) character.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_none_match: ?[]const u8 = null,

    /// The key of the destination object.
    key: []const u8,

    /// A map of metadata to store with the object in S3.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether the metadata is copied from the source object or replaced
    /// with metadata that's
    /// provided in the request. When copying an object, you can preserve all
    /// metadata (the default) or specify
    /// new metadata. If this header isn’t specified, `COPY` is the default
    /// behavior.
    ///
    /// **General purpose bucket** - For general purpose buckets, when you grant
    /// permissions, you can use the `s3:x-amz-metadata-directive` condition key to
    /// enforce certain
    /// metadata behavior when objects are uploaded. For more information, see
    /// [Amazon S3 condition key
    /// examples](https://docs.aws.amazon.com/AmazonS3/latest/dev/amazon-s3-policy-keys.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// `x-amz-website-redirect-location` is unique to each object and is not copied
    /// when using
    /// the `x-amz-metadata-directive` header. To copy the value, you must specify
    /// `x-amz-website-redirect-location` in the request header.
    metadata_directive: ?MetadataDirective = null,

    /// Specifies whether you want to apply a legal hold to the object copy.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_legal_hold_status: ?ObjectLockLegalHoldStatus = null,

    /// The Object Lock mode that you want to apply to the object copy.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_mode: ?ObjectLockMode = null,

    /// The date and time when you want the Object Lock of the object copy to
    /// expire.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_retain_until_date: ?i64 = null,

    request_payer: ?RequestPayer = null,

    /// The server-side encryption algorithm used when storing this object in Amazon
    /// S3. Unrecognized or
    /// unsupported values won’t write a destination object and will receive a `400
    /// Bad Request`
    /// response.
    ///
    /// Amazon S3 automatically encrypts all new objects that are copied to an S3
    /// bucket. When copying an object,
    /// if you don't specify encryption information in your copy request, the
    /// encryption setting of the target
    /// object is set to the default encryption configuration of the destination
    /// bucket. By default, all buckets
    /// have a base level of encryption configuration that uses server-side
    /// encryption with Amazon S3 managed keys
    /// (SSE-S3). If the destination bucket has a different default encryption
    /// configuration, Amazon S3 uses the
    /// corresponding encryption key to encrypt the target object copy.
    ///
    /// With server-side encryption, Amazon S3 encrypts your data as it writes your
    /// data to disks in its data
    /// centers and decrypts the data when you access it. For more information about
    /// server-side encryption, see
    /// [Using Server-Side
    /// Encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html) in the *Amazon S3 User Guide*.
    ///
    /// **General purpose buckets **
    ///
    /// * For general purpose buckets, there are the following supported options for
    ///   server-side encryption:
    /// server-side encryption with Key Management Service (KMS) keys (SSE-KMS),
    /// dual-layer server-side encryption with
    /// Amazon Web Services KMS keys (DSSE-KMS), and server-side encryption with
    /// customer-provided encryption keys
    /// (SSE-C). Amazon S3 uses the corresponding KMS key, or a customer-provided
    /// key to encrypt the target
    /// object copy.
    ///
    /// * When you perform a `CopyObject` operation, if you want to use a different
    ///   type of
    /// encryption setting for the target object, you can specify appropriate
    /// encryption-related headers to
    /// encrypt the target object with an Amazon S3 managed key, a KMS key, or a
    /// customer-provided key. If the
    /// encryption setting in your request is different from the default encryption
    /// configuration of the
    /// destination bucket, the encryption setting in your request takes precedence.
    ///
    /// **Directory buckets **
    ///
    /// * For directory buckets, there are only two supported options for
    ///   server-side encryption: server-side encryption with Amazon S3 managed keys
    ///   (SSE-S3) (`AES256`) and server-side encryption with KMS keys (SSE-KMS)
    ///   (`aws:kms`). We recommend that the bucket's default encryption uses the
    ///   desired encryption configuration and you don't override the bucket default
    ///   encryption in your
    /// `CreateSession` requests or `PUT` object requests. Then, new objects
    /// are automatically encrypted with the desired encryption settings. For more
    /// information, see [Protecting data with server-side
    /// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-serv-side-encryption.html) in the *Amazon S3 User Guide*. For more information about the encryption overriding behaviors in directory buckets, see [Specifying server-side encryption with KMS for new object uploads](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-specifying-kms-encryption.html).
    ///
    /// * To encrypt new object copies to a directory bucket with SSE-KMS, we
    ///   recommend you specify
    /// SSE-KMS as the directory bucket's default encryption configuration with a
    /// KMS key
    /// (specifically, a [customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk)). The [Amazon Web Services managed key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk) (`aws/s3`) isn't supported. Your SSE-KMS configuration can
    /// only support 1 [customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk) per
    /// directory bucket for the lifetime of the bucket. After you specify a
    /// customer managed key for SSE-KMS, you
    /// can't override the customer managed key for the bucket's SSE-KMS
    /// configuration. Then, when you
    /// perform a `CopyObject` operation and want to specify server-side encryption
    /// settings for
    /// new object copies with SSE-KMS in the encryption-related request headers,
    /// you must ensure the
    /// encryption key is the same customer managed key that you specified for the
    /// directory bucket's default
    /// encryption configuration.
    ///
    /// * **S3 access points for Amazon FSx ** - When accessing data stored in
    /// Amazon FSx file systems using S3 access points, the only valid server side
    /// encryption option is
    /// `aws:fsx`. All Amazon FSx file systems have encryption configured by default
    /// and are
    /// encrypted at rest. Data is automatically encrypted before being written to
    /// the file system, and
    /// automatically decrypted as it is read. These processes are handled
    /// transparently by Amazon FSx.
    server_side_encryption: ?ServerSideEncryption = null,

    /// Specifies the algorithm to use when encrypting the object (for example,
    /// `AES256`).
    ///
    /// When you perform a `CopyObject` operation, if you want to use a different
    /// type of
    /// encryption setting for the target object, you can specify appropriate
    /// encryption-related headers to
    /// encrypt the target object with an Amazon S3 managed key, a KMS key, or a
    /// customer-provided key. If the
    /// encryption setting in your request is different from the default encryption
    /// configuration of the
    /// destination bucket, the encryption setting in your request takes precedence.
    ///
    /// This functionality is not supported when the destination bucket is a
    /// directory bucket.
    sse_customer_algorithm: ?[]const u8 = null,

    /// Specifies the customer-provided encryption key for Amazon S3 to use in
    /// encrypting data. This value is
    /// used to store the object and then it is discarded. Amazon S3 does not store
    /// the encryption key. The key must
    /// be appropriate for use with the algorithm specified in the
    /// `x-amz-server-side-encryption-customer-algorithm` header.
    ///
    /// This functionality is not supported when the destination bucket is a
    /// directory bucket.
    sse_customer_key: ?[]const u8 = null,

    /// Specifies the 128-bit MD5 digest of the encryption key according to RFC
    /// 1321. Amazon S3 uses this header
    /// for a message integrity check to ensure that the encryption key was
    /// transmitted without error.
    ///
    /// This functionality is not supported when the destination bucket is a
    /// directory bucket.
    sse_customer_key_md5: ?[]const u8 = null,

    /// Specifies the Amazon Web Services KMS Encryption Context as an additional
    /// encryption context to use for the
    /// destination object encryption. The value of this header is a base64-encoded
    /// UTF-8 string holding JSON
    /// with the encryption context key-value pairs.
    ///
    /// **General purpose buckets** - This value must be explicitly added to
    /// specify encryption context for `CopyObject` requests if you want an
    /// additional encryption
    /// context for your destination object. The additional encryption context of
    /// the source object won't be
    /// copied to the destination object. For more information, see [Encryption
    /// context](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html#encryption-context)
    /// in the *Amazon S3 User Guide*.
    ///
    /// **Directory buckets** - You can optionally provide an explicit encryption
    /// context value. The value must match the default encryption context - the
    /// bucket Amazon Resource Name (ARN). An additional encryption context value is
    /// not supported.
    ssekms_encryption_context: ?[]const u8 = null,

    /// Specifies the KMS key ID (Key ID, Key ARN, or Key Alias) to use for object
    /// encryption. All GET and
    /// PUT requests for an object protected by KMS will fail if they're not made
    /// via SSL or using SigV4. For
    /// information about configuring any of the officially supported Amazon Web
    /// Services SDKs and Amazon Web Services CLI, see [Specifying
    /// the Signature Version in Request
    /// Authentication](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version) in the
    /// *Amazon S3 User Guide*.
    ///
    /// **Directory buckets** -
    /// To encrypt data using SSE-KMS, it's recommended to specify the
    /// `x-amz-server-side-encryption` header to `aws:kms`. Then, the
    /// `x-amz-server-side-encryption-aws-kms-key-id` header implicitly uses
    /// the bucket's default KMS customer managed key ID. If you want to explicitly
    /// set the `
    /// x-amz-server-side-encryption-aws-kms-key-id` header, it must match the
    /// bucket's default customer managed key (using key ID or ARN, not alias). Your
    /// SSE-KMS configuration can only support 1 [customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk) per directory bucket's lifetime.
    /// The [Amazon Web Services managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk) (`aws/s3`) isn't supported.
    ///
    /// Incorrect key specification results in an HTTP `400 Bad Request` error.
    ssekms_key_id: ?[]const u8 = null,

    /// If the `x-amz-storage-class` header is not used, the copied object will be
    /// stored in the
    /// `STANDARD` Storage Class by default. The `STANDARD` storage class provides
    /// high
    /// durability and high availability. Depending on performance needs, you can
    /// specify a different Storage
    /// Class.
    ///
    /// * **Directory buckets ** -
    /// Directory buckets only support `EXPRESS_ONEZONE` (the S3 Express One Zone
    /// storage class) in Availability Zones and `ONEZONE_IA` (the S3 One
    /// Zone-Infrequent Access storage class) in Dedicated Local Zones.
    /// Unsupported storage class values won't write a destination object and will
    /// respond with the HTTP status code `400 Bad Request`.
    ///
    /// * **Amazon S3 on Outposts ** - S3 on Outposts only uses the
    /// `OUTPOSTS` Storage Class.
    ///
    /// You can use the `CopyObject` action to change the storage class of an object
    /// that is
    /// already stored in Amazon S3 by using the `x-amz-storage-class` header. For
    /// more information, see
    /// [Storage
    /// Classes](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html)
    /// in the *Amazon S3 User Guide*.
    ///
    /// Before using an object as a source object for the copy operation, you must
    /// restore a copy of it if
    /// it meets any of the following conditions:
    ///
    /// * The storage class of the source object is `GLACIER` or
    /// `DEEP_ARCHIVE`.
    ///
    /// * The storage class of the source object is `INTELLIGENT_TIERING` and it's
    ///   [S3
    /// Intelligent-Tiering access
    /// tier](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intelligent-tiering-overview.html#intel-tiering-tier-definition) is `Archive Access` or `Deep Archive
    /// Access`.
    ///
    /// For more information, see
    /// [RestoreObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_RestoreObject.html) and [Copying Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/CopyingObjectsExamples.html) in the
    /// *Amazon S3 User Guide*.
    storage_class: ?StorageClass = null,

    /// The tag-set for the object copy in the destination bucket. This value must
    /// be used in conjunction
    /// with the `x-amz-tagging-directive` if you choose `REPLACE` for the
    /// `x-amz-tagging-directive`. If you choose `COPY` for the
    /// `x-amz-tagging-directive`, you don't need to set the `x-amz-tagging` header,
    /// because the tag-set will be copied from the source object directly. The
    /// tag-set must be encoded as URL
    /// Query parameters.
    ///
    /// The default value is the empty value.
    ///
    /// **Directory buckets** - For directory buckets in a `CopyObject` operation,
    /// only the empty tag-set is supported. Any requests that attempt to write
    /// non-empty tags into directory buckets will receive a `501 Not Implemented`
    /// status code.
    /// When the destination bucket is a directory bucket, you will receive a `501
    /// Not Implemented` response in any of the following situations:
    ///
    /// * When you attempt to `COPY` the tag-set from an S3 source object that has
    ///   non-empty tags.
    ///
    /// * When you attempt to `REPLACE` the tag-set of a source object and set a
    ///   non-empty value to `x-amz-tagging`.
    ///
    /// * When you don't set the `x-amz-tagging-directive` header and the source
    ///   object has non-empty tags. This is because the default value of
    ///   `x-amz-tagging-directive` is `COPY`.
    ///
    /// Because only the empty tag-set is supported for directory buckets in a
    /// `CopyObject` operation, the following situations are allowed:
    ///
    /// * When you attempt to `COPY` the tag-set from a directory bucket source
    ///   object that has no tags to a general purpose bucket. It copies an empty
    ///   tag-set to the destination object.
    ///
    /// * When you attempt to `REPLACE` the tag-set of a directory bucket source
    ///   object and set the `x-amz-tagging` value of the directory bucket
    ///   destination object to empty.
    ///
    /// * When you attempt to `REPLACE` the tag-set of a general purpose bucket
    ///   source object that has non-empty tags and set the `x-amz-tagging` value of
    ///   the directory bucket destination object to empty.
    ///
    /// * When you attempt to `REPLACE` the tag-set of a directory bucket source
    ///   object and don't set the `x-amz-tagging` value of the directory bucket
    ///   destination object. This is because the default value of `x-amz-tagging`
    ///   is the empty value.
    tagging: ?[]const u8 = null,

    /// Specifies whether the object tag-set is copied from the source object or
    /// replaced with the tag-set
    /// that's provided in the request.
    ///
    /// The default value is `COPY`.
    ///
    /// **Directory buckets** - For directory buckets in a `CopyObject` operation,
    /// only the empty tag-set is supported. Any requests that attempt to write
    /// non-empty tags into directory buckets will receive a `501 Not Implemented`
    /// status code.
    /// When the destination bucket is a directory bucket, you will receive a `501
    /// Not Implemented` response in any of the following situations:
    ///
    /// * When you attempt to `COPY` the tag-set from an S3 source object that has
    ///   non-empty tags.
    ///
    /// * When you attempt to `REPLACE` the tag-set of a source object and set a
    ///   non-empty value to `x-amz-tagging`.
    ///
    /// * When you don't set the `x-amz-tagging-directive` header and the source
    ///   object has non-empty tags. This is because the default value of
    ///   `x-amz-tagging-directive` is `COPY`.
    ///
    /// Because only the empty tag-set is supported for directory buckets in a
    /// `CopyObject` operation, the following situations are allowed:
    ///
    /// * When you attempt to `COPY` the tag-set from a directory bucket source
    ///   object that has no tags to a general purpose bucket. It copies an empty
    ///   tag-set to the destination object.
    ///
    /// * When you attempt to `REPLACE` the tag-set of a directory bucket source
    ///   object and set the `x-amz-tagging` value of the directory bucket
    ///   destination object to empty.
    ///
    /// * When you attempt to `REPLACE` the tag-set of a general purpose bucket
    ///   source object that has non-empty tags and set the `x-amz-tagging` value of
    ///   the directory bucket destination object to empty.
    ///
    /// * When you attempt to `REPLACE` the tag-set of a directory bucket source
    ///   object and don't set the `x-amz-tagging` value of the directory bucket
    ///   destination object. This is because the default value of `x-amz-tagging`
    ///   is the empty value.
    tagging_directive: ?TaggingDirective = null,

    /// If the destination bucket is configured as a website, redirects requests for
    /// this object copy to
    /// another object in the same bucket or to an external URL. Amazon S3 stores
    /// the value of this header in the
    /// object metadata. This value is unique to each object and is not copied when
    /// using the
    /// `x-amz-metadata-directive` header. Instead, you may opt to provide this
    /// header in
    /// combination with the `x-amz-metadata-directive` header.
    ///
    /// This functionality is not supported for directory buckets.
    website_redirect_location: ?[]const u8 = null,
};

pub const CopyObjectOutput = struct {
    /// Indicates whether the copied object uses an S3 Bucket Key for server-side
    /// encryption with Key Management Service
    /// (KMS) keys (SSE-KMS).
    bucket_key_enabled: ?bool = null,

    /// Container for all response elements.
    copy_object_result: ?CopyObjectResult = null,

    /// Version ID of the source object that was copied.
    ///
    /// This functionality is not supported when the source object is in a directory
    /// bucket.
    copy_source_version_id: ?[]const u8 = null,

    /// If the object expiration is configured, the response includes this header.
    ///
    /// Object expiration information is not returned in directory buckets and this
    /// header returns the
    /// value "`NotImplemented`" in all responses for directory buckets.
    expiration: ?[]const u8 = null,

    request_charged: ?RequestCharged = null,

    /// The server-side encryption algorithm used when you store this object in
    /// Amazon S3 or Amazon FSx.
    ///
    /// When accessing data stored in Amazon FSx file systems using S3 access
    /// points, the only valid server side
    /// encryption option is `aws:fsx`.
    server_side_encryption: ?ServerSideEncryption = null,

    /// If server-side encryption with a customer-provided encryption key was
    /// requested, the response will
    /// include this header to confirm the encryption algorithm that's used.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_algorithm: ?[]const u8 = null,

    /// If server-side encryption with a customer-provided encryption key was
    /// requested, the response will
    /// include this header to provide the round-trip message integrity verification
    /// of the customer-provided
    /// encryption key.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key_md5: ?[]const u8 = null,

    /// If present, indicates the Amazon Web Services KMS Encryption Context to use
    /// for object encryption. The value of
    /// this header is a Base64 encoded UTF-8 string holding JSON with the
    /// encryption context key-value
    /// pairs.
    ssekms_encryption_context: ?[]const u8 = null,

    /// If present, indicates the ID of the KMS key that was used for object
    /// encryption.
    ssekms_key_id: ?[]const u8 = null,

    /// Version ID of the newly created copy.
    ///
    /// This functionality is not supported for directory buckets.
    version_id: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyObjectInput, options: Options) !CopyObjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CopyObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.key);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "x-id=CopyObject");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(allocator, "<CopyObjectRequest>");
    if (input.metadata) |v| {
        try body_buf.appendSlice(allocator, "<Metadata>");
        try serde.serializeMetadata(allocator, &body_buf, v, "entry");
        try body_buf.appendSlice(allocator, "</Metadata>");
    }
    try body_buf.appendSlice(allocator, "</CopyObjectRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    if (input.acl) |v| {
        try request.headers.put(allocator, "x-amz-acl", @tagName(v));
    }
    if (input.bucket_key_enabled) |v| {
        try request.headers.put(allocator, "x-amz-server-side-encryption-bucket-key-enabled", if (v) "true" else "false");
    }
    if (input.cache_control) |v| {
        try request.headers.put(allocator, "Cache-Control", v);
    }
    if (input.checksum_algorithm) |v| {
        try request.headers.put(allocator, "x-amz-checksum-algorithm", @tagName(v));
    }
    if (input.content_disposition) |v| {
        try request.headers.put(allocator, "Content-Disposition", v);
    }
    if (input.content_encoding) |v| {
        try request.headers.put(allocator, "Content-Encoding", v);
    }
    if (input.content_language) |v| {
        try request.headers.put(allocator, "Content-Language", v);
    }
    if (input.content_type) |v| {
        try request.headers.put(allocator, "Content-Type", v);
    }
    try request.headers.put(allocator, "x-amz-copy-source", input.copy_source);
    if (input.copy_source_if_match) |v| {
        try request.headers.put(allocator, "x-amz-copy-source-if-match", v);
    }
    if (input.copy_source_if_modified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "x-amz-copy-source-if-modified-since", num_str);
        }
    }
    if (input.copy_source_if_none_match) |v| {
        try request.headers.put(allocator, "x-amz-copy-source-if-none-match", v);
    }
    if (input.copy_source_if_unmodified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "x-amz-copy-source-if-unmodified-since", num_str);
        }
    }
    if (input.copy_source_sse_customer_algorithm) |v| {
        try request.headers.put(allocator, "x-amz-copy-source-server-side-encryption-customer-algorithm", v);
    }
    if (input.copy_source_sse_customer_key) |v| {
        try request.headers.put(allocator, "x-amz-copy-source-server-side-encryption-customer-key", v);
    }
    if (input.copy_source_sse_customer_key_md5) |v| {
        try request.headers.put(allocator, "x-amz-copy-source-server-side-encryption-customer-key-MD5", v);
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }
    if (input.expected_source_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-source-expected-bucket-owner", v);
    }
    if (input.expires) |v| {
        try request.headers.put(allocator, "Expires", v);
    }
    if (input.grant_full_control) |v| {
        try request.headers.put(allocator, "x-amz-grant-full-control", v);
    }
    if (input.grant_read) |v| {
        try request.headers.put(allocator, "x-amz-grant-read", v);
    }
    if (input.grant_read_acp) |v| {
        try request.headers.put(allocator, "x-amz-grant-read-acp", v);
    }
    if (input.grant_write_acp) |v| {
        try request.headers.put(allocator, "x-amz-grant-write-acp", v);
    }
    if (input.if_match) |v| {
        try request.headers.put(allocator, "If-Match", v);
    }
    if (input.if_none_match) |v| {
        try request.headers.put(allocator, "If-None-Match", v);
    }
    if (input.metadata_directive) |v| {
        try request.headers.put(allocator, "x-amz-metadata-directive", @tagName(v));
    }
    if (input.object_lock_legal_hold_status) |v| {
        try request.headers.put(allocator, "x-amz-object-lock-legal-hold", @tagName(v));
    }
    if (input.object_lock_mode) |v| {
        try request.headers.put(allocator, "x-amz-object-lock-mode", @tagName(v));
    }
    if (input.object_lock_retain_until_date) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "x-amz-object-lock-retain-until-date", num_str);
        }
    }
    if (input.request_payer) |v| {
        try request.headers.put(allocator, "x-amz-request-payer", @tagName(v));
    }
    if (input.server_side_encryption) |v| {
        try request.headers.put(allocator, "x-amz-server-side-encryption", @tagName(v));
    }
    if (input.sse_customer_algorithm) |v| {
        try request.headers.put(allocator, "x-amz-server-side-encryption-customer-algorithm", v);
    }
    if (input.sse_customer_key) |v| {
        try request.headers.put(allocator, "x-amz-server-side-encryption-customer-key", v);
    }
    if (input.sse_customer_key_md5) |v| {
        try request.headers.put(allocator, "x-amz-server-side-encryption-customer-key-MD5", v);
    }
    if (input.ssekms_encryption_context) |v| {
        try request.headers.put(allocator, "x-amz-server-side-encryption-context", v);
    }
    if (input.ssekms_key_id) |v| {
        try request.headers.put(allocator, "x-amz-server-side-encryption-aws-kms-key-id", v);
    }
    if (input.storage_class) |v| {
        try request.headers.put(allocator, "x-amz-storage-class", @tagName(v));
    }
    if (input.tagging) |v| {
        try request.headers.put(allocator, "x-amz-tagging", v);
    }
    if (input.tagging_directive) |v| {
        try request.headers.put(allocator, "x-amz-tagging-directive", @tagName(v));
    }
    if (input.website_redirect_location) |v| {
        try request.headers.put(allocator, "x-amz-website-redirect-location", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyObjectOutput {
    var result: CopyObjectOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("x-amz-server-side-encryption-bucket-key-enabled")) |value| {
        result.bucket_key_enabled = std.mem.eql(u8, value, "true");
    }
    if (headers.get("x-amz-copy-source-version-id")) |value| {
        result.copy_source_version_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-expiration")) |value| {
        result.expiration = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = std.meta.stringToEnum(RequestCharged, value);
    }
    if (headers.get("x-amz-server-side-encryption")) |value| {
        result.server_side_encryption = std.meta.stringToEnum(ServerSideEncryption, value);
    }
    if (headers.get("x-amz-server-side-encryption-customer-algorithm")) |value| {
        result.sse_customer_algorithm = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-customer-key-md5")) |value| {
        result.sse_customer_key_md5 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-context")) |value| {
        result.ssekms_encryption_context = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-aws-kms-key-id")) |value| {
        result.ssekms_key_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-version-id")) |value| {
        result.version_id = try allocator.dupe(u8, value);
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AccessDenied")) {
        return .{ .arena = arena, .kind = .{ .access_denied = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_owned_by_you = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionTypeMismatch")) {
        return .{ .arena = arena, .kind = .{ .encryption_type_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatch")) {
        return .{ .arena = arena, .kind = .{ .idempotency_parameter_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidObjectState")) {
        return .{ .arena = arena, .kind = .{ .invalid_object_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        return .{ .arena = arena, .kind = .{ .invalid_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWriteOffset")) {
        return .{ .arena = arena, .kind = .{ .invalid_write_offset = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucket")) {
        return .{ .arena = arena, .kind = .{ .no_such_bucket = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKey")) {
        return .{ .arena = arena, .kind = .{ .no_such_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchUpload")) {
        return .{ .arena = arena, .kind = .{ .no_such_upload = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFound")) {
        return .{ .arena = arena, .kind = .{ .not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectAlreadyInActiveTierError")) {
        return .{ .arena = arena, .kind = .{ .object_already_in_active_tier_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotInActiveTierError")) {
        return .{ .arena = arena, .kind = .{ .object_not_in_active_tier_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyParts")) {
        return .{ .arena = arena, .kind = .{ .too_many_parts = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
