const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChecksumMode = @import("checksum_mode.zig").ChecksumMode;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const ObjectLockLegalHoldStatus = @import("object_lock_legal_hold_status.zig").ObjectLockLegalHoldStatus;
const ObjectLockMode = @import("object_lock_mode.zig").ObjectLockMode;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const StorageClass = @import("storage_class.zig").StorageClass;
const serde = @import("serde.zig");

/// Retrieves an object from Amazon S3.
///
/// In the `GetObject` request, specify the full key name for the object.
///
/// **General purpose buckets** - Both the virtual-hosted-style requests
/// and the path-style requests are supported. For a virtual hosted-style
/// request example, if you have the
/// object `photos/2006/February/sample.jpg`, specify the object key name as
/// `/photos/2006/February/sample.jpg`. For a path-style request example, if you
/// have the
/// object `photos/2006/February/sample.jpg` in the bucket named
/// `examplebucket`,
/// specify the object key name as
/// `/examplebucket/photos/2006/February/sample.jpg`. For more
/// information about request types, see [HTTP Host Header Bucket
/// Specification](https://docs.aws.amazon.com/AmazonS3/latest/dev/VirtualHosting.html#VirtualHostingSpecifyBucket) in the *Amazon S3 User Guide*.
///
/// **Directory buckets** -
/// Only virtual-hosted-style requests are supported. For a virtual hosted-style
/// request example, if you have the object `photos/2006/February/sample.jpg` in
/// the bucket named `amzn-s3-demo-bucket--usw2-az1--x-s3`, specify the object
/// key name as `/photos/2006/February/sample.jpg`. Also, when you make requests
/// to this API operation, your requests are sent to the Zonal endpoint. These
/// endpoints support virtual-hosted-style requests in the format
/// `https://*bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com/*key-name*
/// `. Path-style requests are not supported. For more information about
/// endpoints in Availability Zones, see [Regional and Zonal endpoints for
/// directory buckets in Availability
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/endpoint-directory-buckets-AZ.html) in the
/// *Amazon S3 User Guide*. For more information about endpoints in Local Zones,
/// see [Concepts for directory buckets in Local
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-lzs-for-directory-buckets.html) in the
/// *Amazon S3 User Guide*.
///
/// **Permissions**
///
/// * **General purpose bucket permissions** - You must have the
/// required permissions in a policy. To use `GetObject`, you must have the
/// `READ` access to the object (or version). If you grant `READ` access
/// to the anonymous user, the `GetObject` operation returns the object without
/// using
/// an authorization header. For more information, see [Specifying permissions
/// in a
/// policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html) in the *Amazon S3 User Guide*.
///
/// If you include a `versionId` in your request header, you must have the
/// `s3:GetObjectVersion` permission to access a specific version of an object.
/// The
/// `s3:GetObject` permission is not required in this scenario.
///
/// If you request the current version of an object without a specific
/// `versionId`
/// in the request header, only the `s3:GetObject` permission is required. The
/// `s3:GetObjectVersion` permission is not required in this scenario.
///
/// If the object that you request doesn’t exist, the error that Amazon S3
/// returns depends on
/// whether you also have the `s3:ListBucket` permission.
///
/// * If you have the `s3:ListBucket` permission on the bucket, Amazon S3
///   returns an
/// HTTP status code `404 Not Found` error.
///
/// * If you don’t have the `s3:ListBucket` permission, Amazon S3 returns an
///   HTTP
/// status code `403 Access Denied` error.
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
/// If the object is
/// encrypted using SSE-KMS, you must also have the `kms:GenerateDataKey` and
/// `kms:Decrypt` permissions in IAM identity-based policies and KMS key
/// policies
/// for the KMS key.
///
/// **Storage classes**
///
/// If the object you are retrieving is stored in the S3 Glacier Flexible
/// Retrieval storage class,
/// the S3 Glacier Deep Archive storage class, the S3 Intelligent-Tiering
/// Archive Access tier, or the
/// S3 Intelligent-Tiering Deep Archive Access tier, before you can retrieve the
/// object you must first restore a
/// copy using
/// [RestoreObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_RestoreObject.html). Otherwise, this operation returns an `InvalidObjectState`
/// error. For information about restoring archived objects, see [Restoring
/// Archived
/// Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/restoring-objects.html) in the
/// *Amazon S3 User Guide*.
///
/// **Directory buckets ** -
/// Directory buckets only support `EXPRESS_ONEZONE` (the S3 Express One Zone
/// storage class) in Availability Zones and `ONEZONE_IA` (the S3 One
/// Zone-Infrequent Access storage class) in Dedicated Local Zones.
/// Unsupported storage class values won't write a destination object and will
/// respond with the HTTP status code `400 Bad Request`.
///
/// **Encryption**
///
/// Encryption request headers, like `x-amz-server-side-encryption`, should not
/// be sent
/// for the `GetObject` requests, if your object uses server-side encryption
/// with Amazon S3
/// managed encryption keys (SSE-S3), server-side encryption with Key Management
/// Service (KMS) keys (SSE-KMS), or
/// dual-layer server-side encryption with Amazon Web Services KMS keys
/// (DSSE-KMS). If you include the header in
/// your `GetObject` requests for the object that uses these types of keys,
/// you’ll get an
/// HTTP `400 Bad Request` error.
///
/// **Directory buckets** -
/// For directory buckets, there are only two supported options for server-side
/// encryption: SSE-S3 and SSE-KMS. SSE-C isn't supported. For more
/// information, see [Protecting data with server-side
/// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-serv-side-encryption.html) in the *Amazon S3 User Guide*.
///
/// **Overriding response header values through the request**
///
/// There are times when you want to override certain response header values of
/// a
/// `GetObject` response. For example, you might override the
/// `Content-Disposition` response header value through your `GetObject`
/// request.
///
/// You can override values for a set of response headers. These modified
/// response header values
/// are included only in a successful response, that is, when the HTTP status
/// code `200 OK`
/// is returned. The headers you can override using the following query
/// parameters in the request are
/// a subset of the headers that Amazon S3 accepts when you create an object.
///
/// The response headers that you can override for the `GetObject` response are
/// `Cache-Control`, `Content-Disposition`, `Content-Encoding`,
/// `Content-Language`, `Content-Type`, and `Expires`.
///
/// To override values for a set of response headers in the `GetObject`
/// response, you
/// can use the following query parameters in the request.
///
/// * `response-cache-control`
///
/// * `response-content-disposition`
///
/// * `response-content-encoding`
///
/// * `response-content-language`
///
/// * `response-content-type`
///
/// * `response-expires`
///
/// **Note:**
///
/// When you use these parameters, you must sign the request by using either an
/// Authorization
/// header or a presigned URL. These parameters cannot be used with an unsigned
/// (anonymous)
/// request.
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// The following operations are related to `GetObject`:
///
/// *
///   [ListBuckets](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBuckets.html)
///
/// *
///   [GetObjectAcl](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectAcl.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const GetObjectInput = struct {
    /// The bucket name containing the object.
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
    /// **Object Lambda access points** - When you use this action with an Object
    /// Lambda access point, you must direct requests to the Object Lambda access
    /// point hostname. The Object Lambda access point hostname takes the form
    /// *AccessPointName*-*AccountId*.s3-object-lambda.*Region*.amazonaws.com.
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

    /// To retrieve the checksum, this mode must be enabled.
    checksum_mode: ?ChecksumMode = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// Return the object only if its entity tag (ETag) is the same as the one
    /// specified in this header;
    /// otherwise, return a `412 Precondition Failed` error.
    ///
    /// If both of the `If-Match` and `If-Unmodified-Since` headers are present in
    /// the
    /// request as follows: `If-Match` condition evaluates to `true`, and;
    /// `If-Unmodified-Since` condition evaluates to `false`; then, S3 returns `200
    /// OK` and the data requested.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_match: ?[]const u8 = null,

    /// Return the object only if it has been modified since the specified time;
    /// otherwise, return a
    /// `304 Not Modified` error.
    ///
    /// If both of the `If-None-Match` and `If-Modified-Since` headers are present
    /// in
    /// the request as follows:` If-None-Match` condition evaluates to `false`, and;
    /// `If-Modified-Since` condition evaluates to `true`; then, S3 returns `304
    /// Not Modified` status code.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_modified_since: ?i64 = null,

    /// Return the object only if its entity tag (ETag) is different from the one
    /// specified in this header;
    /// otherwise, return a `304 Not Modified` error.
    ///
    /// If both of the `If-None-Match` and `If-Modified-Since` headers are present
    /// in
    /// the request as follows:` If-None-Match` condition evaluates to `false`, and;
    /// `If-Modified-Since` condition evaluates to `true`; then, S3 returns `304
    /// Not Modified` HTTP status code.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_none_match: ?[]const u8 = null,

    /// Return the object only if it has not been modified since the specified time;
    /// otherwise, return a
    /// `412 Precondition Failed` error.
    ///
    /// If both of the `If-Match` and `If-Unmodified-Since` headers are present in
    /// the
    /// request as follows: `If-Match` condition evaluates to `true`, and;
    /// `If-Unmodified-Since` condition evaluates to `false`; then, S3 returns `200
    /// OK` and the data requested.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_unmodified_since: ?i64 = null,

    /// Key of the object to get.
    key: []const u8,

    /// Part number of the object being read. This is a positive integer between 1
    /// and 10,000. Effectively
    /// performs a 'ranged' GET request for the part specified. Useful for
    /// downloading just a part of an
    /// object.
    part_number: ?i32 = null,

    /// Downloads the specified byte range of an object. For more information about
    /// the HTTP Range header,
    /// see
    /// [https://www.rfc-editor.org/rfc/rfc9110.html#name-range](https://www.rfc-editor.org/rfc/rfc9110.html#name-range).
    ///
    /// **Note:**
    ///
    /// Amazon S3 doesn't support retrieving multiple ranges of data per `GET`
    /// request.
    range: ?[]const u8 = null,

    request_payer: ?RequestPayer = null,

    /// Sets the `Cache-Control` header of the response.
    response_cache_control: ?[]const u8 = null,

    /// Sets the `Content-Disposition` header of the response.
    response_content_disposition: ?[]const u8 = null,

    /// Sets the `Content-Encoding` header of the response.
    response_content_encoding: ?[]const u8 = null,

    /// Sets the `Content-Language` header of the response.
    response_content_language: ?[]const u8 = null,

    /// Sets the `Content-Type` header of the response.
    response_content_type: ?[]const u8 = null,

    /// Sets the `Expires` header of the response.
    response_expires: ?i64 = null,

    /// Specifies the algorithm to use when decrypting the object (for example,
    /// `AES256`).
    ///
    /// If you encrypt an object by using server-side encryption with
    /// customer-provided encryption keys
    /// (SSE-C) when you store the object in Amazon S3, then when you GET the
    /// object, you must use the following
    /// headers:
    ///
    /// * `x-amz-server-side-encryption-customer-algorithm`
    ///
    /// * `x-amz-server-side-encryption-customer-key`
    ///
    /// * `x-amz-server-side-encryption-customer-key-MD5`
    ///
    /// For more information about SSE-C, see [Server-Side Encryption (Using
    /// Customer-Provided Encryption
    /// Keys)](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the *Amazon S3 User Guide*.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_algorithm: ?[]const u8 = null,

    /// Specifies the customer-provided encryption key that you originally provided
    /// for Amazon S3 to encrypt the
    /// data before storing it. This value is used to decrypt the object when
    /// recovering it and must match the
    /// one used when storing the data. The key must be appropriate for use with the
    /// algorithm specified in the
    /// `x-amz-server-side-encryption-customer-algorithm` header.
    ///
    /// If you encrypt an object by using server-side encryption with
    /// customer-provided encryption keys
    /// (SSE-C) when you store the object in Amazon S3, then when you GET the
    /// object, you must use the following
    /// headers:
    ///
    /// * `x-amz-server-side-encryption-customer-algorithm`
    ///
    /// * `x-amz-server-side-encryption-customer-key`
    ///
    /// * `x-amz-server-side-encryption-customer-key-MD5`
    ///
    /// For more information about SSE-C, see [Server-Side Encryption (Using
    /// Customer-Provided Encryption
    /// Keys)](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the *Amazon S3 User Guide*.
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
    /// If you encrypt an object by using server-side encryption with
    /// customer-provided encryption keys
    /// (SSE-C) when you store the object in Amazon S3, then when you GET the
    /// object, you must use the following
    /// headers:
    ///
    /// * `x-amz-server-side-encryption-customer-algorithm`
    ///
    /// * `x-amz-server-side-encryption-customer-key`
    ///
    /// * `x-amz-server-side-encryption-customer-key-MD5`
    ///
    /// For more information about SSE-C, see [Server-Side Encryption (Using
    /// Customer-Provided Encryption
    /// Keys)](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the *Amazon S3 User Guide*.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key_md5: ?[]const u8 = null,

    /// Version ID used to reference a specific version of the object.
    ///
    /// By default, the `GetObject` operation returns the current version of an
    /// object. To return
    /// a different version, use the `versionId` subresource.
    ///
    /// **Note:**
    ///
    /// * If you include a `versionId` in your request header, you must have the
    /// `s3:GetObjectVersion` permission to access a specific version of an object.
    /// The
    /// `s3:GetObject` permission is not required in this scenario.
    ///
    /// * If you request the current version of an object without a specific
    ///   `versionId` in
    /// the request header, only the `s3:GetObject` permission is required. The
    /// `s3:GetObjectVersion` permission is not required in this scenario.
    ///
    /// * **Directory buckets** - S3 Versioning isn't enabled and supported for
    ///   directory buckets. For this API operation, only the `null` value of the
    ///   version ID is supported by directory buckets.
    /// You can only specify `null` to the `versionId` query parameter in the
    /// request.
    ///
    /// For more information about versioning, see
    /// [PutBucketVersioning](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketVersioning.html).
    version_id: ?[]const u8 = null,
};

pub const GetObjectOutput = struct {
    /// Indicates that a range of bytes was specified in the request.
    accept_ranges: ?[]const u8 = null,

    /// Object data.
    body: aws.http.StreamingBody = undefined,

    /// Indicates whether the object uses an S3 Bucket Key for server-side
    /// encryption with Key Management Service (KMS)
    /// keys (SSE-KMS).
    bucket_key_enabled: ?bool = null,

    /// Specifies caching behavior along the request/reply chain.
    cache_control: ?[]const u8 = null,

    /// The Base64 encoded, 32-bit `CRC32` checksum of the object. This checksum is
    /// only present if the object was uploaded
    /// with the object. For more information, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_crc32: ?[]const u8 = null,

    /// The Base64 encoded, 32-bit `CRC32C` checksum of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. For more information, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_crc32_c: ?[]const u8 = null,

    /// The Base64 encoded, 64-bit `CRC64NVME` checksum of the object. For more
    /// information, see
    /// [Checking
    /// object integrity in the Amazon S3 User
    /// Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html).
    checksum_crc64_nvme: ?[]const u8 = null,

    /// The Base64 encoded, 160-bit `SHA1` digest of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. For more information, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_sha1: ?[]const u8 = null,

    /// The Base64 encoded, 256-bit `SHA256` digest of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. For more information, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_sha256: ?[]const u8 = null,

    /// The checksum type, which determines how part-level checksums are combined to
    /// create an object-level
    /// checksum for multipart objects. You can use this header response to verify
    /// that the checksum type that
    /// is received is the same checksum type that was specified in the
    /// `CreateMultipartUpload`
    /// request. For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_type: ?ChecksumType = null,

    /// Specifies presentational information for the object.
    content_disposition: ?[]const u8 = null,

    /// Indicates what content encodings have been applied to the object and thus
    /// what decoding mechanisms
    /// must be applied to obtain the media-type referenced by the Content-Type
    /// header field.
    content_encoding: ?[]const u8 = null,

    /// The language the content is in.
    content_language: ?[]const u8 = null,

    /// Size of the body in bytes.
    content_length: ?i64 = null,

    /// The portion of the object returned in the response.
    content_range: ?[]const u8 = null,

    /// A standard MIME type describing the format of the object data.
    content_type: ?[]const u8 = null,

    /// Indicates whether the object retrieved was (true) or was not (false) a
    /// Delete Marker. If false, this
    /// response header does not appear in the response.
    ///
    /// **Note:**
    ///
    /// * If the current version of the object is a delete marker, Amazon S3 behaves
    ///   as if the object was
    /// deleted and includes `x-amz-delete-marker: true` in the response.
    ///
    /// * If the specified version in the request is a delete marker, the response
    ///   returns a `405
    /// Method Not Allowed` error and the `Last-Modified: timestamp` response
    /// header.
    delete_marker: ?bool = null,

    /// An entity tag (ETag) is an opaque identifier assigned by a web server to a
    /// specific version of a
    /// resource found at a URL.
    e_tag: ?[]const u8 = null,

    /// If the object expiration is configured (see [
    /// `PutBucketLifecycleConfiguration`
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html)), the response includes this header. It
    /// includes the `expiry-date` and `rule-id` key-value pairs providing object
    /// expiration information. The value of the `rule-id` is URL-encoded.
    ///
    /// **Note:**
    ///
    /// Object expiration information is not returned in directory buckets and this
    /// header returns the
    /// value "`NotImplemented`" in all responses for directory buckets.
    expiration: ?[]const u8 = null,

    /// The date and time at which the object is no longer cacheable.
    expires: ?[]const u8 = null,

    /// Date and time when the object was last modified.
    ///
    /// **General purpose buckets ** - When you specify a
    /// `versionId` of the object in your request, if the specified version in the
    /// request is a
    /// delete marker, the response returns a `405 Method Not Allowed` error and the
    /// `Last-Modified: timestamp` response header.
    last_modified: ?i64 = null,

    /// A map of metadata to store with the object in S3.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// This is set to the number of metadata entries not returned in the headers
    /// that are prefixed with
    /// `x-amz-meta-`. This can happen if you create metadata using an API like SOAP
    /// that supports
    /// more flexible metadata than the REST API. For example, using SOAP, you can
    /// create metadata whose values
    /// are not legal HTTP headers.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    missing_meta: ?i32 = null,

    /// Indicates whether this object has an active legal hold. This field is only
    /// returned if you have
    /// permission to view an object's legal hold status.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_legal_hold_status: ?ObjectLockLegalHoldStatus = null,

    /// The Object Lock mode that's currently in place for this object.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_mode: ?ObjectLockMode = null,

    /// The date and time when this object's Object Lock will expire.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_retain_until_date: ?i64 = null,

    /// The count of parts this object has. This value is only returned if you
    /// specify
    /// `partNumber` in your request and the object was uploaded as a multipart
    /// upload.
    parts_count: ?i32 = null,

    /// Amazon S3 can return this if your request involves a bucket that is either a
    /// source or destination in a
    /// replication rule.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    replication_status: ?ReplicationStatus = null,

    request_charged: ?RequestCharged = null,

    /// Provides information about object restoration action and expiration time of
    /// the restored object
    /// copy.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets. Directory buckets
    /// only support `EXPRESS_ONEZONE` (the S3 Express One Zone storage class) in
    /// Availability Zones and `ONEZONE_IA` (the S3 One Zone-Infrequent Access
    /// storage class) in Dedicated Local Zones.
    restore: ?[]const u8 = null,

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

    /// If present, indicates the ID of the KMS key that was used for object
    /// encryption.
    ssekms_key_id: ?[]const u8 = null,

    /// Provides storage class information of the object. Amazon S3 returns this
    /// header for all objects except
    /// for S3 Standard storage class objects.
    ///
    /// **Note:**
    ///
    /// **Directory buckets ** -
    /// Directory buckets only support `EXPRESS_ONEZONE` (the S3 Express One Zone
    /// storage class) in Availability Zones and `ONEZONE_IA` (the S3 One
    /// Zone-Infrequent Access storage class) in Dedicated Local Zones.
    storage_class: ?StorageClass = null,

    /// The number of tags, if any, on the object, when you have the relevant
    /// permission to read object
    /// tags.
    ///
    /// You can use
    /// [GetObjectTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectTagging.html) to retrieve the tag set associated with an object.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    tag_count: ?i32 = null,

    /// Version ID of the object.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    version_id: ?[]const u8 = null,

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetObjectOutput) void {
        self.body.deinit();
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetObjectInput, options: Options) !GetObjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeStreamingResponse(&stream_resp, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetObjectInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "x-id=GetObject");
    query_has_prev = true;
    if (input.part_number) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "partNumber=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (input.response_cache_control) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "response-cache-control=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_content_disposition) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "response-content-disposition=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_content_encoding) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "response-content-encoding=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_content_language) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "response-content-language=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_content_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "response-content-type=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_expires) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "response-expires=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (input.version_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "versionId=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.checksum_mode) |v| {
        try request.headers.put(alloc, "x-amz-checksum-mode", @tagName(v));
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }
    if (input.if_match) |v| {
        try request.headers.put(alloc, "If-Match", v);
    }
    if (input.if_modified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "If-Modified-Since", num_str);
        }
    }
    if (input.if_none_match) |v| {
        try request.headers.put(alloc, "If-None-Match", v);
    }
    if (input.if_unmodified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "If-Unmodified-Since", num_str);
        }
    }
    if (input.range) |v| {
        try request.headers.put(alloc, "Range", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(alloc, "x-amz-request-payer", @tagName(v));
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

    return request;
}

fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !GetObjectOutput {
    var result: GetObjectOutput = .{};
    result.body = stream_resp.body;
    if (stream_resp.headers.get("accept-ranges")) |value| {
        result.accept_ranges = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-server-side-encryption-bucket-key-enabled")) |value| {
        result.bucket_key_enabled = std.mem.eql(u8, value, "true");
    }
    if (stream_resp.headers.get("cache-control")) |value| {
        result.cache_control = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-crc32")) |value| {
        result.checksum_crc32 = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-crc32c")) |value| {
        result.checksum_crc32_c = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-crc64nvme")) |value| {
        result.checksum_crc64_nvme = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-sha1")) |value| {
        result.checksum_sha1 = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-sha256")) |value| {
        result.checksum_sha256 = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-type")) |value| {
        result.checksum_type = std.meta.stringToEnum(ChecksumType, value);
    }
    if (stream_resp.headers.get("content-disposition")) |value| {
        result.content_disposition = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-encoding")) |value| {
        result.content_encoding = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-language")) |value| {
        result.content_language = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-length")) |value| {
        result.content_length = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (stream_resp.headers.get("content-range")) |value| {
        result.content_range = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-delete-marker")) |value| {
        result.delete_marker = std.mem.eql(u8, value, "true");
    }
    if (stream_resp.headers.get("etag")) |value| {
        result.e_tag = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-expiration")) |value| {
        result.expiration = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("expires")) |value| {
        result.expires = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("last-modified")) |value| {
        result.last_modified = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (stream_resp.headers.get("x-amz-missing-meta")) |value| {
        result.missing_meta = std.fmt.parseInt(i32, value, 10) catch null;
    }
    if (stream_resp.headers.get("x-amz-object-lock-legal-hold")) |value| {
        result.object_lock_legal_hold_status = std.meta.stringToEnum(ObjectLockLegalHoldStatus, value);
    }
    if (stream_resp.headers.get("x-amz-object-lock-mode")) |value| {
        result.object_lock_mode = std.meta.stringToEnum(ObjectLockMode, value);
    }
    if (stream_resp.headers.get("x-amz-object-lock-retain-until-date")) |value| {
        result.object_lock_retain_until_date = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (stream_resp.headers.get("x-amz-mp-parts-count")) |value| {
        result.parts_count = std.fmt.parseInt(i32, value, 10) catch null;
    }
    if (stream_resp.headers.get("x-amz-replication-status")) |value| {
        result.replication_status = std.meta.stringToEnum(ReplicationStatus, value);
    }
    if (stream_resp.headers.get("x-amz-request-charged")) |value| {
        result.request_charged = std.meta.stringToEnum(RequestCharged, value);
    }
    if (stream_resp.headers.get("x-amz-restore")) |value| {
        result.restore = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-server-side-encryption")) |value| {
        result.server_side_encryption = std.meta.stringToEnum(ServerSideEncryption, value);
    }
    if (stream_resp.headers.get("x-amz-server-side-encryption-customer-algorithm")) |value| {
        result.sse_customer_algorithm = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-server-side-encryption-customer-key-md5")) |value| {
        result.sse_customer_key_md5 = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-server-side-encryption-aws-kms-key-id")) |value| {
        result.ssekms_key_id = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-storage-class")) |value| {
        result.storage_class = std.meta.stringToEnum(StorageClass, value);
    }
    if (stream_resp.headers.get("x-amz-tagging-count")) |value| {
        result.tag_count = std.fmt.parseInt(i32, value, 10) catch null;
    }
    if (stream_resp.headers.get("x-amz-version-id")) |value| {
        result.version_id = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-website-redirect-location")) |value| {
        result.website_redirect_location = try alloc.dupe(u8, value);
    }
    stream_resp.deinitHeaders();

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
