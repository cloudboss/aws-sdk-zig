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
const serde = @import("serde.zig");

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
    metadata: ?[]const aws.map.StringMapEntry = null,

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: WriteGetObjectResponseInput, options: Options) !WriteGetObjectResponseOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: WriteGetObjectResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
