const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
        if (self.payload) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .content_type = "ContentType",
        .payload = "Payload",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetClipInput, options: CallOptions) !GetClipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisvideo", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetClipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video Archived Media", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/getClip";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClipFragmentSelector\":");
    try aws.json.writeValue(@TypeOf(input.clip_fragment_selector), input.clip_fragment_selector, allocator, &body_buf);
    has_prev = true;
    if (input.stream_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetClipOutput {
    var result: GetClipOutput = .{};
    result.payload = stream_resp.body;
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    stream_resp.deinitHeaders();

    return result;
}
