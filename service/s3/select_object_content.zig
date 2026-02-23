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
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SelectObjectContentInput, options: Options) !SelectObjectContentOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: SelectObjectContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", alloc);

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
    try query_buf.appendSlice(alloc, "select&select-type=2");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(alloc, "<SelectObjectContentRequest>");
    try body_buf.appendSlice(alloc, "<Expression>");
    try aws.xml.appendXmlEscaped(alloc, &body_buf, input.expression);
    try body_buf.appendSlice(alloc, "</Expression>");
    try body_buf.appendSlice(alloc, "<InputSerialization>");
    try serde.serializeInputSerialization(alloc, &body_buf, input.input_serialization);
    try body_buf.appendSlice(alloc, "</InputSerialization>");
    try body_buf.appendSlice(alloc, "<OutputSerialization>");
    try serde.serializeOutputSerialization(alloc, &body_buf, input.output_serialization);
    try body_buf.appendSlice(alloc, "</OutputSerialization>");
    if (input.request_progress) |v| {
        try body_buf.appendSlice(alloc, "<RequestProgress>");
        try serde.serializeRequestProgress(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "</RequestProgress>");
    }
    if (input.scan_range) |v| {
        try body_buf.appendSlice(alloc, "<ScanRange>");
        try serde.serializeScanRange(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "</ScanRange>");
    }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !SelectObjectContentOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: SelectObjectContentOutput = .{};

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
