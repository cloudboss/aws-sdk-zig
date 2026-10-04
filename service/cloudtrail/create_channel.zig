const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Destination = @import("destination.zig").Destination;
const Tag = @import("tag.zig").Tag;

pub const CreateChannelInput = struct {
    /// One or more event data stores to which events arriving through a channel
    /// will be logged.
    destinations: []const Destination,

    /// The name of the channel.
    name: []const u8,

    /// The name of the partner or external event source. You cannot change this
    /// name after you create the
    /// channel. A maximum of one channel is allowed per source.
    ///
    /// A source can be either `Custom` for all valid non-Amazon Web Services
    /// events, or the name of a partner event source. For information about the
    /// source names for available partners, see [Additional information about
    /// integration
    /// partners](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/query-event-data-store-integration.html#cloudtrail-lake-partner-information) in the CloudTrail User Guide.
    source: []const u8,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .destinations = "Destinations",
        .name = "Name",
        .source = "Source",
        .tags = "Tags",
    };
};

pub const CreateChannelOutput = struct {
    /// The Amazon Resource Name (ARN) of the new channel.
    channel_arn: ?[]const u8 = null,

    /// The event data stores that log the events arriving through the channel.
    destinations: ?[]const Destination = null,

    /// The name of the new channel.
    name: ?[]const u8 = null,

    /// The partner or external event source name.
    source: ?[]const u8 = null,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .destinations = "Destinations",
        .name = "Name",
        .source = "Source",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChannelInput, options: CallOptions) !CreateChannelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChannelInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.CreateChannel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChannelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateChannelOutput, body, allocator);
}
