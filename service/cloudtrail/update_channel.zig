const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Destination = @import("destination.zig").Destination;

pub const UpdateChannelInput = struct {
    /// The ARN or ID (the ARN suffix) of the channel that you want to update.
    channel: []const u8,

    /// The ARNs of event data stores that you want to log events arriving through
    /// the channel.
    destinations: ?[]const Destination = null,

    /// Changes the name of the channel.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel = "Channel",
        .destinations = "Destinations",
        .name = "Name",
    };
};

pub const UpdateChannelOutput = struct {
    /// The ARN of the channel that was updated.
    channel_arn: ?[]const u8 = null,

    /// The event data stores that log events arriving through the channel.
    destinations: ?[]const Destination = null,

    /// The name of the channel that was updated.
    name: ?[]const u8 = null,

    /// The event source of the channel that was updated.
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .destinations = "Destinations",
        .name = "Name",
        .source = "Source",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateChannelInput, options: CallOptions) !UpdateChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.UpdateChannel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateChannelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateChannelOutput, body, allocator);
}
