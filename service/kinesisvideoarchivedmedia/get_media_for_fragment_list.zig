const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMediaForFragmentListInput, options: CallOptions) !GetMediaForFragmentListOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisvideo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMediaForFragmentListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video Archived Media", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/getMediaForFragmentList";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Fragments\":");
    try aws.json.writeValue(@TypeOf(input.fragments), input.fragments, allocator, &body_buf);
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

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetMediaForFragmentListOutput {
    var result: GetMediaForFragmentListOutput = .{};
    errdefer {
        if (result.content_type) |value| allocator.free(value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    result.payload = stream_resp.body;
    stream_resp.deinitHeaders();

    return result;
}
