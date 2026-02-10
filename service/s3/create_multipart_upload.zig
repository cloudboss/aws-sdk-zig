const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

/// **Important:**
///
/// End of support notice: As of October 1, 2025, Amazon S3 has discontinued
/// support for Email Grantee Access Control Lists (ACLs). If you attempt to use
/// an Email Grantee ACL in a request after October 1, 2025,
/// the request will receive an `HTTP 405` (Method Not Allowed) error.
///
/// This change affects the following Amazon Web Services Regions: US East (N.
/// Virginia), US West (N. California), US West (Oregon), Asia Pacific
/// (Singapore), Asia Pacific (Sydney), Asia Pacific (Tokyo), Europe (Ireland),
/// and South America (São Paulo).
///
/// This action initiates a multipart upload and returns an upload ID. This
/// upload ID is used to
/// associate all of the parts in the specific multipart upload. You specify
/// this upload ID in each of your
/// subsequent upload part requests (see
/// [UploadPart](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html)). You also include this upload ID in
/// the final request to either complete or abort the multipart upload request.
/// For more information about
/// multipart uploads, see [Multipart
/// Upload
/// Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html)
/// in the *Amazon S3 User Guide*.
///
/// **Note:**
///
/// After you initiate a multipart upload and upload one or more parts, to stop
/// being charged for
/// storing the uploaded parts, you must either complete or abort the multipart
/// upload. Amazon S3 frees up the
/// space used to store the parts and stops charging you for storing them only
/// after you either complete
/// or abort a multipart upload.
///
/// If you have configured a lifecycle rule to abort incomplete multipart
/// uploads, the created multipart
/// upload must be completed within the number of days specified in the bucket
/// lifecycle configuration.
/// Otherwise, the incomplete multipart upload becomes eligible for an abort
/// action and Amazon S3 aborts the
/// multipart upload. For more information, see [Aborting
/// Incomplete Multipart Uploads Using a Bucket Lifecycle
/// Configuration](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config).
///
/// **Note:**
///
/// * **Directory buckets ** -
/// S3 Lifecycle is not supported by directory buckets.
///
/// * **Directory buckets ** - For directory buckets, you must make requests for
///   this API operation to the Zonal endpoint. These endpoints support
///   virtual-hosted-style requests in the format
///   `https://*amzn-s3-demo-bucket*.s3express-*zone-id*.*region-code*.amazonaws.com/*key-name*
/// `. Path-style requests are not supported. For more information about
/// endpoints in Availability Zones, see [Regional and Zonal endpoints for
/// directory buckets in Availability
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/endpoint-directory-buckets-AZ.html) in the
/// *Amazon S3 User Guide*. For more information about endpoints in Local Zones,
/// see [Concepts for directory buckets in Local
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-lzs-for-directory-buckets.html) in the
/// *Amazon S3 User Guide*.
///
/// **Request signing**
///
/// For request signing, multipart upload is just a series of regular requests.
/// You initiate a
/// multipart upload, send one or more requests to upload parts, and then
/// complete the multipart
/// upload process. You sign each request individually. There is nothing special
/// about signing
/// multipart upload requests. For more information about signing, see
/// [Authenticating Requests (Amazon Web Services
/// Signature Version
/// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) in the *Amazon S3 User Guide*.
///
/// **Permissions**
///
/// * **General purpose bucket permissions** - To perform a
/// multipart upload with encryption using an Key Management Service (KMS) KMS
/// key, the requester must have
/// permission to the `kms:Decrypt` and `kms:GenerateDataKey` actions on the
/// key. The requester must also have permissions for the `kms:GenerateDataKey`
/// action
/// for the `CreateMultipartUpload` API. Then, the requester needs permissions
/// for the
/// `kms:Decrypt` action on the `UploadPart` and
/// `UploadPartCopy` APIs. These permissions are required because Amazon S3 must
/// decrypt
/// and read data from the encrypted file parts before it completes the
/// multipart upload. For more
/// information, see [Multipart upload API and
/// permissions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html#mpuAndPermissions) and [Protecting data using server-side
/// encryption with Amazon Web Services
/// KMS](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html) in the *Amazon S3 User Guide*.
///
/// * **Directory bucket permissions** - To grant access to this API operation
///   on a directory bucket, we recommend that you use the [
/// `CreateSession`
/// ](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateSession.html)
/// API operation for session-based authorization. Specifically, you grant the
/// `s3express:CreateSession` permission to the directory bucket in a bucket
/// policy or an IAM identity-based policy. Then, you make the `CreateSession`
/// API call on the bucket to obtain a session token. With the session token in
/// your request header, you can make API requests to this operation. After the
/// session token expires, you make another `CreateSession` API call to generate
/// a new session token for use.
/// Amazon Web Services CLI or SDKs create session and refresh the session token
/// automatically to avoid service interruptions when a session expires. For
/// more information about authorization, see [
/// `CreateSession`
/// ](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateSession.html).
///
/// **Encryption**
///
/// * **General purpose buckets** - Server-side encryption is for
/// data encryption at rest. Amazon S3 encrypts your data as it writes it to
/// disks in its data centers
/// and decrypts it when you access it. Amazon S3 automatically encrypts all new
/// objects that are
/// uploaded to an S3 bucket. When doing a multipart upload, if you don't
/// specify encryption
/// information in your request, the encryption setting of the uploaded parts is
/// set to the
/// default encryption configuration of the destination bucket. By default, all
/// buckets have a
/// base level of encryption configuration that uses server-side encryption with
/// Amazon S3 managed keys
/// (SSE-S3). If the destination bucket has a default encryption configuration
/// that uses
/// server-side encryption with an Key Management Service (KMS) key (SSE-KMS),
/// or a customer-provided
/// encryption key (SSE-C), Amazon S3 uses the corresponding KMS key, or a
/// customer-provided key to
/// encrypt the uploaded parts. When you perform a CreateMultipartUpload
/// operation, if you want to
/// use a different type of encryption setting for the uploaded parts, you can
/// request that Amazon S3
/// encrypts the object with a different encryption key (such as an Amazon S3
/// managed key, a KMS key,
/// or a customer-provided key). When the encryption setting in your request is
/// different from the
/// default encryption configuration of the destination bucket, the encryption
/// setting in your
/// request takes precedence. If you choose to provide your own encryption key,
/// the request
/// headers you provide in
/// [UploadPart](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html) and [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html) requests must match the headers you used in the
/// `CreateMultipartUpload` request.
///
/// * Use KMS keys (SSE-KMS) that include the Amazon Web Services managed key
///   (`aws/s3`) and
/// KMS customer managed keys stored in Key Management Service (KMS) – If you
/// want Amazon Web Services to manage the keys used
/// to encrypt data, specify the following headers in the request.
///
/// * `x-amz-server-side-encryption`
///
/// * `x-amz-server-side-encryption-aws-kms-key-id`
///
/// * `x-amz-server-side-encryption-context`
///
/// **Note:**
///
/// * If you specify `x-amz-server-side-encryption:aws:kms`, but don't
/// provide `x-amz-server-side-encryption-aws-kms-key-id`, Amazon S3 uses the
/// Amazon Web Services managed key (`aws/s3` key) in KMS to protect the data.
///
/// * To perform a multipart upload with encryption by using an Amazon Web
///   Services KMS key, the
/// requester must have permission to the `kms:Decrypt` and
/// `kms:GenerateDataKey*` actions on the key. These permissions are
/// required because Amazon S3 must decrypt and read data from the encrypted
/// file parts
/// before it completes the multipart upload. For more information, see
/// [Multipart
/// upload API and
/// permissions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html#mpuAndPermissions) and [Protecting data using
/// server-side encryption with Amazon Web Services
/// KMS](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html) in the
/// *Amazon S3 User Guide*.
///
/// * If your Identity and Access Management (IAM) user or role is in the same
///   Amazon Web Services account as the
/// KMS key, then you must have these permissions on the key policy. If your IAM
/// user or role is in a different account from the key, then you must have the
/// permissions on both the key policy and your IAM user or role.
///
/// * All `GET` and `PUT` requests for an object protected by
/// KMS fail if you don't make them by using Secure Sockets Layer (SSL),
/// Transport
/// Layer Security (TLS), or Signature Version 4. For information about
/// configuring any
/// of the officially supported Amazon Web Services SDKs and Amazon Web Services
/// CLI, see [Specifying the Signature Version in Request
/// Authentication](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version) in the *Amazon S3 User Guide*.
///
/// For more information about server-side encryption with KMS keys (SSE-KMS),
/// see
/// [Protecting Data Using Server-Side Encryption with KMS
/// keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html) in the
/// *Amazon S3 User Guide*.
///
/// * Use customer-provided encryption keys (SSE-C) – If you want to manage your
///   own
/// encryption keys, provide all the following headers in the request.
///
/// * `x-amz-server-side-encryption-customer-algorithm`
///
/// * `x-amz-server-side-encryption-customer-key`
///
/// * `x-amz-server-side-encryption-customer-key-MD5`
///
/// For more information about server-side encryption with customer-provided
/// encryption
/// keys (SSE-C), see [ Protecting data
/// using server-side encryption with customer-provided encryption keys
/// (SSE-C)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/ServerSideEncryptionCustomerKeys.html) in
/// the *Amazon S3 User Guide*.
///
/// * **Directory buckets** -
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
/// **Note:**
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
/// **Note:**
///
/// For directory buckets, when you perform a `CreateMultipartUpload` operation
/// and an `UploadPartCopy` operation, the request headers you provide in the
/// `CreateMultipartUpload` request must match the default encryption
/// configuration
/// of the destination bucket.
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// The following operations are related to `CreateMultipartUpload`:
///
/// *
///   [UploadPart](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html)
///
/// *
///   [CompleteMultipartUpload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html)
///
/// *
///   [AbortMultipartUpload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_AbortMultipartUpload.html)
///
/// *
///   [ListParts](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html)
///
/// *
///   [ListMultipartUploads](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListMultipartUploads.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
    ///
    /// * This functionality is not supported for directory buckets.
    ///
    /// * This functionality is not supported for Amazon S3 on Outposts.
    grant_write_acp: ?[]const u8 = null,

    /// Object key for which the multipart upload is to be initiated.
    key: []const u8,

    /// A map of metadata to store with the object in S3.
    metadata: ?[]const u8 = null,

    /// Specifies whether you want to apply a legal hold to the uploaded object.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_legal_hold_status: ?ObjectLockLegalHoldStatus = null,

    /// Specifies the Object Lock mode that you want to apply to the uploaded
    /// object.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_mode: ?ObjectLockMode = null,

    /// Specifies the date and time when you want the Object Lock to expire.
    ///
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key: ?[]const u8 = null,

    /// Specifies the 128-bit MD5 digest of the customer-provided encryption key
    /// according to RFC 1321. Amazon S3
    /// uses this header for a message integrity check to ensure that the encryption
    /// key was transmitted without
    /// error.
    ///
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    tagging: ?[]const u8 = null,

    /// If the bucket is configured as a website, redirects requests for this object
    /// to another object in
    /// the same bucket or to an external URL. Amazon S3 stores the value of this
    /// header in the object
    /// metadata.
    ///
    /// **Note:**
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
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    abort_date: ?i64 = null,

    /// This header is returned along with the `x-amz-abort-date` header. It
    /// identifies the
    /// applicable lifecycle configuration rule that defines the action to abort
    /// incomplete multipart
    /// uploads.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    abort_rule_id: ?[]const u8 = null,

    /// The name of the bucket to which the multipart upload was initiated. Does not
    /// return the access point ARN or
    /// access point alias if used.
    ///
    /// **Note:**
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
    /// **Note:**
    ///
    /// When accessing data stored in Amazon FSx file systems using S3 access
    /// points, the only valid server side
    /// encryption option is `aws:fsx`.
    server_side_encryption: ?ServerSideEncryption = null,

    /// If server-side encryption with a customer-provided encryption key was
    /// requested, the response will
    /// include this header to confirm the encryption algorithm that's used.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_algorithm: ?[]const u8 = null,

    /// If server-side encryption with a customer-provided encryption key was
    /// requested, the response will
    /// include this header to provide the round-trip message integrity verification
    /// of the customer-provided
    /// encryption key.
    ///
    /// **Note:**
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateMultipartUploadOutput) void {
        if (self.abort_rule_id) |v| {
            self.allocator.free(v);
        }
        if (self.bucket) |v| {
            self.allocator.free(v);
        }
        if (self.key) |v| {
            self.allocator.free(v);
        }
        if (self.sse_customer_algorithm) |v| {
            self.allocator.free(v);
        }
        if (self.sse_customer_key_md5) |v| {
            self.allocator.free(v);
        }
        if (self.ssekms_encryption_context) |v| {
            self.allocator.free(v);
        }
        if (self.ssekms_key_id) |v| {
            self.allocator.free(v);
        }
        if (self.upload_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateMultipartUploadInput, options: Options) !CreateMultipartUploadOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateMultipartUploadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("s3", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.bucket);
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.key);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(alloc, "uploads");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(alloc, "<CreateMultipartUploadRequest>");
    if (input.metadata) |v| {
        try body_buf.appendSlice(alloc, "<Metadata>");
        try appendXmlEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "</Metadata>");
    }
    try body_buf.appendSlice(alloc, "</CreateMultipartUploadRequest>");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
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
        try request.headers.put(alloc, "x-amz-checksum-algorithm", @tagName(v));
    }
    if (input.checksum_type) |v| {
        try request.headers.put(alloc, "x-amz-checksum-type", @tagName(v));
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

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateMultipartUploadOutput {
    var result: CreateMultipartUploadOutput = .{ .allocator = alloc };
    _ = status;
    if (findElement(body, "Bucket")) |content| {
        result.bucket = try alloc.dupe(u8, content);
    }
    if (findElement(body, "Key")) |content| {
        result.key = try alloc.dupe(u8, content);
    }
    if (findElement(body, "UploadId")) |content| {
        result.upload_id = try alloc.dupe(u8, content);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestId") orelse "";

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

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendXmlEscaped(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            '&' => try buf.appendSlice(alloc, "&amp;"),
            '<' => try buf.appendSlice(alloc, "&lt;"),
            '>' => try buf.appendSlice(alloc, "&gt;"),
            else => try buf.append(alloc, c),
        }
    }
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
