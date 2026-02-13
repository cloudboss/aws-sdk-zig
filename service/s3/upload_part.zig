const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;

/// Uploads a part in a multipart upload.
///
/// **Note:**
///
/// In this operation, you provide new data as a part of an object in your
/// request. However, you have
/// an option to specify your existing Amazon S3 object as a data source for the
/// part you are uploading. To
/// upload a part from an existing object, you use the
/// [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html) operation.
///
/// You must initiate a multipart upload (see
/// [CreateMultipartUpload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html)) before you can
/// upload any part. In response to your initiate request, Amazon S3 returns an
/// upload ID, a unique identifier
/// that you must include in your upload part request.
///
/// Part numbers can be any number from 1 to 10,000, inclusive. A part number
/// uniquely identifies a part
/// and also defines its position within the object being created. If you upload
/// a new part using the same
/// part number that was used with a previous part, the previously uploaded part
/// is overwritten.
///
/// For information about maximum and minimum part sizes and other multipart
/// upload specifications, see
/// [Multipart upload
/// limits](https://docs.aws.amazon.com/AmazonS3/latest/userguide/qfacts.html)
/// in the *Amazon S3 User Guide*.
///
/// **Note:**
///
/// After you initiate multipart upload and upload one or more parts, you must
/// either complete or
/// abort multipart upload in order to stop getting charged for storage of the
/// uploaded parts. Only after
/// you either complete or abort multipart upload, Amazon S3 frees up the parts
/// storage and stops charging you
/// for the parts storage.
///
/// For more information on multipart uploads, go to [Multipart Upload
/// Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html)
/// in the
/// *Amazon S3 User Guide *.
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
/// **Permissions**
///
/// * **General purpose bucket permissions** - To perform a
/// multipart upload with encryption using an Key Management Service key, the
/// requester must have permission to
/// the `kms:Decrypt` and `kms:GenerateDataKey` actions on the key. The
/// requester must also have permissions for the `kms:GenerateDataKey` action
/// for the
/// `CreateMultipartUpload` API. Then, the requester needs permissions for the
/// `kms:Decrypt` action on the `UploadPart` and
/// `UploadPartCopy` APIs.
///
/// These permissions are required because Amazon S3 must decrypt and read data
/// from the encrypted
/// file parts before it completes the multipart upload. For more information
/// about KMS
/// permissions, see [Protecting data using server-side
/// encryption with
/// KMS](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html) in the *Amazon S3 User Guide*. For information
/// about the permissions required to use the multipart upload API, see
/// [Multipart upload and
/// permissions](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html) and [Multipart upload API and
/// permissions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html#mpuAndPermissions) in the *Amazon S3 User Guide*.
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
/// If the object is encrypted with SSE-KMS, you must also have the
/// `kms:GenerateDataKey` and `kms:Decrypt` permissions in IAM
/// identity-based policies and KMS key policies for the KMS key.
///
/// **Data integrity**
///
/// **General purpose bucket** - To ensure that data is not corrupted
/// traversing the network, specify the `Content-MD5` header in the upload part
/// request.
/// Amazon S3 checks the part data against the provided MD5 value. If they do
/// not match, Amazon S3 returns an
/// error. If the upload request is signed with Signature Version 4, then Amazon
/// Web Services S3 uses the
/// `x-amz-content-sha256` header as a checksum instead of `Content-MD5`. For
/// more information see [Authenticating Requests:
/// Using the Authorization Header (Amazon Web Services Signature Version
/// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-auth-using-authorization-header.html).
///
/// **Note:**
///
/// **Directory buckets** - MD5 is not supported by directory buckets. You can
/// use checksum algorithms to check object integrity.
///
/// **Encryption**
///
/// * **General purpose bucket** - Server-side encryption is for
/// data encryption at rest. Amazon S3 encrypts your data as it writes it to
/// disks in its data centers
/// and decrypts it when you access it. You have mutually exclusive options to
/// protect data using
/// server-side encryption in Amazon S3, depending on how you choose to manage
/// the encryption keys.
/// Specifically, the encryption key options are Amazon S3 managed keys
/// (SSE-S3), Amazon Web Services KMS keys
/// (SSE-KMS), and Customer-Provided Keys (SSE-C). Amazon S3 encrypts data with
/// server-side encryption
/// using Amazon S3 managed keys (SSE-S3) by default. You can optionally tell
/// Amazon S3 to encrypt data at
/// rest using server-side encryption with other key options. The option you use
/// depends on
/// whether you want to use KMS keys (SSE-KMS) or provide your own encryption
/// key
/// (SSE-C).
///
/// Server-side encryption is supported by the S3 Multipart Upload operations.
/// Unless you are
/// using a customer-provided encryption key (SSE-C), you don't need to specify
/// the encryption
/// parameters in each UploadPart request. Instead, you only need to specify the
/// server-side
/// encryption parameters in the initial Initiate Multipart request. For more
/// information, see
/// [CreateMultipartUpload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html).
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
/// If you request server-side encryption using a customer-provided encryption
/// key (SSE-C) in
/// your initiate multipart upload request, you must provide identical
/// encryption information in
/// each part upload using the following request headers.
///
/// * x-amz-server-side-encryption-customer-algorithm
///
/// * x-amz-server-side-encryption-customer-key
///
/// * x-amz-server-side-encryption-customer-key-MD5
///
/// For more information, see [Using Server-Side
/// Encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingServerSideEncryption.html) in the *Amazon S3 User Guide*.
///
/// * **Directory buckets ** -
/// For directory buckets, there are only two supported options for server-side
/// encryption: server-side encryption with Amazon S3 managed keys (SSE-S3)
/// (`AES256`) and server-side encryption with KMS keys (SSE-KMS) (`aws:kms`).
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
/// * SOAP Fault Code Prefix: Client
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// The following operations are related to `UploadPart`:
///
/// *
///   [CreateMultipartUpload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html)
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
pub const UploadPartInput = struct {
    /// Object data.
    body: ?[]const u8 = null,

    /// The name of the bucket to which the multipart upload was initiated.
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

    /// Indicates the algorithm used to create the checksum for the object when you
    /// use the SDK. This header will not provide any
    /// additional functionality if you don't use the SDK. When you send this
    /// header, there must be a corresponding `x-amz-checksum` or
    /// `x-amz-trailer` header sent. Otherwise, Amazon S3 fails the request with the
    /// HTTP status code `400 Bad Request`. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// If you provide an individual checksum, Amazon S3 ignores any provided
    /// `ChecksumAlgorithm`
    /// parameter.
    ///
    /// This checksum algorithm must be the same for all parts and it match the
    /// checksum value supplied in
    /// the `CreateMultipartUpload` request.
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
    /// checksum of the part. For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
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

    /// Size of the body in bytes. This parameter is useful when the size of the
    /// body cannot be determined
    /// automatically.
    content_length: ?i64 = null,

    /// The Base64 encoded 128-bit MD5 digest of the part data. This parameter is
    /// auto-populated when using
    /// the command from the CLI. This parameter is required if object lock
    /// parameters are specified.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    content_md5: ?[]const u8 = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// Object key for which the multipart upload was initiated.
    key: []const u8,

    /// Part number of part being uploaded. This is a positive integer between 1 and
    /// 10,000.
    part_number: i32,

    request_payer: ?RequestPayer = null,

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
    /// `x-amz-server-side-encryption-customer-algorithm header`. This must be the
    /// same encryption
    /// key specified in the initiate multipart upload request.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key: ?[]const u8 = null,

    /// Specifies the 128-bit MD5 digest of the encryption key according to RFC
    /// 1321. Amazon S3 uses this header
    /// for a message integrity check to ensure that the encryption key was
    /// transmitted without error.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key_md5: ?[]const u8 = null,

    /// Upload ID identifying the multipart upload whose part is being uploaded.
    upload_id: []const u8,
};

pub const UploadPartOutput = struct {
    /// Indicates whether the multipart upload uses an S3 Bucket Key for server-side
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

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data
    /// that was originally sent. This header specifies the Base64 encoded, 64-bit
    /// `CRC64NVME`
    /// checksum of the part. For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
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

    /// Entity tag for the uploaded object.
    e_tag: ?[]const u8 = null,

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

    pub fn deinit(self: *UploadPartOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: UploadPartInput, options: Options) !UploadPartOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UploadPartInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "x-id=UploadPart");
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

    const body = input.body orelse "";

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
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
    if (input.content_length) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "Content-Length", num_str);
        }
    }
    if (input.content_md5) |v| {
        try request.headers.put(alloc, "Content-MD5", v);
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UploadPartOutput {
    var result: UploadPartOutput = .{};
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
    if (headers.get("etag")) |value| {
        result.e_tag = try alloc.dupe(u8, value);
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
