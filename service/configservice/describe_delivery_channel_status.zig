const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliveryChannelStatus = @import("delivery_channel_status.zig").DeliveryChannelStatus;

pub const DescribeDeliveryChannelStatusInput = struct {
    /// A list of delivery channel names.
    delivery_channel_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .delivery_channel_names = "DeliveryChannelNames",
    };
};

pub const DescribeDeliveryChannelStatusOutput = struct {
    /// A list that contains the status of a specified delivery
    /// channel.
    delivery_channels_status: ?[]const DeliveryChannelStatus = null,

    pub const json_field_names = .{
        .delivery_channels_status = "DeliveryChannelsStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDeliveryChannelStatusInput, options: CallOptions) !DescribeDeliveryChannelStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDeliveryChannelStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.DescribeDeliveryChannelStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDeliveryChannelStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDeliveryChannelStatusOutput, body, allocator);
}
