const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExpressionType = @import("expression_type.zig").ExpressionType;
const InputSerialization = @import("input_serialization.zig").InputSerialization;
const OutputSerialization = @import("output_serialization.zig").OutputSerialization;
const RequestProgress = @import("request_progress.zig").RequestProgress;
const ScanRange = @import("scan_range.zig").ScanRange;
const SelectObjectContentEventStream = @import("select_object_content_event_stream.zig").SelectObjectContentEventStream;

/// **Note:**
///
/// This operation is not supported for directory buckets.
///
/// This action filters the contents of an Amazon S3 object based on a simple
/// structured query language (SQL)
/// statement. In the request, along with the SQL expression, you must also
/// specify a data serialization
/// format (JSON, CSV, or Apache Parquet) of the object. Amazon S3 uses this
/// format to parse object data into
/// records, and returns only records that match the specified SQL expression.
/// You must also specify the
/// data serialization format for the response.
///
/// This functionality is not supported for Amazon S3 on Outposts.
///
/// For more information about Amazon S3 Select, see [Selecting Content from
/// Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/selecting-content-from-objects.html)
/// and [SELECT
/// Command](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-glacier-select-sql-reference-select.html) in
/// the *Amazon S3 User Guide*.
///
/// **Permissions**
///
/// You must have the `s3:GetObject` permission for this operation. Amazon S3
/// Select does
/// not support anonymous access. For more information about permissions, see
/// [Specifying Permissions
/// in a
/// Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html) in the *Amazon S3 User Guide*.
///
/// **Object Data Formats**
///
/// You can use Amazon S3 Select to query objects that have the following format
/// properties:
///
/// * *CSV, JSON, and Parquet* - Objects must be in CSV, JSON, or Parquet
/// format.
///
/// * *UTF-8* - UTF-8 is the only encoding type Amazon S3 Select supports.
///
/// * *GZIP or BZIP2* - CSV and JSON files can be compressed using GZIP or
/// BZIP2. GZIP and BZIP2 are the only compression formats that Amazon S3 Select
/// supports for CSV and
/// JSON files. Amazon S3 Select supports columnar compression for Parquet using
/// GZIP or Snappy. Amazon S3
/// Select does not support whole-object compression for Parquet objects.
///
/// * *Server-side encryption* - Amazon S3 Select supports querying objects that
/// are protected with server-side encryption.
///
/// For objects that are encrypted with customer-provided encryption keys
/// (SSE-C), you must
/// use HTTPS, and you must use the headers that are documented in the
/// [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html). For more information about
/// SSE-C, see [Server-Side Encryption
/// (Using Customer-Provided Encryption
/// Keys)](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the
/// *Amazon S3 User Guide*.
///
/// For objects that are encrypted with Amazon S3 managed keys (SSE-S3) and
/// Amazon Web Services KMS keys
/// (SSE-KMS), server-side encryption is handled transparently, so you don't
/// need to specify
/// anything. For more information about server-side encryption, including
/// SSE-S3 and SSE-KMS, see
/// [Protecting
/// Data Using Server-Side
/// Encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html) in the
/// *Amazon S3 User Guide*.
///
/// **Working with the Response Body**
///
/// Given the response size is unknown, Amazon S3 Select streams the response as
/// a series of messages
/// and includes a `Transfer-Encoding` header with `chunked` as its value in the
/// response. For more information, see [Appendix: SelectObjectContent
/// Response](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTSelectObjectAppendix.html).
///
/// **GetObject Support**
///
/// The `SelectObjectContent` action does not support the following
/// `GetObject` functionality. For more information, see
/// [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html).
///
/// * `Range`: Although you can specify a scan range for an Amazon S3 Select
///   request (see
/// [SelectObjectContentRequest -
/// ScanRange](https://docs.aws.amazon.com/AmazonS3/latest/API/API_SelectObjectContent.html#AmazonS3-SelectObjectContent-request-ScanRange) in the request parameters), you
/// cannot specify the range of bytes of an object to return.
///
/// * The `GLACIER`, `DEEP_ARCHIVE`, and `REDUCED_REDUNDANCY`
/// storage classes, or the `ARCHIVE_ACCESS` and `DEEP_ARCHIVE_ACCESS`
/// access tiers of the `INTELLIGENT_TIERING` storage class: You cannot query
/// objects
/// in the `GLACIER`, `DEEP_ARCHIVE`, or `REDUCED_REDUNDANCY`
/// storage classes, nor objects in the `ARCHIVE_ACCESS` or
/// `DEEP_ARCHIVE_ACCESS` access tiers of the `INTELLIGENT_TIERING`
/// storage class. For more information about storage classes, see [Using Amazon
/// S3 storage
/// classes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html)
/// in the *Amazon S3 User Guide*.
///
/// **Special Errors**
///
/// For a list of special errors for this operation, see [List of SELECT
/// Object Content Error
/// Codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#SelectObjectContentErrorCodeList)
///
/// The following operations are related to `SelectObjectContent`:
///
/// *
///   [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html)
///
/// *
///   [GetBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html)
///
/// *
///   [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const SelectObjectContentInput = struct {
    /// The S3 bucket.
    bucket: []const u8,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The expression that is used to query the object.
    expression: []const u8,

    /// The type of the provided expression (for example, SQL).
    expression_type: ExpressionType,

    /// Describes the format of the data in the object that is being queried.
    input_serialization: InputSerialization,

    /// The object key.
    key: []const u8,

    /// Describes the format of the data that you want Amazon S3 to return in
    /// response.
    output_serialization: OutputSerialization,

    /// Specifies if periodic request progress information should be enabled.
    request_progress: ?RequestProgress = null,

    /// Specifies the byte range of the object to get the records from. A record is
    /// processed when its first
    /// byte is contained by the range. This parameter is optional, but when
    /// specified, it must not be empty.
    /// See RFC 2616, Section 14.35.1 about how to specify the start and end of the
    /// range.
    ///
    /// `ScanRange`may be used in the following ways:
    ///
    /// * `50100`
    /// - process only the records starting between the bytes 50 and 100 (inclusive,
    /// counting from
    /// zero)
    ///
    /// * `50` - process only the
    /// records starting after the byte 50
    ///
    /// * `50` - process only the
    /// records within the last 50 bytes of the file.
    scan_range: ?ScanRange = null,

    /// The server-side encryption (SSE) algorithm used to encrypt the object. This
    /// parameter is needed only when the object was created
    /// using a checksum algorithm. For more information,
    /// see [Protecting data using SSE-C
    /// keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the
    /// *Amazon S3 User Guide*.
    sse_customer_algorithm: ?[]const u8 = null,

    /// The server-side encryption (SSE) customer managed key. This parameter is
    /// needed only when the object was created using a checksum algorithm.
    /// For more information, see
    /// [Protecting data using SSE-C
    /// keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the
    /// *Amazon S3 User Guide*.
    sse_customer_key: ?[]const u8 = null,

    /// The MD5 server-side encryption (SSE) customer managed key. This parameter is
    /// needed only when the object was created using a checksum
    /// algorithm. For more information,
    /// see [Protecting data using SSE-C
    /// keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the
    /// *Amazon S3 User Guide*.
    sse_customer_key_md5: ?[]const u8 = null,
};

pub const SelectObjectContentOutput = struct {
    /// The array of results.
    payload: ?SelectObjectContentEventStream = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const SelectObjectContentOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: SelectObjectContentInput, options: Options) !SelectObjectContentOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: SelectObjectContentInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "select&select-type=2");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(alloc, "<SelectObjectContentRequest>");
    try body_buf.appendSlice(alloc, "<Expression>");
    try appendXmlEscaped(alloc, &body_buf, input.expression);
    try body_buf.appendSlice(alloc, "</Expression>");
    try body_buf.appendSlice(alloc, "</SelectObjectContentRequest>");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !SelectObjectContentOutput {
    _ = body;
    _ = status;
    const result: SelectObjectContentOutput = .{ .allocator = alloc };

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
