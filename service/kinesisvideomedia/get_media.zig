const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const StartSelector = @import("start_selector.zig").StartSelector;

pub const GetMediaInput = struct {
    /// Identifies the starting chunk to get from the specified stream.
    start_selector: StartSelector,

    /// The ARN of the stream from where you want to get the media content. If you
    /// don't
    /// specify the `streamARN`, you must specify the `streamName`.
    stream_arn: ?[]const u8 = null,

    /// The Kinesis video stream name from where you want to get the media content.
    /// If you
    /// don't specify the `streamName`, you must specify the
    /// `streamARN`.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .start_selector = "StartSelector",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const GetMediaOutput = struct {
    /// The content type of the requested media.
    content_type: ?[]const u8 = null,

    /// The payload Kinesis Video Streams returns is a sequence of chunks from the
    /// specified
    /// stream. For information about the chunks, see . The
    /// chunks that Kinesis Video Streams returns in the `GetMedia` call also
    /// include the
    /// following additional Matroska (MKV) tags:
    ///
    /// * AWS_KINESISVIDEO_CONTINUATION_TOKEN (UTF-8 string) - In the event your
    /// `GetMedia` call terminates, you can use this continuation token in your next
    /// request to get the next chunk where the last request terminated.
    ///
    /// * AWS_KINESISVIDEO_MILLIS_BEHIND_NOW (UTF-8 string) - Client applications
    ///   can use
    /// this tag value to determine how far behind the chunk returned in the
    /// response is from the
    /// latest chunk on the stream.
    ///
    /// * AWS_KINESISVIDEO_FRAGMENT_NUMBER - Fragment number returned in the chunk.
    ///
    /// * AWS_KINESISVIDEO_SERVER_TIMESTAMP - Server timestamp of the fragment.
    ///
    /// * AWS_KINESISVIDEO_PRODUCER_TIMESTAMP - Producer timestamp of the fragment.
    ///
    /// The following tags will be present if an error occurs:
    ///
    /// * AWS_KINESISVIDEO_ERROR_CODE - String description of an error that caused
    ///   GetMedia
    /// to stop.
    ///
    /// * AWS_KINESISVIDEO_ERROR_ID: Integer code of the error.
    ///
    /// The error codes are as follows:
    ///
    /// * 3002 - Error writing to the stream
    ///
    /// * 4000 - Requested fragment is not found
    ///
    /// * 4500 - Access denied for the stream's KMS key
    ///
    /// * 4501 - Stream's KMS key is disabled
    ///
    /// * 4502 - Validation error on the stream's KMS key
    ///
    /// * 4503 - KMS key specified in the stream is unavailable
    ///
    /// * 4504 - Invalid usage of the KMS key specified in the stream
    ///
    /// * 4505 - Invalid state of the KMS key specified in the stream
    ///
    /// * 4506 - Unable to find the KMS key specified in the stream
    ///
    /// * 5000 - Internal error
    payload: ?aws.http.StreamingBody = null,

    pub fn deinit(self: *GetMediaOutput) void {
        self.payload.deinit();
    }

    pub const json_field_names = .{
        .content_type = "ContentType",
        .payload = "Payload",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMediaInput, options: Options) !GetMediaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kinesisvideomedia");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(error_body, stream_resp.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(&stream_resp, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetMediaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideomedia", "Kinesis Video Media", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/getMedia";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"StartSelector\":");
    try aws.json.writeValue(@TypeOf(input.start_selector), input.start_selector, alloc, &body_buf);
    has_prev = true;
    if (input.stream_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"StreamARN\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.stream_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"StreamName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !GetMediaOutput {
    var result: GetMediaOutput = .{};
    result.payload = stream_resp.body;
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try alloc.dupe(u8, value);
    }
    stream_resp.deinitHeaders();

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ClientLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .client_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConnectionLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .connection_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointException")) {
        return .{ .arena = arena, .kind = .{ .invalid_endpoint_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
