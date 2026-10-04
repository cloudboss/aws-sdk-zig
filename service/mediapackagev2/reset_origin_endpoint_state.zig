const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ResetOriginEndpointStateInput = struct {
    /// The name of the channel group that contains the channel with the origin
    /// endpoint that you are resetting.
    channel_group_name: []const u8,

    /// The name of the channel with the origin endpoint that you are resetting.
    channel_name: []const u8,

    /// The name of the origin endpoint that you are resetting.
    origin_endpoint_name: []const u8,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .origin_endpoint_name = "OriginEndpointName",
    };
};

pub const ResetOriginEndpointStateOutput = struct {
    /// The Amazon Resource Name (ARN) associated with the endpoint that you just
    /// reset.
    arn: []const u8,

    /// The name of the channel group that contains the channel with the origin
    /// endpoint that you just reset.
    channel_group_name: []const u8,

    /// The name of the channel with the origin endpoint that you just reset.
    channel_name: []const u8,

    /// The name of the origin endpoint that you just reset.
    origin_endpoint_name: []const u8,

    /// The time that the origin endpoint was last reset.
    reset_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .origin_endpoint_name = "OriginEndpointName",
        .reset_at = "ResetAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResetOriginEndpointStateInput, options: CallOptions) !ResetOriginEndpointStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediapackagev2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ResetOriginEndpointStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channelGroup/");
    try path_buf.appendSlice(allocator, input.channel_group_name);
    try path_buf.appendSlice(allocator, "/channel/");
    try path_buf.appendSlice(allocator, input.channel_name);
    try path_buf.appendSlice(allocator, "/originEndpoint/");
    try path_buf.appendSlice(allocator, input.origin_endpoint_name);
    try path_buf.appendSlice(allocator, "/reset");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResetOriginEndpointStateOutput {
    const result: ResetOriginEndpointStateOutput = try aws.json.parseJsonObject(
        ResetOriginEndpointStateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
