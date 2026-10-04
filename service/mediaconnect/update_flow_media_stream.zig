const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaStreamAttributesRequest = @import("media_stream_attributes_request.zig").MediaStreamAttributesRequest;
const MediaStreamType = @import("media_stream_type.zig").MediaStreamType;
const MediaStream = @import("media_stream.zig").MediaStream;

pub const UpdateFlowMediaStreamInput = struct {
    /// The attributes that you want to assign to the media stream.
    attributes: ?MediaStreamAttributesRequest = null,

    /// The sample rate for the stream. This value in measured in kHz.
    clock_rate: ?i32 = null,

    /// A description that can help you quickly identify what your media stream is
    /// used for.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the flow that is associated with the media
    /// stream that you updated.
    flow_arn: []const u8,

    /// The media stream that you updated.
    media_stream_name: []const u8,

    /// The type of media stream.
    media_stream_type: ?MediaStreamType = null,

    /// The resolution of the video.
    video_format: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .clock_rate = "ClockRate",
        .description = "Description",
        .flow_arn = "FlowArn",
        .media_stream_name = "MediaStreamName",
        .media_stream_type = "MediaStreamType",
        .video_format = "VideoFormat",
    };
};

pub const UpdateFlowMediaStreamOutput = struct {
    /// The ARN of the flow that is associated with the media stream that you
    /// updated.
    flow_arn: ?[]const u8 = null,

    /// The media stream that you updated.
    media_stream: ?MediaStream = null,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .media_stream = "MediaStream",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFlowMediaStreamInput, options: CallOptions) !UpdateFlowMediaStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFlowMediaStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/flows/");
    try path_buf.appendSlice(allocator, input.flow_arn);
    try path_buf.appendSlice(allocator, "/mediaStreams/");
    try path_buf.appendSlice(allocator, input.media_stream_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.clock_rate) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClockRate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.media_stream_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MediaStreamType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.video_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VideoFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFlowMediaStreamOutput {
    const result: UpdateFlowMediaStreamOutput = try aws.json.parseJsonObject(
        UpdateFlowMediaStreamOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
