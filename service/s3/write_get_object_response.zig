const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ObjectLockLegalHoldStatus = @import("object_lock_legal_hold_status.zig").ObjectLockLegalHoldStatus;
const ObjectLockMode = @import("object_lock_mode.zig").ObjectLockMode;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const StorageClass = @import("storage_class.zig").StorageClass;

/// **Note:**
///
/// This operation is not supported for directory buckets.
///
/// Passes transformed objects to a `GetObject` operation when using Object
/// Lambda access points. For information
/// about Object Lambda access points, see [Transforming objects with Object
/// Lambda access
/// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/transforming-objects.html) in the *Amazon S3 User Guide*.
///
/// This operation supports metadata that can be returned by
/// [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html), in addition to
/// `RequestRoute`, `RequestToken`, `StatusCode`, `ErrorCode`,
/// and `ErrorMessage`. The `GetObject` response metadata is supported so that
/// the
/// `WriteGetObjectResponse` caller, typically an Lambda function, can provide
/// the same
/// metadata when it internally invokes `GetObject`. When
/// `WriteGetObjectResponse` is
/// called by a customer-owned Lambda function, the metadata returned to the end
/// user `GetObject`
/// call might differ from what Amazon S3 would normally return.
///
/// You can include any number of metadata headers. When including a metadata
/// header, it should be
/// prefaced with `x-amz-meta`. For example, `x-amz-meta-my-custom-header:
/// MyCustomValue`. The primary use case for this is to forward `GetObject`
/// metadata.
///
/// Amazon Web Services provides some prebuilt Lambda functions that you can use
/// with S3 Object Lambda to detect and
/// redact personally identifiable information (PII) and decompress S3 objects.
/// These Lambda functions are
/// available in the Amazon Web Services Serverless Application Repository, and
/// can be selected through the Amazon Web Services
/// Management Console when you create your Object Lambda access point.
///
/// Example 1: PII Access Control - This Lambda function uses Amazon Comprehend,
/// a natural
/// language processing (NLP) service using machine learning to find insights
/// and relationships in text. It
/// automatically detects personally identifiable information (PII) such as
/// names, addresses, dates, credit
/// card numbers, and social security numbers from documents in your Amazon S3
/// bucket.
///
/// Example 2: PII Redaction - This Lambda function uses Amazon Comprehend, a
/// natural language
/// processing (NLP) service using machine learning to find insights and
/// relationships in text. It
/// automatically redacts personally identifiable information (PII) such as
/// names, addresses, dates, credit
/// card numbers, and social security numbers from documents in your Amazon S3
/// bucket.
///
/// Example 3: Decompression - The Lambda function S3ObjectLambdaDecompression,
/// is equipped to
/// decompress objects stored in S3 in one of six compressed file formats
/// including bzip2, gzip, snappy,
/// zlib, zstandard and ZIP.
///
/// For information on how to view and use these functions, see [Using Amazon
/// Web Services built Lambda
/// functions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/olap-examples.html) in the
/// *Amazon S3 User Guide*.
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const WriteGetObjectResponseInput = struct {
    /// Indicates that a range of bytes was specified.
    accept_ranges: ?[]const u8 = null,

    /// The object data.
    body: ?[]const u8 = null,

    /// Indicates whether the object stored in Amazon S3 uses an S3 bucket key for
    /// server-side encryption with
    /// Amazon Web Services KMS (SSE-KMS).
    bucket_key_enabled: ?bool = null,

    /// Specifies caching behavior along the request/reply chain.
    cache_control: ?[]const u8 = null,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data
    /// that was originally sent. This specifies the Base64 encoded, 32-bit `CRC32`
    /// checksum of the
    /// object returned by the Object Lambda function. This may not match the
    /// checksum for the object stored in
    /// Amazon S3. Amazon S3 will perform validation of the checksum values only
    /// when the original `GetObject`
    /// request required checksum validation. For more information about checksums,
    /// see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    ///
    /// Only one checksum header can be specified at a time. If you supply multiple
    /// checksum headers, this
    /// request will fail.
    checksum_crc32: ?[]const u8 = null,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data
    /// that was originally sent. This specifies the Base64 encoded, 32-bit `CRC32C`
    /// checksum of the
    /// object returned by the Object Lambda function. This may not match the
    /// checksum for the object stored in
    /// Amazon S3. Amazon S3 will perform validation of the checksum values only
    /// when the original `GetObject`
    /// request required checksum validation. For more information about checksums,
    /// see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    ///
    /// Only one checksum header can be specified at a time. If you supply multiple
    /// checksum headers, this
    /// request will fail.
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
    /// received is the same data
    /// that was originally sent. This specifies the Base64 encoded, 160-bit `SHA1`
    /// digest of the
    /// object returned by the Object Lambda function. This may not match the
    /// checksum for the object stored in
    /// Amazon S3. Amazon S3 will perform validation of the checksum values only
    /// when the original `GetObject`
    /// request required checksum validation. For more information about checksums,
    /// see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    ///
    /// Only one checksum header can be specified at a time. If you supply multiple
    /// checksum headers, this
    /// request will fail.
    checksum_sha1: ?[]const u8 = null,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data
    /// that was originally sent. This specifies the Base64 encoded, 256-bit
    /// `SHA256` digest of the
    /// object returned by the Object Lambda function. This may not match the
    /// checksum for the object stored in
    /// Amazon S3. Amazon S3 will perform validation of the checksum values only
    /// when the original `GetObject`
    /// request required checksum validation. For more information about checksums,
    /// see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    ///
    /// Only one checksum header can be specified at a time. If you supply multiple
    /// checksum headers, this
    /// request will fail.
    checksum_sha256: ?[]const u8 = null,

    /// Specifies presentational information for the object.
    content_disposition: ?[]const u8 = null,

    /// Specifies what content encodings have been applied to the object and thus
    /// what decoding mechanisms
    /// must be applied to obtain the media-type referenced by the Content-Type
    /// header field.
    content_encoding: ?[]const u8 = null,

    /// The language the content is in.
    content_language: ?[]const u8 = null,

    /// The size of the content body in bytes.
    content_length: ?i64 = null,

    /// The portion of the object returned in the response.
    content_range: ?[]const u8 = null,

    /// A standard MIME type describing the format of the object data.
    content_type: ?[]const u8 = null,

    /// Specifies whether an object stored in Amazon S3 is (`true`) or is not
    /// (`false`) a
    /// delete marker. To learn more about delete markers, see [Working with delete
    /// markers](https://docs.aws.amazon.com/AmazonS3/latest/userguide/DeleteMarker.html).
    delete_marker: ?bool = null,

    /// A string that uniquely identifies an error condition. Returned in the tag of
    /// the error
    /// XML response for a corresponding `GetObject` call. Cannot be used with a
    /// successful
    /// `StatusCode` header or when the transformed object is provided in the body.
    /// All error codes
    /// from S3 are sentence-cased. The regular expression (regex) value is
    /// `"^[A-Z][a-zA-Z]+$"`.
    error_code: ?[]const u8 = null,

    /// Contains a generic description of the error condition. Returned in the tag
    /// of the
    /// error XML response for a corresponding `GetObject` call. Cannot be used with
    /// a successful
    /// `StatusCode` header or when the transformed object is provided in body.
    error_message: ?[]const u8 = null,

    /// An opaque identifier assigned by a web server to a specific version of a
    /// resource found at a URL.
    e_tag: ?[]const u8 = null,

    /// If the object expiration is configured (see PUT Bucket lifecycle), the
    /// response includes this
    /// header. It includes the `expiry-date` and `rule-id` key-value pairs that
    /// provide
    /// the object expiration information. The value of the `rule-id` is
    /// URL-encoded.
    expiration: ?[]const u8 = null,

    /// The date and time at which the object is no longer cacheable.
    expires: ?[]const u8 = null,

    /// The date and time that the object was last modified.
    last_modified: ?i64 = null,

    /// A map of metadata to store with the object in S3.
    metadata: ?[]const u8 = null,

    /// Set to the number of metadata entries not returned in `x-amz-meta` headers.
    /// This can
    /// happen if you create metadata using an API like SOAP that supports more
    /// flexible metadata than the REST
    /// API. For example, using SOAP, you can create metadata whose values are not
    /// legal HTTP headers.
    missing_meta: ?i32 = null,

    /// Indicates whether an object stored in Amazon S3 has an active legal hold.
    object_lock_legal_hold_status: ?ObjectLockLegalHoldStatus = null,

    /// Indicates whether an object stored in Amazon S3 has Object Lock enabled. For
    /// more information about S3
    /// Object Lock, see [Object
    /// Lock](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html).
    object_lock_mode: ?ObjectLockMode = null,

    /// The date and time when Object Lock is configured to expire.
    object_lock_retain_until_date: ?i64 = null,

    /// The count of parts this object has.
    parts_count: ?i32 = null,

    /// Indicates if request involves bucket that is either a source or destination
    /// in a Replication rule.
    /// For more information about S3 Replication, see
    /// [Replication](https://docs.aws.amazon.com/AmazonS3/latest/userguide/replication.html).
    replication_status: ?ReplicationStatus = null,

    request_charged: ?RequestCharged = null,

    /// Route prefix to the HTTP URL generated.
    request_route: []const u8,

    /// A single use encrypted token that maps `WriteGetObjectResponse` to the end
    /// user
    /// `GetObject` request.
    request_token: []const u8,

    /// Provides information about object restoration operation and expiration time
    /// of the restored object
    /// copy.
    restore: ?[]const u8 = null,

    /// The server-side encryption algorithm used when storing requested object in
    /// Amazon S3 or Amazon FSx.
    ///
    /// **Note:**
    ///
    /// When accessing data stored in Amazon FSx file systems using S3 access
    /// points, the only valid server side
    /// encryption option is `aws:fsx`.
    server_side_encryption: ?ServerSideEncryption = null,

    /// Encryption algorithm used if server-side encryption with a customer-provided
    /// encryption key was
    /// specified for object stored in Amazon S3.
    sse_customer_algorithm: ?[]const u8 = null,

    /// 128-bit MD5 digest of customer-provided encryption key used in Amazon S3 to
    /// encrypt data stored in S3.
    /// For more information, see [Protecting data using
    /// server-side encryption with customer-provided encryption keys
    /// (SSE-C)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/ServerSideEncryptionCustomerKeys.html).
    sse_customer_key_md5: ?[]const u8 = null,

    /// If present, specifies the ID (Key ID, Key ARN, or Key Alias) of the Amazon
    /// Web Services Key Management Service
    /// (Amazon Web Services KMS) symmetric encryption customer managed key that was
    /// used for stored in Amazon S3 object.
    ssekms_key_id: ?[]const u8 = null,

    /// The integer status code for an HTTP response of a corresponding `GetObject`
    /// request. The
    /// following is a list of status codes.
    ///
    /// * `200 - OK`
    ///
    /// * `206 - Partial Content`
    ///
    /// * `304 - Not Modified`
    ///
    /// * `400 - Bad Request`
    ///
    /// * `401 - Unauthorized`
    ///
    /// * `403 - Forbidden`
    ///
    /// * `404 - Not Found`
    ///
    /// * `405 - Method Not Allowed`
    ///
    /// * `409 - Conflict`
    ///
    /// * `411 - Length Required`
    ///
    /// * `412 - Precondition Failed`
    ///
    /// * `416 - Range Not Satisfiable`
    ///
    /// * `500 - Internal Server Error`
    ///
    /// * `503 - Service Unavailable`
    status_code: ?i32 = null,

    /// Provides storage class information of the object. Amazon S3 returns this
    /// header for all objects except
    /// for S3 Standard storage class objects.
    ///
    /// For more information, see [Storage
    /// Classes](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html).
    storage_class: ?StorageClass = null,

    /// The number of tags, if any, on the object.
    tag_count: ?i32 = null,

    /// An ID used to reference a specific version of the object.
    version_id: ?[]const u8 = null,
};

pub const WriteGetObjectResponseOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *WriteGetObjectResponseOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: WriteGetObjectResponseInput, options: Options) !WriteGetObjectResponseOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: WriteGetObjectResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("s3", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    const path = "/WriteGetObjectResponse";

    const body = input.body orelse "";

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.accept_ranges) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-accept-ranges", v);
    }
    if (input.bucket_key_enabled) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-server-side-encryption-bucket-key-enabled", if (v) "true" else "false");
    }
    if (input.cache_control) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-Cache-Control", v);
    }
    if (input.checksum_crc32) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-checksum-crc32", v);
    }
    if (input.checksum_crc32_c) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-checksum-crc32c", v);
    }
    if (input.checksum_crc64_nvme) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-checksum-crc64nvme", v);
    }
    if (input.checksum_sha1) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-checksum-sha1", v);
    }
    if (input.checksum_sha256) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-checksum-sha256", v);
    }
    if (input.content_disposition) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-Content-Disposition", v);
    }
    if (input.content_encoding) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-Content-Encoding", v);
    }
    if (input.content_language) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-Content-Language", v);
    }
    if (input.content_length) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "Content-Length", num_str);
        }
    }
    if (input.content_range) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-Content-Range", v);
    }
    if (input.content_type) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-Content-Type", v);
    }
    if (input.delete_marker) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-delete-marker", if (v) "true" else "false");
    }
    if (input.error_code) |v| {
        try request.headers.put(alloc, "x-amz-fwd-error-code", v);
    }
    if (input.error_message) |v| {
        try request.headers.put(alloc, "x-amz-fwd-error-message", v);
    }
    if (input.e_tag) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-ETag", v);
    }
    if (input.expiration) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-expiration", v);
    }
    if (input.expires) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-Expires", v);
    }
    if (input.last_modified) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-fwd-header-Last-Modified", num_str);
        }
    }
    if (input.missing_meta) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-fwd-header-x-amz-missing-meta", num_str);
        }
    }
    if (input.object_lock_legal_hold_status) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-object-lock-legal-hold", @tagName(v));
    }
    if (input.object_lock_mode) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-object-lock-mode", @tagName(v));
    }
    if (input.object_lock_retain_until_date) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-fwd-header-x-amz-object-lock-retain-until-date", num_str);
        }
    }
    if (input.parts_count) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-fwd-header-x-amz-mp-parts-count", num_str);
        }
    }
    if (input.replication_status) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-replication-status", @tagName(v));
    }
    if (input.request_charged) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-request-charged", @tagName(v));
    }
    try request.headers.put(alloc, "x-amz-request-route", input.request_route);
    try request.headers.put(alloc, "x-amz-request-token", input.request_token);
    if (input.restore) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-restore", v);
    }
    if (input.server_side_encryption) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-server-side-encryption", @tagName(v));
    }
    if (input.sse_customer_algorithm) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-server-side-encryption-customer-algorithm", v);
    }
    if (input.sse_customer_key_md5) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-server-side-encryption-customer-key-MD5", v);
    }
    if (input.ssekms_key_id) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-server-side-encryption-aws-kms-key-id", v);
    }
    if (input.status_code) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-fwd-status", num_str);
        }
    }
    if (input.storage_class) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-storage-class", @tagName(v));
    }
    if (input.tag_count) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-fwd-header-x-amz-tagging-count", num_str);
        }
    }
    if (input.version_id) |v| {
        try request.headers.put(alloc, "x-amz-fwd-header-x-amz-version-id", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !WriteGetObjectResponseOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: WriteGetObjectResponseOutput = .{};

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
