const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ObjectCannedACL = @import("object_canned_acl.zig").ObjectCannedACL;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ObjectLockLegalHoldStatus = @import("object_lock_legal_hold_status.zig").ObjectLockLegalHoldStatus;
const ObjectLockMode = @import("object_lock_mode.zig").ObjectLockMode;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const StorageClass = @import("storage_class.zig").StorageClass;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const serde = @import("serde.zig");

pub const PutObjectInput = struct {
    /// The canned ACL to apply to the object. For more information, see [Canned
    /// ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL) in the
    /// *Amazon S3 User Guide*.
    ///
    /// When adding a new object, you can use headers to grant ACL-based permissions
    /// to individual
    /// Amazon Web Services accounts or to predefined groups defined by Amazon S3.
    /// These permissions are then added to the ACL on
    /// the object. By default, all objects are private. Only the owner has full
    /// access control. For more
    /// information, see [Access Control
    /// List (ACL)
    /// Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html)
    /// and [Managing ACLs Using the REST
    /// API](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-using-rest-api.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// If the bucket that you're uploading objects to uses the bucket owner
    /// enforced setting for S3 Object
    /// Ownership, ACLs are disabled and no longer affect permissions. Buckets that
    /// use this setting only accept
    /// PUT requests that don't specify an ACL or PUT requests that specify bucket
    /// owner full control ACLs, such
    /// as the `bucket-owner-full-control` canned ACL or an equivalent form of this
    /// ACL expressed in
    /// the XML format. PUT requests that contain other ACLs (for example, custom
    /// grants to certain
    /// Amazon Web Services accounts) fail and return a `400` error with the error
    /// code
    /// `AccessControlListNotSupported`. For more information, see [ Controlling
    /// ownership of objects and
    /// disabling
    /// ACLs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html) in the *Amazon S3 User Guide*.
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    acl: ?ObjectCannedACL = null,

    /// Object data.
    body: ?[]const u8 = null,

    /// The bucket name to which the PUT action was initiated.
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
    /// **S3 on Outposts** - When you use this action with S3 on Outposts, you must
    /// direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname
    /// takes the
    /// form `
    /// *AccessPointName*-*AccountId*.*outpostID*.s3-outposts.*Region*.amazonaws.com`. When you use this action with S3 on Outposts, the destination bucket must be the Outposts access point ARN or the access point alias. For more information about S3 on Outposts, see [What is S3 on Outposts?](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the *Amazon S3 User Guide*.
    bucket: []const u8,

    /// Specifies whether Amazon S3 should use an S3 Bucket Key for object
    /// encryption with
    /// server-side encryption using Key Management Service (KMS) keys (SSE-KMS).
    ///
    /// **General purpose buckets** - Setting this header to
    /// `true` causes Amazon S3 to use an S3 Bucket Key for object encryption with
    /// SSE-KMS. Also, specifying this header with a PUT action doesn't affect
    /// bucket-level settings for S3
    /// Bucket Key.
    ///
    /// **Directory buckets** - S3 Bucket Keys are always enabled for `GET` and
    /// `PUT` operations in a directory bucket and can’t be disabled. S3 Bucket Keys
    /// aren't supported, when you copy SSE-KMS encrypted objects from general
    /// purpose buckets
    /// to directory buckets, from directory buckets to general purpose buckets, or
    /// between directory buckets, through
    /// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html), [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html), [the Copy operation in Batch Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-objects-Batch-Ops), or
    /// [the import
    /// jobs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-import-job). In this case, Amazon S3 makes a call to KMS every time a copy request is made for a KMS-encrypted object.
    bucket_key_enabled: ?bool = null,

    /// Can be used to specify caching behavior along the request/reply chain. For
    /// more information, see
    /// [http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9).
    cache_control: ?[]const u8 = null,

    /// Indicates the algorithm used to create the checksum for the object when you
    /// use the SDK. This header will not provide any
    /// additional functionality if you don't use the SDK. When you send this
    /// header, there must be a corresponding `x-amz-checksum-*algorithm*
    /// ` or
    /// `x-amz-trailer` header sent. Otherwise, Amazon S3 fails the request with the
    /// HTTP status code `400 Bad Request`.
    ///
    /// For the `x-amz-checksum-*algorithm*
    /// ` header, replace `
    /// *algorithm*
    /// ` with the supported algorithm from the following list:
    ///
    /// * `CRC32`
    ///
    /// * `CRC32C`
    ///
    /// * `CRC64NVME`
    ///
    /// * `SHA1`
    ///
    /// * `SHA256`
    ///
    /// For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// If the individual checksum value you provide through
    /// `x-amz-checksum-*algorithm*
    /// ` doesn't match the checksum algorithm you set through
    /// `x-amz-sdk-checksum-algorithm`, Amazon S3 fails the request with a
    /// `BadDigest` error.
    ///
    /// The `Content-MD5` or `x-amz-sdk-checksum-algorithm` header is required for
    /// any request to upload an object with a retention period configured using
    /// Amazon S3 Object Lock. For more
    /// information, see [Uploading objects
    /// to an Object Lock enabled bucket
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-managing.html#object-lock-put-object) in the *Amazon S3 User Guide*.
    ///
    /// For directory buckets, when you use Amazon Web Services SDKs, `CRC32` is the
    /// default checksum algorithm that's used for performance.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data that was originally sent.
    /// This header specifies the Base64 encoded, 32-bit `CRC32` checksum of the
    /// object. For more information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the
    /// *Amazon S3 User Guide*.
    checksum_crc32: ?[]const u8 = null,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data that was originally sent.
    /// This header specifies the Base64 encoded, 32-bit `CRC32C` checksum of the
    /// object. For more information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the
    /// *Amazon S3 User Guide*.
    checksum_crc32_c: ?[]const u8 = null,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data
    /// that was originally sent. This header specifies the Base64 encoded, 64-bit
    /// `CRC64NVME`
    /// checksum of the object. The `CRC64NVME` checksum is always a full object
    /// checksum. For more
    /// information, see [Checking object integrity in the Amazon S3
    /// User
    /// Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html).
    checksum_crc64_nvme: ?[]const u8 = null,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data that was originally sent.
    /// This header specifies the Base64 encoded, 160-bit `SHA1` digest of the
    /// object. For more information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the
    /// *Amazon S3 User Guide*.
    checksum_sha1: ?[]const u8 = null,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data that was originally sent.
    /// This header specifies the Base64 encoded, 256-bit `SHA256` digest of the
    /// object. For more information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the
    /// *Amazon S3 User Guide*.
    checksum_sha256: ?[]const u8 = null,

    /// Specifies presentational information for the object. For more information,
    /// see
    /// [https://www.rfc-editor.org/rfc/rfc6266#section-4](https://www.rfc-editor.org/rfc/rfc6266#section-4).
    content_disposition: ?[]const u8 = null,

    /// Specifies what content encodings have been applied to the object and thus
    /// what decoding mechanisms
    /// must be applied to obtain the media-type referenced by the Content-Type
    /// header field. For more
    /// information, see
    /// [https://www.rfc-editor.org/rfc/rfc9110.html#field.content-encoding](https://www.rfc-editor.org/rfc/rfc9110.html#field.content-encoding).
    content_encoding: ?[]const u8 = null,

    /// The language the content is in.
    content_language: ?[]const u8 = null,

    /// Size of the body in bytes. This parameter is useful when the size of the
    /// body cannot be determined
    /// automatically. For more information, see
    /// [https://www.rfc-editor.org/rfc/rfc9110.html#name-content-length](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-length).
    content_length: ?i64 = null,

    /// The Base64 encoded 128-bit `MD5` digest of the message (without the headers)
    /// according to
    /// RFC 1864. This header can be used as a message integrity check to verify
    /// that the data is the same data
    /// that was originally sent. Although it is optional, we recommend using the
    /// Content-MD5 mechanism as an
    /// end-to-end integrity check. For more information about REST request
    /// authentication, see [REST
    /// Authentication](https://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html).
    ///
    /// The `Content-MD5` or `x-amz-sdk-checksum-algorithm` header is required for
    /// any request to upload an object with a retention period configured using
    /// Amazon S3 Object Lock. For more
    /// information, see [Uploading objects
    /// to an Object Lock enabled bucket
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-managing.html#object-lock-put-object) in the *Amazon S3 User Guide*.
    ///
    /// This functionality is not supported for directory buckets.
    content_md5: ?[]const u8 = null,

    /// A standard MIME type describing the format of the contents. For more
    /// information, see
    /// [https://www.rfc-editor.org/rfc/rfc9110.html#name-content-type](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-type).
    content_type: ?[]const u8 = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The date and time at which the object is no longer cacheable. For more
    /// information, see
    /// [https://www.rfc-editor.org/rfc/rfc7234#section-5.3](https://www.rfc-editor.org/rfc/rfc7234#section-5.3).
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

    /// Uploads the object only if the ETag (entity tag) value provided during the
    /// WRITE operation matches
    /// the ETag of the object in S3. If the ETag values do not match, the operation
    /// returns a `412
    /// Precondition Failed` error.
    ///
    /// If a conflicting operation occurs during the upload S3 returns a `409
    /// ConditionalRequestConflict` response. On a 409 failure you should fetch the
    /// object's ETag and
    /// retry the upload.
    ///
    /// Expects the ETag value as a string.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232), or [Conditional
    /// requests](https://docs.aws.amazon.com/AmazonS3/latest/userguide/conditional-requests.html) in the
    /// *Amazon S3 User Guide*.
    if_match: ?[]const u8 = null,

    /// Uploads the object only if the object key name does not already exist in the
    /// bucket specified.
    /// Otherwise, Amazon S3 returns a `412 Precondition Failed` error.
    ///
    /// If a conflicting operation occurs during the upload S3 returns a `409
    /// ConditionalRequestConflict` response. On a 409 failure you should retry the
    /// upload.
    ///
    /// Expects the '*' (asterisk) character.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232), or [Conditional
    /// requests](https://docs.aws.amazon.com/AmazonS3/latest/userguide/conditional-requests.html) in the
    /// *Amazon S3 User Guide*.
    if_none_match: ?[]const u8 = null,

    /// Object key for which the PUT action was initiated.
    key: []const u8,

    /// A map of metadata to store with the object in S3.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether a legal hold will be applied to this object. For more
    /// information about S3 Object
    /// Lock, see [Object
    /// Lock](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_legal_hold_status: ?ObjectLockLegalHoldStatus = null,

    /// The Object Lock mode that you want to apply to this object.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_mode: ?ObjectLockMode = null,

    /// The date and time when you want this object's Object Lock to expire. Must be
    /// formatted as a
    /// timestamp parameter.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_retain_until_date: ?i64 = null,

    request_payer: ?RequestPayer = null,

    /// The server-side encryption algorithm that was used when you store this
    /// object in Amazon S3 or
    /// Amazon FSx.
    ///
    /// * **General purpose buckets ** - You have four mutually exclusive
    /// options to protect data using server-side encryption in Amazon S3, depending
    /// on how you choose to manage
    /// the encryption keys. Specifically, the encryption key options are Amazon S3
    /// managed keys (SSE-S3),
    /// Amazon Web Services KMS keys (SSE-KMS or DSSE-KMS), and customer-provided
    /// keys (SSE-C). Amazon S3 encrypts data with
    /// server-side encryption by using Amazon S3 managed keys (SSE-S3) by default.
    /// You can optionally tell Amazon S3
    /// to encrypt data at rest by using server-side encryption with other key
    /// options. For more
    /// information, see [Using Server-Side
    /// Encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingServerSideEncryption.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// * **Directory buckets ** -
    /// For directory buckets, there are only two supported options for server-side
    /// encryption: server-side encryption with Amazon S3 managed keys (SSE-S3)
    /// (`AES256`) and server-side encryption with KMS keys (SSE-KMS) (`aws:kms`).
    /// We recommend that the bucket's default encryption uses the desired
    /// encryption configuration and you don't override the bucket default
    /// encryption in your
    /// `CreateSession` requests or `PUT` object requests. Then, new objects
    /// are automatically encrypted with the desired encryption settings. For more
    /// information, see [Protecting data with server-side
    /// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-serv-side-encryption.html) in the *Amazon S3 User Guide*. For more information about the encryption overriding behaviors in directory buckets, see [Specifying server-side encryption with KMS for new object uploads](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-specifying-kms-encryption.html).
    ///
    /// In the Zonal endpoint API calls (except
    /// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html) and [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html)) using the REST API, the encryption request headers must match the encryption settings that are specified in the `CreateSession` request.
    /// You can't override the values of the encryption settings
    /// (`x-amz-server-side-encryption`,
    /// `x-amz-server-side-encryption-aws-kms-key-id`,
    /// `x-amz-server-side-encryption-context`, and
    /// `x-amz-server-side-encryption-bucket-key-enabled`) that are specified in the
    /// `CreateSession` request.
    /// You don't need to explicitly specify these encryption settings values in
    /// Zonal endpoint API calls, and
    /// Amazon S3 will use the encryption settings values from the `CreateSession`
    /// request to protect new objects in the directory bucket.
    ///
    /// When you use the CLI or the Amazon Web Services SDKs, for `CreateSession`,
    /// the session token refreshes automatically to avoid service interruptions
    /// when a session expires. The CLI or the Amazon Web Services SDKs use the
    /// bucket's default encryption configuration for the
    /// `CreateSession` request. It's not supported to override the encryption
    /// settings values in the `CreateSession` request.
    /// So in the Zonal endpoint API calls (except
    /// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html) and [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html)),
    /// the encryption request headers must match the default encryption
    /// configuration of the directory bucket.
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
    /// This functionality is not supported for directory buckets.
    sse_customer_algorithm: ?[]const u8 = null,

    /// Specifies the customer-provided encryption key for Amazon S3 to use in
    /// encrypting data. This value is
    /// used to store the object and then it is discarded; Amazon S3 does not store
    /// the encryption key. The key must
    /// be appropriate for use with the algorithm specified in the
    /// `x-amz-server-side-encryption-customer-algorithm` header.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key: ?[]const u8 = null,

    /// Specifies the 128-bit MD5 digest of the encryption key according to RFC
    /// 1321. Amazon S3 uses this header
    /// for a message integrity check to ensure that the encryption key was
    /// transmitted without error.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key_md5: ?[]const u8 = null,

    /// Specifies the Amazon Web Services KMS Encryption Context as an additional
    /// encryption context to use for object encryption. The value of
    /// this header is a Base64 encoded string of a UTF-8 encoded JSON, which
    /// contains the encryption context as key-value pairs.
    /// This value is stored as object metadata and automatically gets passed on
    /// to Amazon Web Services KMS for future `GetObject` operations on
    /// this object.
    ///
    /// **General purpose buckets** - This value must be explicitly added during
    /// `CopyObject` operations if you want an additional encryption context for
    /// your object. For more information, see [Encryption
    /// context](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html#encryption-context) in the *Amazon S3 User Guide*.
    ///
    /// **Directory buckets** - You can optionally provide an explicit encryption
    /// context value. The value must match the default encryption context - the
    /// bucket Amazon Resource Name (ARN). An additional encryption context value is
    /// not supported.
    ssekms_encryption_context: ?[]const u8 = null,

    /// Specifies the KMS key ID (Key ID, Key ARN, or Key Alias) to use for object
    /// encryption. If the KMS key doesn't exist in the same
    /// account that's issuing the command, you must use the full Key ARN not the
    /// Key ID.
    ///
    /// **General purpose buckets** - If you specify `x-amz-server-side-encryption`
    /// with `aws:kms` or `aws:kms:dsse`, this header specifies the ID (Key ID, Key
    /// ARN, or Key Alias) of the KMS
    /// key to use. If you specify
    /// `x-amz-server-side-encryption:aws:kms` or
    /// `x-amz-server-side-encryption:aws:kms:dsse`, but do not provide
    /// `x-amz-server-side-encryption-aws-kms-key-id`, Amazon S3 uses the Amazon Web
    /// Services managed key
    /// (`aws/s3`) to protect the data.
    ///
    /// **Directory buckets** - To encrypt data using SSE-KMS, it's recommended to
    /// specify the
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

    /// By default, Amazon S3 uses the STANDARD Storage Class to store newly created
    /// objects. The STANDARD
    /// storage class provides high durability and high availability. Depending on
    /// performance needs, you can
    /// specify a different Storage Class. For more information, see [Storage
    /// Classes](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// * Directory buckets only support `EXPRESS_ONEZONE` (the S3 Express One Zone
    ///   storage class) in
    /// Availability Zones and `ONEZONE_IA` (the S3 One Zone-Infrequent Access
    /// storage class) in
    /// Dedicated Local Zones.
    ///
    /// * Amazon S3 on Outposts only uses the OUTPOSTS Storage Class.
    storage_class: ?StorageClass = null,

    /// The tag-set for the object. The tag-set must be encoded as URL Query
    /// parameters. (For example,
    /// "Key1=Value1")
    ///
    /// This functionality is not supported for directory buckets.
    tagging: ?[]const u8 = null,

    /// If the bucket is configured as a website, redirects requests for this object
    /// to another object in
    /// the same bucket or to an external URL. Amazon S3 stores the value of this
    /// header in the object metadata. For
    /// information about object metadata, see [Object Key and
    /// Metadata](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingMetadata.html) in the *Amazon S3
    /// User Guide*.
    ///
    /// In the following example, the request header sets the redirect to an object
    /// (anotherPage.html) in
    /// the same bucket:
    ///
    /// `x-amz-website-redirect-location: /anotherPage.html`
    ///
    /// In the following example, the request header sets the object redirect to
    /// another website:
    ///
    /// `x-amz-website-redirect-location: http://www.example.com/`
    ///
    /// For more information about website hosting in Amazon S3, see [Hosting
    /// Websites on Amazon
    /// S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) and
    /// [How to Configure Website Page
    /// Redirects](https://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html) in the *Amazon S3 User Guide*.
    ///
    /// This functionality is not supported for directory buckets.
    website_redirect_location: ?[]const u8 = null,

    /// Specifies the offset for appending data to existing objects in bytes. The
    /// offset must be equal to
    /// the size of the existing object being appended to. If no object exists,
    /// setting this header to 0 will
    /// create a new object.
    ///
    /// This functionality is only supported for objects in the Amazon S3 Express
    /// One Zone storage class in
    /// directory buckets.
    write_offset_bytes: ?i64 = null,
};

pub const PutObjectOutput = struct {
    /// Indicates whether the uploaded object uses an S3 Bucket Key for server-side
    /// encryption with
    /// Key Management Service (KMS) keys (SSE-KMS).
    bucket_key_enabled: ?bool = null,

    /// The Base64 encoded, 32-bit `CRC32 checksum` of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use an API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_crc32: ?[]const u8 = null,

    /// The Base64 encoded, 32-bit `CRC32C` checksum of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use an API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_crc32_c: ?[]const u8 = null,

    /// The Base64 encoded, 64-bit `CRC64NVME` checksum of the object. This header
    /// is present if
    /// the object was uploaded with the `CRC64NVME` checksum algorithm, or if it
    /// was uploaded
    /// without a checksum (and Amazon S3 added the default checksum, `CRC64NVME`,
    /// to the uploaded
    /// object). For more information about how checksums are calculated with
    /// multipart uploads, see [Checking object
    /// integrity in the Amazon S3 User
    /// Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html).
    checksum_crc64_nvme: ?[]const u8 = null,

    /// The Base64 encoded, 160-bit `SHA1` digest of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use the API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_sha1: ?[]const u8 = null,

    /// The Base64 encoded, 256-bit `SHA256` digest of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use an API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_sha256: ?[]const u8 = null,

    /// This header specifies the checksum type of the object, which determines how
    /// part-level checksums are
    /// combined to create an object-level checksum for multipart objects. For
    /// `PutObject` uploads,
    /// the checksum type is always `FULL_OBJECT`. You can use this header as a data
    /// integrity check
    /// to verify that the checksum type that is received is the same checksum that
    /// was specified. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_type: ?ChecksumType = null,

    /// Entity tag for the uploaded object.
    ///
    /// **General purpose buckets ** - To ensure that data is not corrupted
    /// traversing the network, for objects where the ETag is the MD5 digest of the
    /// object, you can calculate
    /// the MD5 while putting an object to Amazon S3 and compare the returned ETag
    /// to the calculated MD5
    /// value.
    ///
    /// **Directory buckets ** - The ETag for the object in a
    /// directory bucket isn't the MD5 digest of the object.
    e_tag: ?[]const u8 = null,

    /// If the expiration is configured for the object (see
    /// [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html)) in the *Amazon S3 User Guide*, the response
    /// includes this header. It includes the `expiry-date` and `rule-id` key-value
    /// pairs
    /// that provide information about object expiration. The value of the `rule-id`
    /// is
    /// URL-encoded.
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

    /// The size of the object in bytes. This value is only be present if you append
    /// to an object.
    ///
    /// This functionality is only supported for objects in the Amazon S3 Express
    /// One Zone storage class in
    /// directory buckets.
    size: ?i64 = null,

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
    /// this header is a Base64 encoded string of a UTF-8 encoded JSON, which
    /// contains the encryption context as key-value pairs.
    /// This value is stored as object metadata and automatically gets
    /// passed on to Amazon Web Services KMS for future `GetObject`
    /// operations on this object.
    ssekms_encryption_context: ?[]const u8 = null,

    /// If present, indicates the ID of the KMS key that was used for object
    /// encryption.
    ssekms_key_id: ?[]const u8 = null,

    /// Version ID of the object.
    ///
    /// If you enable versioning for a bucket, Amazon S3 automatically generates a
    /// unique version ID for the
    /// object being stored. Amazon S3 returns this ID in the response. When you
    /// enable versioning for a bucket, if
    /// Amazon S3 receives multiple write requests for the same object
    /// simultaneously, it stores all of the objects.
    /// For more information about versioning, see [Adding Objects to
    /// Versioning-Enabled
    /// Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/AddingObjectstoVersioningEnabledBuckets.html) in the *Amazon S3 User Guide*. For information about
    /// returning the versioning state of a bucket, see
    /// [GetBucketVersioning](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketVersioning.html).
    ///
    /// This functionality is not supported for directory buckets.
    version_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *PutObjectOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: PutObjectInput, options: Options) !PutObjectOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

pub const PresignOptions = struct {
    expires_seconds: u64 = 3600,
};

pub fn presign(client: *Client, input: PutObjectInput, options: PresignOptions) ![]const u8 {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);

    return aws.signing.presignRequest(
        client.allocator,
        &request,
        creds,
        client.config.region,
        "s3",
        .{ .expires_seconds = options.expires_seconds },
    );
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("s3", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.bucket);
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.key);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(alloc, "x-id=PutObject");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body = input.body orelse "";

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.acl) |v| {
        try request.headers.put(alloc, "x-amz-acl", @tagName(v));
    }
    if (input.bucket_key_enabled) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-bucket-key-enabled", if (v) "true" else "false");
    }
    if (input.cache_control) |v| {
        try request.headers.put(alloc, "Cache-Control", v);
    }
    if (input.checksum_algorithm) |v| {
        try request.headers.put(alloc, "x-amz-sdk-checksum-algorithm", @tagName(v));
    }
    if (input.checksum_crc32) |v| {
        try request.headers.put(alloc, "x-amz-checksum-crc32", v);
    }
    if (input.checksum_crc32_c) |v| {
        try request.headers.put(alloc, "x-amz-checksum-crc32c", v);
    }
    if (input.checksum_crc64_nvme) |v| {
        try request.headers.put(alloc, "x-amz-checksum-crc64nvme", v);
    }
    if (input.checksum_sha1) |v| {
        try request.headers.put(alloc, "x-amz-checksum-sha1", v);
    }
    if (input.checksum_sha256) |v| {
        try request.headers.put(alloc, "x-amz-checksum-sha256", v);
    }
    if (input.content_disposition) |v| {
        try request.headers.put(alloc, "Content-Disposition", v);
    }
    if (input.content_encoding) |v| {
        try request.headers.put(alloc, "Content-Encoding", v);
    }
    if (input.content_language) |v| {
        try request.headers.put(alloc, "Content-Language", v);
    }
    if (input.content_length) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "Content-Length", num_str);
        }
    }
    if (input.content_md5) |v| {
        try request.headers.put(alloc, "Content-MD5", v);
    }
    if (input.content_type) |v| {
        try request.headers.put(alloc, "Content-Type", v);
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }
    if (input.expires) |v| {
        try request.headers.put(alloc, "Expires", v);
    }
    if (input.grant_full_control) |v| {
        try request.headers.put(alloc, "x-amz-grant-full-control", v);
    }
    if (input.grant_read) |v| {
        try request.headers.put(alloc, "x-amz-grant-read", v);
    }
    if (input.grant_read_acp) |v| {
        try request.headers.put(alloc, "x-amz-grant-read-acp", v);
    }
    if (input.grant_write_acp) |v| {
        try request.headers.put(alloc, "x-amz-grant-write-acp", v);
    }
    if (input.if_match) |v| {
        try request.headers.put(alloc, "If-Match", v);
    }
    if (input.if_none_match) |v| {
        try request.headers.put(alloc, "If-None-Match", v);
    }
    if (input.object_lock_legal_hold_status) |v| {
        try request.headers.put(alloc, "x-amz-object-lock-legal-hold", @tagName(v));
    }
    if (input.object_lock_mode) |v| {
        try request.headers.put(alloc, "x-amz-object-lock-mode", @tagName(v));
    }
    if (input.object_lock_retain_until_date) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-object-lock-retain-until-date", num_str);
        }
    }
    if (input.request_payer) |v| {
        try request.headers.put(alloc, "x-amz-request-payer", @tagName(v));
    }
    if (input.server_side_encryption) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption", @tagName(v));
    }
    if (input.sse_customer_algorithm) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-customer-algorithm", v);
    }
    if (input.sse_customer_key) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-customer-key", v);
    }
    if (input.sse_customer_key_md5) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-customer-key-MD5", v);
    }
    if (input.ssekms_encryption_context) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-context", v);
    }
    if (input.ssekms_key_id) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-aws-kms-key-id", v);
    }
    if (input.storage_class) |v| {
        try request.headers.put(alloc, "x-amz-storage-class", @tagName(v));
    }
    if (input.tagging) |v| {
        try request.headers.put(alloc, "x-amz-tagging", v);
    }
    if (input.website_redirect_location) |v| {
        try request.headers.put(alloc, "x-amz-website-redirect-location", v);
    }
    if (input.write_offset_bytes) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-write-offset-bytes", num_str);
        }
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutObjectOutput {
    var result: PutObjectOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("x-amz-server-side-encryption-bucket-key-enabled")) |value| {
        result.bucket_key_enabled = std.mem.eql(u8, value, "true");
    }
    if (headers.get("x-amz-checksum-crc32")) |value| {
        result.checksum_crc32 = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-crc32c")) |value| {
        result.checksum_crc32_c = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-crc64nvme")) |value| {
        result.checksum_crc64_nvme = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-sha1")) |value| {
        result.checksum_sha1 = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-sha256")) |value| {
        result.checksum_sha256 = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-type")) |value| {
        result.checksum_type = std.meta.stringToEnum(ChecksumType, value);
    }
    if (headers.get("etag")) |value| {
        result.e_tag = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-expiration")) |value| {
        result.expiration = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = std.meta.stringToEnum(RequestCharged, value);
    }
    if (headers.get("x-amz-server-side-encryption")) |value| {
        result.server_side_encryption = std.meta.stringToEnum(ServerSideEncryption, value);
    }
    if (headers.get("x-amz-object-size")) |value| {
        result.size = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (headers.get("x-amz-server-side-encryption-customer-algorithm")) |value| {
        result.sse_customer_algorithm = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-customer-key-md5")) |value| {
        result.sse_customer_key_md5 = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-context")) |value| {
        result.ssekms_encryption_context = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-aws-kms-key-id")) |value| {
        result.ssekms_key_id = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-version-id")) |value| {
        result.version_id = try alloc.dupe(u8, value);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";

    if (std.mem.eql(u8, error_code, "AccessDenied")) {
        return .{ .access_denied = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .bucket_already_exists = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .bucket_already_owned_by_you = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionTypeMismatch")) {
        return .{ .encryption_type_mismatch = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatch")) {
        return .{ .idempotency_parameter_mismatch = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidObjectState")) {
        return .{ .invalid_object_state = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        return .{ .invalid_request = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWriteOffset")) {
        return .{ .invalid_write_offset = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucket")) {
        return .{ .no_such_bucket = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKey")) {
        return .{ .no_such_key = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchUpload")) {
        return .{ .no_such_upload = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NotFound")) {
        return .{ .not_found = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ObjectAlreadyInActiveTierError")) {
        return .{ .object_already_in_active_tier_error = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotInActiveTierError")) {
        return .{ .object_not_in_active_tier_error = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyParts")) {
        return .{ .too_many_parts = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
