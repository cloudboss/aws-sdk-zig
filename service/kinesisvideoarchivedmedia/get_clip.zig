const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ClipFragmentSelector = @import("clip_fragment_selector.zig").ClipFragmentSelector;

pub const GetClipInput = struct {
    /// The time range of the requested clip and the source of the timestamps.
    clip_fragment_selector: ClipFragmentSelector,

    /// The Amazon Resource Name (ARN) of the stream for which to retrieve the media
    /// clip.
    ///
    /// You must specify either the StreamName or the StreamARN.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream for which to retrieve the media clip.
    ///
    /// You must specify either the StreamName or the StreamARN.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .clip_fragment_selector = "ClipFragmentSelector",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const GetClipOutput = struct {
    /// The content type of the media in the requested clip.
    content_type: ?[]const u8 = null,

    /// Traditional MP4 file that contains the media clip from the specified video
    /// stream. The
    /// output will contain the first 100 MB or the first 200 fragments from the
    /// specified start
    /// timestamp. For more information, see [Kinesis
    /// Video Streams
    /// Limits](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/limits.html).
    payload: ?aws.http.StreamingBody = null,

    pub fn deinit(self: *GetClipOutput) void {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetClipInput, options: Options) !GetClipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kinesisvideoarchivedmedia");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetClipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideoarchivedmedia", "Kinesis Video Archived Media", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/getClip";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ClipFragmentSelector\":");
    try aws.json.writeValue(@TypeOf(input.clip_fragment_selector), input.clip_fragment_selector, alloc, &body_buf);
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

fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !GetClipOutput {
    var result: GetClipOutput = .{};
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
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodecPrivateDataException")) {
        return .{ .arena = arena, .kind = .{ .invalid_codec_private_data_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMediaFrameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_media_frame_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingCodecPrivateDataException")) {
        return .{ .arena = arena, .kind = .{ .missing_codec_private_data_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoDataRetentionException")) {
        return .{ .arena = arena, .kind = .{ .no_data_retention_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedStreamMediaTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_stream_media_type_exception = .{
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
