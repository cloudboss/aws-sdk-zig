const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const CopyPartResult = @import("copy_part_result.zig").CopyPartResult;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const serde = @import("serde.zig");

/// Uploads a part by copying data from an existing object as data source. To
/// specify the data source,
/// you add the request header `x-amz-copy-source` in your request. To specify a
/// byte range, you
/// add the request header `x-amz-copy-source-range` in your request.
///
/// For information about maximum and minimum part sizes and other multipart
/// upload specifications, see
/// [Multipart upload
/// limits](https://docs.aws.amazon.com/AmazonS3/latest/userguide/qfacts.html)
/// in the *Amazon S3 User Guide*.
///
/// **Note:**
///
/// Instead of copying data from an existing object as part data, you might use
/// the
/// [UploadPart](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html) action to
/// upload new data as a part of an object in your request.
///
/// You must initiate a multipart upload before you can upload any part. In
/// response to your initiate
/// request, Amazon S3 returns the upload ID, a unique identifier that you must
/// include in your upload part
/// request.
///
/// For conceptual information about multipart uploads, see [Uploading Objects
/// Using Multipart
/// Upload](https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html) in
/// the *Amazon S3 User Guide*. For information about copying objects using a
/// single atomic
/// action vs. a multipart upload, see [Operations on
/// Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectOperations.html) in the
/// *Amazon S3 User Guide*.
///
/// **Note:**
///
/// **Directory buckets** - For directory buckets, you must make requests for
/// this API operation to the Zonal endpoint. These endpoints support
/// virtual-hosted-style requests in the format
/// `https://*amzn-s3-demo-bucket*.s3express-*zone-id*.*region-code*.amazonaws.com/*key-name*
/// `. Path-style requests are not supported. For more information about
/// endpoints in Availability Zones, see [Regional and Zonal endpoints for
/// directory buckets in Availability
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/endpoint-directory-buckets-AZ.html) in the
/// *Amazon S3 User Guide*. For more information about endpoints in Local Zones,
/// see [Concepts for directory buckets in Local
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-lzs-for-directory-buckets.html) in the
/// *Amazon S3 User Guide*.
///
/// **Authentication and authorization**
///
/// All `UploadPartCopy` requests must be authenticated and signed by using IAM
/// credentials (access key ID and secret access key for the IAM identities).
/// All headers with the
/// `x-amz-` prefix, including `x-amz-copy-source`, must be signed. For more
/// information, see [REST
/// Authentication](https://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html).
///
/// **Directory buckets** - You must use IAM credentials to
/// authenticate and authorize your access to the `UploadPartCopy` API
/// operation, instead
/// of using the temporary security credentials through the `CreateSession` API
/// operation.
///
/// Amazon Web Services CLI or SDKs handles authentication and authorization on
/// your behalf.
///
/// **Permissions**
///
/// You must have `READ` access to the source object and `WRITE` access to
/// the destination bucket.
///
/// * **General purpose bucket permissions** - You must have the
/// permissions in a policy based on the bucket types of your source bucket and
/// destination bucket
/// in an `UploadPartCopy` operation.
///
/// * If the source object is in a general purpose bucket, you must have the **
/// `s3:GetObject`
/// ** permission to read the source object that is
/// being copied.
///
/// * If the destination bucket is a general purpose bucket, you must have the
///   **
/// `s3:PutObject`
/// ** permission to write the object copy to
/// the destination bucket.
///
/// * To perform a multipart upload with encryption using an Key Management
///   Service key, the requester
/// must have permission to the `kms:Decrypt` and `kms:GenerateDataKey`
/// actions on the key. The requester must also have permissions for the
/// `kms:GenerateDataKey` action for the `CreateMultipartUpload` API.
/// Then, the requester needs permissions for the `kms:Decrypt` action on the
/// `UploadPart` and `UploadPartCopy` APIs. These permissions are
/// required because Amazon S3 must decrypt and read data from the encrypted
/// file parts before it
/// completes the multipart upload. For more information about KMS permissions,
/// see [Protecting
/// data using server-side encryption with
/// KMS](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html) in the
/// *Amazon S3 User Guide*. For information about the permissions required to
/// use the multipart upload API, see [Multipart upload and
/// permissions](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html) and [Multipart upload API
/// and
/// permissions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html#mpuAndPermissions) in the *Amazon S3 User Guide*.
///
/// * **Directory bucket permissions** - You must have
/// permissions in a bucket policy or an IAM identity-based policy based on the
/// source and destination bucket types
/// in an `UploadPartCopy` operation.
///
/// * If the source object that you want to copy is in a directory bucket, you
///   must have
/// the **
/// `s3express:CreateSession`
/// ** permission in
/// the `Action` element of a policy to read the object. By default, the session
/// is
/// in the `ReadWrite` mode. If you want to restrict the access, you can
/// explicitly
/// set the `s3express:SessionMode` condition key to `ReadOnly` on the
/// copy source bucket.
///
/// * If the copy destination is a directory bucket, you must have the **
/// `s3express:CreateSession`
/// ** permission in the
/// `Action` element of a policy to write the object to the destination. The
/// `s3express:SessionMode` condition key cannot be set to `ReadOnly`
/// on the copy destination.
///
/// If the object is encrypted with SSE-KMS, you must also have the
/// `kms:GenerateDataKey` and `kms:Decrypt` permissions in IAM
/// identity-based policies and KMS key policies for the KMS key.
///
/// For example policies, see [Example
/// bucket policies for S3 Express One
/// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-security-iam-example-bucket-policies.html) and [Amazon Web Services
/// Identity and Access Management (IAM) identity-based policies for S3 Express
/// One
/// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-security-iam-identity-policies.html) in the
/// *Amazon S3 User Guide*.
///
/// **Encryption**
///
/// * **General purpose buckets ** -
/// For information about using server-side encryption with
/// customer-provided encryption keys with the `UploadPartCopy` operation, see
/// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html) and
/// [UploadPart](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html).
///
/// **Note:**
///
/// If you have server-side encryption with customer-provided keys (SSE-C)
/// blocked for your general purpose bucket, you will get an HTTP 403 Access
/// Denied error when you specify the SSE-C request headers while writing new
/// data to your bucket. For more information, see [Blocking or unblocking SSE-C
/// for a general purpose
/// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/blocking-unblocking-s3-c-encryption-gpb.html).
///
/// * **Directory buckets ** -
/// For directory buckets, there are only two supported options for server-side
/// encryption: server-side encryption with Amazon S3 managed keys (SSE-S3)
/// (`AES256`) and server-side encryption with KMS keys (SSE-KMS) (`aws:kms`).
/// For more
/// information, see [Protecting data with server-side
/// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-serv-side-encryption.html) in the *Amazon S3 User Guide*.
///
/// **Note:**
///
/// For directory buckets, when you perform a `CreateMultipartUpload` operation
/// and an `UploadPartCopy` operation, the request headers you provide in the
/// `CreateMultipartUpload` request must match the default encryption
/// configuration
/// of the destination bucket.
///
/// S3 Bucket Keys aren't supported, when you copy SSE-KMS encrypted objects
/// from general purpose buckets
/// to directory buckets, from directory buckets to general purpose buckets, or
/// between directory buckets, through
/// [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html). In this case, Amazon S3 makes a call to KMS every time a copy request is made for a KMS-encrypted object.
///
/// **Special errors**
///
/// * Error Code: `NoSuchUpload`
///
/// * Description: The specified multipart upload does not exist. The upload ID
///   might be
/// invalid, or the multipart upload might have been aborted or completed.
///
/// * HTTP Status Code: 404 Not Found
///
/// * Error Code: `InvalidRequest`
///
/// * Description: The specified copy source is not supported as a byte-range
///   copy
/// source.
///
/// * HTTP Status Code: 400 Bad Request
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// The following operations are related to `UploadPartCopy`:
///
/// *
///   [CreateMultipartUpload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html)
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
pub const UploadPartCopyInput = struct {
    /// The bucket name.
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
    /// **Note:**
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

    /// Specifies the source object for the copy operation. You specify the value in
    /// one of two formats,
    /// depending on whether you want to access the source object through an [access
    /// point](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points.html):
    ///
    /// * For objects not accessed through an access point, specify the name of the
    ///   source bucket and key of the
    /// source object, separated by a slash (/). For example, to copy the object
    /// `reports/january.pdf` from the bucket `awsexamplebucket`, use
    /// `awsexamplebucket/reports/january.pdf`. The value must be URL-encoded.
    ///
    /// * For objects accessed through access points, specify the Amazon Resource
    ///   Name (ARN) of the object as accessed through the access point, in the
    ///   format `arn:aws:s3:::accesspoint//object/`. For example, to copy the
    ///   object `reports/january.pdf` through access point `my-access-point` owned
    ///   by account `123456789012` in Region `us-west-2`, use the URL encoding of
    ///   `arn:aws:s3:us-west-2:123456789012:accesspoint/my-access-point/object/reports/january.pdf`. The value must be URL encoded.
    ///
    /// **Note:**
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
    /// If your bucket has versioning enabled, you could have multiple versions of
    /// the same object. By
    /// default, `x-amz-copy-source` identifies the current version of the source
    /// object to copy. To
    /// copy a specific version of the source object to copy, append `?versionId=`
    /// to
    /// the `x-amz-copy-source` request header (for example, `x-amz-copy-source:
    /// /awsexamplebucket/reports/january.pdf?versionId=QUpfdndhfd8438MNFDN93jdnJFkdmqnh893`).
    ///
    /// If the current version is a delete marker and you don't specify a versionId
    /// in the
    /// `x-amz-copy-source` request header, Amazon S3 returns a `404 Not Found`
    /// error,
    /// because the object does not exist. If you specify versionId in the
    /// `x-amz-copy-source` and
    /// the versionId is a delete marker, Amazon S3 returns an HTTP `400 Bad
    /// Request` error, because you
    /// are not allowed to specify a delete marker as a version for the
    /// `x-amz-copy-source`.
    ///
    /// **Note:**
    ///
    /// **Directory buckets** - S3 Versioning isn't enabled and supported for
    /// directory buckets.
    copy_source: []const u8,

    /// Copies the object if its entity tag (ETag) matches the specified tag.
    ///
    /// If both of the `x-amz-copy-source-if-match` and
    /// `x-amz-copy-source-if-unmodified-since` headers are present in the request
    /// as
    /// follows:
    ///
    /// `x-amz-copy-source-if-match` condition evaluates to `true`, and;
    ///
    /// `x-amz-copy-source-if-unmodified-since` condition evaluates to `false`;
    ///
    /// Amazon S3 returns `200 OK` and copies the data.
    copy_source_if_match: ?[]const u8 = null,

    /// Copies the object if it has been modified since the specified time.
    ///
    /// If both of the `x-amz-copy-source-if-none-match` and
    /// `x-amz-copy-source-if-modified-since` headers are present in the request as
    /// follows:
    ///
    /// `x-amz-copy-source-if-none-match` condition evaluates to `false`, and;
    ///
    /// `x-amz-copy-source-if-modified-since` condition evaluates to `true`;
    ///
    /// Amazon S3 returns `412 Precondition Failed` response code.
    copy_source_if_modified_since: ?i64 = null,

    /// Copies the object if its entity tag (ETag) is different than the specified
    /// ETag.
    ///
    /// If both of the `x-amz-copy-source-if-none-match` and
    /// `x-amz-copy-source-if-modified-since` headers are present in the request as
    /// follows:
    ///
    /// `x-amz-copy-source-if-none-match` condition evaluates to `false`, and;
    ///
    /// `x-amz-copy-source-if-modified-since` condition evaluates to `true`;
    ///
    /// Amazon S3 returns `412 Precondition Failed` response code.
    copy_source_if_none_match: ?[]const u8 = null,

    /// Copies the object if it hasn't been modified since the specified time.
    ///
    /// If both of the `x-amz-copy-source-if-match` and
    /// `x-amz-copy-source-if-unmodified-since` headers are present in the request
    /// as
    /// follows:
    ///
    /// `x-amz-copy-source-if-match` condition evaluates to `true`, and;
    ///
    /// `x-amz-copy-source-if-unmodified-since` condition evaluates to `false`;
    ///
    /// Amazon S3 returns `200 OK` and copies the data.
    copy_source_if_unmodified_since: ?i64 = null,

    /// The range of bytes to copy from the source object. The range value must use
    /// the form
    /// bytes=first-last, where the first and last are the zero-based byte offsets
    /// to copy. For example,
    /// bytes=0-9 indicates that you want to copy the first 10 bytes of the source.
    /// You can copy a range only if
    /// the source object is greater than 5 MB.
    copy_source_range: ?[]const u8 = null,

    /// Specifies the algorithm to use when decrypting the source object (for
    /// example,
    /// `AES256`).
    ///
    /// **Note:**
    ///
    /// This functionality is not supported when the source object is in a directory
    /// bucket.
    copy_source_sse_customer_algorithm: ?[]const u8 = null,

    /// Specifies the customer-provided encryption key for Amazon S3 to use to
    /// decrypt the source object. The
    /// encryption key provided in this header must be one that was used when the
    /// source object was
    /// created.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported when the source object is in a directory
    /// bucket.
    copy_source_sse_customer_key: ?[]const u8 = null,

    /// Specifies the 128-bit MD5 digest of the encryption key according to RFC
    /// 1321. Amazon S3 uses this header
    /// for a message integrity check to ensure that the encryption key was
    /// transmitted without error.
    ///
    /// **Note:**
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

    /// Object key for which the multipart upload was initiated.
    key: []const u8,

    /// Part number of part being copied. This is a positive integer between 1 and
    /// 10,000.
    part_number: i32,

    request_payer: ?RequestPayer = null,

    /// Specifies the algorithm to use when encrypting the object (for example,
    /// AES256).
    ///
    /// **Note:**
    ///
    /// This functionality is not supported when the destination bucket is a
    /// directory bucket.
    sse_customer_algorithm: ?[]const u8 = null,

    /// Specifies the customer-provided encryption key for Amazon S3 to use in
    /// encrypting data. This value is
    /// used to store the object and then it is discarded; Amazon S3 does not store
    /// the encryption key. The key must
    /// be appropriate for use with the algorithm specified in the
    /// `x-amz-server-side-encryption-customer-algorithm` header. This must be the
    /// same encryption
    /// key specified in the initiate multipart upload request.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported when the destination bucket is a
    /// directory bucket.
    sse_customer_key: ?[]const u8 = null,

    /// Specifies the 128-bit MD5 digest of the encryption key according to RFC
    /// 1321. Amazon S3 uses this header
    /// for a message integrity check to ensure that the encryption key was
    /// transmitted without error.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported when the destination bucket is a
    /// directory bucket.
    sse_customer_key_md5: ?[]const u8 = null,

    /// Upload ID identifying the multipart upload whose part is being copied.
    upload_id: []const u8,
};

pub const UploadPartCopyOutput = struct {
    /// Indicates whether the multipart upload uses an S3 Bucket Key for server-side
    /// encryption with
    /// Key Management Service (KMS) keys (SSE-KMS).
    bucket_key_enabled: ?bool = null,

    /// Container for all response elements.
    copy_part_result: ?CopyPartResult = null,

    /// The version of the source object that was copied, if you have enabled
    /// versioning on the source
    /// bucket.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported when the source object is in a directory
    /// bucket.
    copy_source_version_id: ?[]const u8 = null,

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

    /// If present, indicates the ID of the KMS key that was used for object
    /// encryption.
    ssekms_key_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *UploadPartCopyOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: UploadPartCopyInput, options: Options) !UploadPartCopyOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UploadPartCopyInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "x-id=UploadPartCopy");
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "partNumber=");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{input.part_number}) catch "";
        try query_buf.appendSlice(alloc, num_str);
    }
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "uploadId=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.upload_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    try request.headers.put(alloc, "x-amz-copy-source", input.copy_source);
    if (input.copy_source_if_match) |v| {
        try request.headers.put(alloc, "x-amz-copy-source-if-match", v);
    }
    if (input.copy_source_if_modified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-copy-source-if-modified-since", num_str);
        }
    }
    if (input.copy_source_if_none_match) |v| {
        try request.headers.put(alloc, "x-amz-copy-source-if-none-match", v);
    }
    if (input.copy_source_if_unmodified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-copy-source-if-unmodified-since", num_str);
        }
    }
    if (input.copy_source_range) |v| {
        try request.headers.put(alloc, "x-amz-copy-source-range", v);
    }
    if (input.copy_source_sse_customer_algorithm) |v| {
        try request.headers.put(alloc, "x-amz-copy-source-server-side-encryption-customer-algorithm", v);
    }
    if (input.copy_source_sse_customer_key) |v| {
        try request.headers.put(alloc, "x-amz-copy-source-server-side-encryption-customer-key", v);
    }
    if (input.copy_source_sse_customer_key_md5) |v| {
        try request.headers.put(alloc, "x-amz-copy-source-server-side-encryption-customer-key-MD5", v);
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }
    if (input.expected_source_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-source-expected-bucket-owner", v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UploadPartCopyOutput {
    var result: UploadPartCopyOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("x-amz-server-side-encryption-bucket-key-enabled")) |value| {
        result.bucket_key_enabled = std.mem.eql(u8, value, "true");
    }
    if (headers.get("x-amz-copy-source-version-id")) |value| {
        result.copy_source_version_id = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = std.meta.stringToEnum(RequestCharged, value);
    }
    if (headers.get("x-amz-server-side-encryption")) |value| {
        result.server_side_encryption = std.meta.stringToEnum(ServerSideEncryption, value);
    }
    if (headers.get("x-amz-server-side-encryption-customer-algorithm")) |value| {
        result.sse_customer_algorithm = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-customer-key-md5")) |value| {
        result.sse_customer_key_md5 = try alloc.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-aws-kms-key-id")) |value| {
        result.ssekms_key_id = try alloc.dupe(u8, value);
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
