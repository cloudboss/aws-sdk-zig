const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetMediaForFragmentListInput = struct {
    /// A list of the numbers of fragments for which to retrieve media. You retrieve
    /// these
    /// values with ListFragments.
    fragments: []const []const u8,

    /// The Amazon Resource Name (ARN) of the stream from which to retrieve fragment
    /// media. Specify either this parameter or the `StreamName` parameter.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream from which to retrieve fragment media. Specify either
    /// this parameter or the `StreamARN` parameter.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .fragments = "Fragments",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const GetMediaForFragmentListOutput = struct {
    /// The content type of the requested media.
    content_type: ?[]const u8 = null,

    /// The payload that Kinesis Video Streams returns is a sequence of chunks from
    /// the
    /// specified stream. For information about the chunks, see
    /// [PutMedia](http://docs.aws.amazon.com/kinesisvideostreams/latest/dg/API_dataplane_PutMedia.html). The chunks that Kinesis Video Streams returns in the
    /// `GetMediaForFragmentList` call also include the following additional
    /// Matroska (MKV) tags:
    ///
    /// * AWS_KINESISVIDEO_FRAGMENT_NUMBER - Fragment number returned in the
    /// chunk.
    ///
    /// * AWS_KINESISVIDEO_SERVER_SIDE_TIMESTAMP - Server-side timestamp of the
    /// fragment.
    ///
    /// * AWS_KINESISVIDEO_PRODUCER_SIDE_TIMESTAMP - Producer-side timestamp of the
    /// fragment.
    ///
    /// The following tags will be included if an exception occurs:
    ///
    /// * AWS_KINESISVIDEO_FRAGMENT_NUMBER - The number of the fragment that threw
    ///   the exception
    ///
    /// * AWS_KINESISVIDEO_EXCEPTION_ERROR_CODE - The integer code of the
    ///
    /// * AWS_KINESISVIDEO_EXCEPTION_MESSAGE - A text description of the exception
    payload: ?aws.http.StreamingBody = null,

    pub fn deinit(self: *GetMediaForFragmentListOutput) void {
        if (self.payload) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .content_type = "ContentType",
        .payload = "Payload",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMediaForFragmentListInput, options: Options) !GetMediaForFragmentListOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetMediaForFragmentListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideoarchivedmedia", "Kinesis Video Archived Media", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/getMediaForFragmentList";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Fragments\":");
    try aws.json.writeValue(@TypeOf(input.fragments), input.fragments, alloc, &body_buf);
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

fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !GetMediaForFragmentListOutput {
    var result: GetMediaForFragmentListOutput = .{};
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
