const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddMediaStreamRequest = @import("add_media_stream_request.zig").AddMediaStreamRequest;
const MediaStream = @import("media_stream.zig").MediaStream;

pub const AddFlowMediaStreamsInput = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    flow_arn: []const u8,

    /// The media streams that you want to add to the flow.
    media_streams: []const AddMediaStreamRequest,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .media_streams = "MediaStreams",
    };
};

pub const AddFlowMediaStreamsOutput = struct {
    /// The ARN of the flow that you added media streams to.
    flow_arn: ?[]const u8 = null,

    /// The media streams that you added to the flow.
    media_streams: ?[]const MediaStream = null,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .media_streams = "MediaStreams",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddFlowMediaStreamsInput, options: CallOptions) !AddFlowMediaStreamsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddFlowMediaStreamsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/flows/");
    try path_buf.appendSlice(allocator, input.flow_arn);
    try path_buf.appendSlice(allocator, "/mediaStreams");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MediaStreams\":");
    try aws.json.writeValue(@TypeOf(input.media_streams), input.media_streams, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddFlowMediaStreamsOutput {
    var result: AddFlowMediaStreamsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AddFlowMediaStreamsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
