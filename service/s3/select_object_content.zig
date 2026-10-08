const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    payload: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *SelectObjectContentOutput) void {
        self.payload.deinit();
    }
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SelectObjectContentInput, options: CallOptions) !SelectObjectContentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    errdefer stream_resp.deinit();
    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: SelectObjectContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.key);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "select&select-type=2");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<SelectObjectContentRequest xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
    try body_buf.appendSlice(allocator, "<Expression>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.expression);
    try body_buf.appendSlice(allocator, "</Expression>");
    try body_buf.appendSlice(allocator, "<ExpressionType>");
    try body_buf.appendSlice(allocator, input.expression_type.wireName());
    try body_buf.appendSlice(allocator, "</ExpressionType>");
    try body_buf.appendSlice(allocator, "<InputSerialization>");
    try serde.serializeInputSerialization(allocator, &body_buf, input.input_serialization);
    try body_buf.appendSlice(allocator, "</InputSerialization>");
    try body_buf.appendSlice(allocator, "<OutputSerialization>");
    try serde.serializeOutputSerialization(allocator, &body_buf, input.output_serialization);
    try body_buf.appendSlice(allocator, "</OutputSerialization>");
    if (input.request_progress) |v| {
        try body_buf.appendSlice(allocator, "<RequestProgress>");
        try serde.serializeRequestProgress(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</RequestProgress>");
    }
    if (input.scan_range) |v| {
        try body_buf.appendSlice(allocator, "<ScanRange>");
        try serde.serializeScanRange(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</ScanRange>");
    }
    try body_buf.appendSlice(allocator, "</SelectObjectContentRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
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

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !SelectObjectContentOutput {
    var result: SelectObjectContentOutput = .{};
    result.payload = try aws.event_stream_reader.EventStreamReader.init(
        allocator,
        stream_resp.body,
    );
    stream_resp.deinitHeaders();

    return result;
}
