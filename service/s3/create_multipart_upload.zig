const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ObjectCannedACL = @import("object_canned_acl.zig").ObjectCannedACL;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const ObjectLockLegalHoldStatus = @import("object_lock_legal_hold_status.zig").ObjectLockLegalHoldStatus;
const ObjectLockMode = @import("object_lock_mode.zig").ObjectLockMode;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const StorageClass = @import("storage_class.zig").StorageClass;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const serde = @import("serde.zig");

pub const CreateMultipartUploadInput = struct {
    /// The canned ACL to apply to the object. Amazon S3 supports a set of
    /// predefined ACLs, known as
    /// *canned ACLs*. Each canned ACL has a predefined set of grantees and
    /// permissions.
    /// For more information, see [Canned
    /// ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL) in the
    /// *Amazon S3 User Guide*.
    ///
    /// By default, all objects are private. Only the owner has full access control.
    /// When uploading an
    /// object, you can grant access permissions to individual Amazon Web Services
    /// accounts or to predefined groups defined by
    /// Amazon S3. These permissions are then added to the access control list (ACL)
    /// on the new object. For more
    /// information, see [Using
    /// ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html). One way to grant the permissions using the request headers is to specify a canned ACL
    /// with the `x-amz-acl` request header.
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    acl: ?ObjectCannedACL = null,

    /// The name of the bucket where the multipart upload is initiated and where the
    /// object is
    /// uploaded.
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

    /// Specifies caching behavior along the request/reply chain.
    cache_control: ?[]const u8 = null,

    /// Indicates the algorithm that you want Amazon S3 to use to create the
    /// checksum for the object. For more information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// Indicates the checksum type that you want Amazon S3 to use to calculate the
    /// object’s checksum value. For
    /// more information, see [Checking object integrity in the Amazon S3
    /// User
    /// Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html).
    checksum_type: ?ChecksumType = null,

    /// Specifies presentational information for the object.
    content_disposition: ?[]const u8 = null,

    /// Specifies what content encodings have been applied to the object and thus
    /// what decoding mechanisms
    /// must be applied to obtain the media-type referenced by the Content-Type
    /// header field.
    ///
    /// For directory buckets, only the `aws-chunked` value is supported in this
    /// header field.
    content_encoding: ?[]const u8 = null,

    /// The language that the content is in.
    content_language: ?[]const u8 = null,

    /// A standard MIME type describing the format of the object data.
    content_type: ?[]const u8 = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The date and time at which the object is no longer cacheable.
    expires: ?[]const u8 = null,

    /// Specify access permissions explicitly to give the grantee READ, READ_ACP,
    /// and WRITE_ACP permissions
    /// on the object.
    ///
    /// By default, all objects are private. Only the owner has full access control.
    /// When uploading an
    /// object, you can use this header to explicitly grant access permissions to
    /// specific Amazon Web Services accounts or
    /// groups. This header maps to specific permissions that Amazon S3 supports in
    /// an ACL. For more information, see
    /// [Access Control List (ACL)
    /// Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html)
    /// in the *Amazon S3 User Guide*.
    ///
    /// You specify each grantee as a type=value pair, where the type is one of the
    /// following:
    ///
    /// * `id` – if the value specified is the canonical user ID of an Amazon Web
    ///   Services account
    ///
    /// * `uri` – if you are granting permissions to a predefined group
    ///
    /// * `emailAddress` – if the value specified is the email address of an
    /// Amazon Web Services account
    ///
    /// Using email addresses to specify a grantee is only supported in the
    /// following Amazon Web Services Regions:
    ///
    /// * US East (N. Virginia)
    ///
    /// * US West (N. California)
    ///
    /// * US West (Oregon)
    ///
    /// * Asia Pacific (Singapore)
    ///
    /// * Asia Pacific (Sydney)
    ///
    /// * Asia Pacific (Tokyo)
    ///
    /// * Europe (Ireland)
    ///
    /// * South America (São Paulo)
    ///
    /// For a list of all the Amazon S3 supported Regions and endpoints, see
    /// [Regions and
    /// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) in the Amazon Web Services General Reference.
    ///
    /// For example, the following `x-amz-grant-read` header grants the Amazon Web
    /// Services accounts identified by account IDs permissions to read object data
    /// and its metadata:
    ///
    /// `x-amz-grant-read: id="11112222333", id="444455556666" `
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    grant_full_control: ?[]const u8 = null,

    /// Specify access permissions explicitly to allow grantee to read the object
    /// data and its
    /// metadata.
    ///
    /// By default, all objects are private. Only the owner has full access control.
    /// When uploading an
    /// object, you can use this header to explicitly grant access permissions to
    /// specific Amazon Web Services accounts or
    /// groups. This header maps to specific permissions that Amazon S3 supports in
    /// an ACL. For more information, see
    /// [Access Control List (ACL)
    /// Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html)
    /// in the *Amazon S3 User Guide*.
    ///
    /// You specify each grantee as a type=value pair, where the type is one of the
    /// following:
    ///
    /// * `id` – if the value specified is the canonical user ID of an Amazon Web
    ///   Services account
    ///
    /// * `uri` – if you are granting permissions to a predefined group
    ///
    /// * `emailAddress` – if the value specified is the email address of an
    /// Amazon Web Services account
    ///
    /// Using email addresses to specify a grantee is only supported in the
    /// following Amazon Web Services Regions:
    ///
    /// * US East (N. Virginia)
    ///
    /// * US West (N. California)
    ///
    /// * US West (Oregon)
    ///
    /// * Asia Pacific (Singapore)
    ///
    /// * Asia Pacific (Sydney)
    ///
    /// * Asia Pacific (Tokyo)
    ///
    /// * Europe (Ireland)
    ///
    /// * South America (São Paulo)
    ///
    /// For a list of all the Amazon S3 supported Regions and endpoints, see
    /// [Regions and
    /// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) in the Amazon Web Services General Reference.
    ///
    /// For example, the following `x-amz-grant-read` header grants the Amazon Web
    /// Services accounts identified by account IDs permissions to read object data
    /// and its metadata:
    ///
    /// `x-amz-grant-read: id="11112222333", id="444455556666" `
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    grant_read: ?[]const u8 = null,

    /// Specify access permissions explicitly to allows grantee to read the object
    /// ACL.
    ///
    /// By default, all objects are private. Only the owner has full access control.
    /// When uploading an
    /// object, you can use this header to explicitly grant access permissions to
    /// specific Amazon Web Services accounts or
    /// groups. This header maps to specific permissions that Amazon S3 supports in
    /// an ACL. For more information, see
    /// [Access Control List (ACL)
    /// Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html)
    /// in the *Amazon S3 User Guide*.
    ///
    /// You specify each grantee as a type=value pair, where the type is one of the
    /// following:
    ///
    /// * `id` – if the value specified is the canonical user ID of an Amazon Web
    ///   Services account
    ///
    /// * `uri` – if you are granting permissions to a predefined group
    ///
    /// * `emailAddress` – if the value specified is the email address of an
    /// Amazon Web Services account
    ///
    /// Using email addresses to specify a grantee is only supported in the
    /// following Amazon Web Services Regions:
    ///
    /// * US East (N. Virginia)
    ///
    /// * US West (N. California)
    ///
    /// * US West (Oregon)
    ///
    /// * Asia Pacific (Singapore)
    ///
    /// * Asia Pacific (Sydney)
    ///
    /// * Asia Pacific (Tokyo)
    ///
    /// * Europe (Ireland)
    ///
    /// * South America (São Paulo)
    ///
    /// For a list of all the Amazon S3 supported Regions and endpoints, see
    /// [Regions and
    /// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) in the Amazon Web Services General Reference.
    ///
    /// For example, the following `x-amz-grant-read` header grants the Amazon Web
    /// Services accounts identified by account IDs permissions to read object data
    /// and its metadata:
    ///
    /// `x-amz-grant-read: id="11112222333", id="444455556666" `
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    grant_read_acp: ?[]const u8 = null,

    /// Specify access permissions explicitly to allows grantee to allow grantee to
    /// write the ACL for the
    /// applicable object.
    ///
    /// By default, all objects are private. Only the owner has full access control.
    /// When uploading an
    /// object, you can use this header to explicitly grant access permissions to
    /// specific Amazon Web Services accounts or
    /// groups. This header maps to specific permissions that Amazon S3 supports in
    /// an ACL. For more information, see
    /// [Access Control List (ACL)
    /// Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html)
    /// in the *Amazon S3 User Guide*.
    ///
    /// You specify each grantee as a type=value pair, where the type is one of the
    /// following:
    ///
    /// * `id` – if the value specified is the canonical user ID of an Amazon Web
    ///   Services account
    ///
    /// * `uri` – if you are granting permissions to a predefined group
    ///
    /// * `emailAddress` – if the value specified is the email address of an
    /// Amazon Web Services account
    ///
    /// Using email addresses to specify a grantee is only supported in the
    /// following Amazon Web Services Regions:
    ///
    /// * US East (N. Virginia)
    ///
    /// * US West (N. California)
    ///
    /// * US West (Oregon)
    ///
    /// * Asia Pacific (Singapore)
    ///
    /// * Asia Pacific (Sydney)
    ///
    /// * Asia Pacific (Tokyo)
    ///
    /// * Europe (Ireland)
    ///
    /// * South America (São Paulo)
    ///
    /// For a list of all the Amazon S3 supported Regions and endpoints, see
    /// [Regions and
    /// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) in the Amazon Web Services General Reference.
    ///
    /// For example, the following `x-amz-grant-read` header grants the Amazon Web
    /// Services accounts identified by account IDs permissions to read object data
    /// and its metadata:
    ///
    /// `x-amz-grant-read: id="11112222333", id="444455556666" `
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    grant_write_acp: ?[]const u8 = null,

    /// Object key for which the multipart upload is to be initiated.
    key: []const u8,

    /// A map of metadata to store with the object in S3.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether you want to apply a legal hold to the uploaded object.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_legal_hold_status: ?ObjectLockLegalHoldStatus = null,

    /// Specifies the Object Lock mode that you want to apply to the uploaded
    /// object.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_mode: ?ObjectLockMode = null,

    /// Specifies the date and time when you want the Object Lock to expire.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_retain_until_date: ?i64 = null,

    request_payer: ?RequestPayer = null,

    /// The server-side encryption algorithm used when you store this object in
    /// Amazon S3 or Amazon FSx.
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
    /// AES256).
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

    /// Specifies the 128-bit MD5 digest of the customer-provided encryption key
    /// according to RFC 1321. Amazon S3
    /// uses this header for a message integrity check to ensure that the encryption
    /// key was transmitted without
    /// error.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key_md5: ?[]const u8 = null,

    /// Specifies the Amazon Web Services KMS Encryption Context to use for object
    /// encryption. The value of
    /// this header is a Base64 encoded string of a UTF-8 encoded JSON, which
    /// contains the encryption context as key-value pairs.
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
    /// parameters.
    ///
    /// This functionality is not supported for directory buckets.
    tagging: ?[]const u8 = null,

    /// If the bucket is configured as a website, redirects requests for this object
    /// to another object in
    /// the same bucket or to an external URL. Amazon S3 stores the value of this
    /// header in the object
    /// metadata.
    ///
    /// This functionality is not supported for directory buckets.
    website_redirect_location: ?[]const u8 = null,
};

pub const CreateMultipartUploadOutput = struct {
    /// If the bucket has a lifecycle rule configured with an action to abort
    /// incomplete multipart uploads
    /// and the prefix in the lifecycle rule matches the object name in the request,
    /// the response includes this
    /// header. The header indicates when the initiated multipart upload becomes
    /// eligible for an abort
    /// operation. For more information, see [ Aborting
    /// Incomplete Multipart Uploads Using a Bucket Lifecycle
    /// Configuration](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config) in the
    /// *Amazon S3 User Guide*.
    ///
    /// The response also includes the `x-amz-abort-rule-id` header that provides
    /// the ID of the
    /// lifecycle configuration rule that defines the abort action.
    ///
    /// This functionality is not supported for directory buckets.
    abort_date: ?i64 = null,

    /// This header is returned along with the `x-amz-abort-date` header. It
    /// identifies the
    /// applicable lifecycle configuration rule that defines the action to abort
    /// incomplete multipart
    /// uploads.
    ///
    /// This functionality is not supported for directory buckets.
    abort_rule_id: ?[]const u8 = null,

    /// The name of the bucket to which the multipart upload was initiated. Does not
    /// return the access point ARN or
    /// access point alias if used.
    ///
    /// Access points are not supported by directory buckets.
    bucket: ?[]const u8 = null,

    /// Indicates whether the multipart upload uses an S3 Bucket Key for server-side
    /// encryption with
    /// Key Management Service (KMS) keys (SSE-KMS).
    bucket_key_enabled: ?bool = null,

    /// The algorithm that was used to create a checksum of the object.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// Indicates the checksum type that you want Amazon S3 to use to calculate the
    /// object’s checksum
    /// value. For more information, see [Checking object integrity in the Amazon S3
    /// User
    /// Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html).
    checksum_type: ?ChecksumType = null,

    /// Object key for which the multipart upload was initiated.
    key: ?[]const u8 = null,

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
    /// this header is a Base64 encoded string of a UTF-8 encoded JSON, which
    /// contains the encryption context as key-value pairs.
    ssekms_encryption_context: ?[]const u8 = null,

    /// If present, indicates the ID of the KMS key that was used for object
    /// encryption.
    ssekms_key_id: ?[]const u8 = null,

    /// ID for the initiated multipart upload.
    upload_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMultipartUploadInput, options: CallOptions) !CreateMultipartUploadOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMultipartUploadInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(allocator, "uploads");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(allocator, "<CreateMultipartUploadRequest>");
    if (input.metadata) |v| {
        try body_buf.appendSlice(allocator, "<Metadata>");
        try serde.serializeMetadata(allocator, &body_buf, v, "entry");
        try body_buf.appendSlice(allocator, "</Metadata>");
    }
    try body_buf.appendSlice(allocator, "</CreateMultipartUploadRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
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
    if (input.checksum_type) |v| {
        try request.headers.put(allocator, "x-amz-checksum-type", @tagName(v));
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
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
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
    if (input.website_redirect_location) |v| {
        try request.headers.put(allocator, "x-amz-website-redirect-location", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMultipartUploadOutput {
    var result: CreateMultipartUploadOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadId")) {
                    result.upload_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("x-amz-abort-date")) |value| {
        result.abort_date = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (headers.get("x-amz-abort-rule-id")) |value| {
        result.abort_rule_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-bucket-key-enabled")) |value| {
        result.bucket_key_enabled = std.mem.eql(u8, value, "true");
    }
    if (headers.get("x-amz-checksum-algorithm")) |value| {
        result.checksum_algorithm = std.meta.stringToEnum(ChecksumAlgorithm, value);
    }
    if (headers.get("x-amz-checksum-type")) |value| {
        result.checksum_type = std.meta.stringToEnum(ChecksumType, value);
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
