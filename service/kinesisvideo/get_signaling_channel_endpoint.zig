const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SingleMasterChannelEndpointConfiguration = @import("single_master_channel_endpoint_configuration.zig").SingleMasterChannelEndpointConfiguration;
const ResourceEndpointListItem = @import("resource_endpoint_list_item.zig").ResourceEndpointListItem;

pub const GetSignalingChannelEndpointInput = struct {
    /// The Amazon Resource Name (ARN) of the signalling channel for which you want
    /// to get an
    /// endpoint.
    channel_arn: []const u8,

    /// A structure containing the endpoint configuration for the `SINGLE_MASTER`
    /// channel type.
    single_master_channel_endpoint_configuration: ?SingleMasterChannelEndpointConfiguration = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelARN",
        .single_master_channel_endpoint_configuration = "SingleMasterChannelEndpointConfiguration",
    };
};

pub const GetSignalingChannelEndpointOutput = struct {
    /// A list of endpoints for the specified signaling channel.
    resource_endpoint_list: ?[]const ResourceEndpointListItem = null,

    pub const json_field_names = .{
        .resource_endpoint_list = "ResourceEndpointList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSignalingChannelEndpointInput, options: CallOptions) !GetSignalingChannelEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisvideo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSignalingChannelEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/getSignalingChannelEndpoint";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelARN\":");
    try aws.json.writeValue(@TypeOf(input.channel_arn), input.channel_arn, allocator, &body_buf);
    has_prev = true;
    if (input.single_master_channel_endpoint_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SingleMasterChannelEndpointConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSignalingChannelEndpointOutput {
    var result: GetSignalingChannelEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSignalingChannelEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
