const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const CopyPartResult = @import("copy_part_result.zig").CopyPartResult;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const serde = @import("serde.zig");

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
    /// This functionality is not supported when the source object is in a directory
    /// bucket.
    copy_source_sse_customer_algorithm: ?[]const u8 = null,

    /// Specifies the customer-provided encryption key for Amazon S3 to use to
    /// decrypt the source object. The
    /// encryption key provided in this header must be one that was used when the
    /// source object was
    /// created.
    ///
    /// This functionality is not supported when the source object is in a directory
    /// bucket.
    copy_source_sse_customer_key: ?[]const u8 = null,

    /// Specifies the 128-bit MD5 digest of the encryption key according to RFC
    /// 1321. Amazon S3 uses this header
    /// for a message integrity check to ensure that the encryption key was
    /// transmitted without error.
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
    /// This functionality is not supported when the source object is in a directory
    /// bucket.
    copy_source_version_id: ?[]const u8 = null,

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

    /// If present, indicates the ID of the KMS key that was used for object
    /// encryption.
    ssekms_key_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UploadPartCopyInput, options: CallOptions) !UploadPartCopyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: UploadPartCopyInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(allocator, "x-id=UploadPartCopy");
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "partNumber=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.part_number}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "uploadId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.upload_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
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
    if (input.copy_source_range) |v| {
        try request.headers.put(allocator, "x-amz-copy-source-range", v);
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
    if (input.request_payer) |v| {
        try request.headers.put(allocator, "x-amz-request-payer", v.wireName());
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UploadPartCopyOutput {
    var result: UploadPartCopyOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("x-amz-server-side-encryption-bucket-key-enabled")) |value| {
        result.bucket_key_enabled = std.mem.eql(u8, value, "true");
    }
    if (headers.get("x-amz-copy-source-version-id")) |value| {
        result.copy_source_version_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = RequestCharged.fromWireName(value);
    }
    if (headers.get("x-amz-server-side-encryption")) |value| {
        result.server_side_encryption = ServerSideEncryption.fromWireName(value);
    }
    if (headers.get("x-amz-server-side-encryption-customer-algorithm")) |value| {
        result.sse_customer_algorithm = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-customer-key-md5")) |value| {
        result.sse_customer_key_md5 = try allocator.dupe(u8, value);
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
