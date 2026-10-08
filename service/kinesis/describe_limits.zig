const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeLimitsInput = struct {};

pub const DescribeLimitsOutput = struct {
    /// The number of channels in the account.
    channel_count: ?i32 = null,

    /// The maximum number of channels allowed in the account.
    channel_count_limit: ?i32 = null,

    /// Indicates the number of data streams with the on-demand capacity mode.
    on_demand_stream_count: i32,

    /// The maximum number of data streams with the on-demand capacity mode.
    on_demand_stream_count_limit: i32,

    /// The number of open shards.
    open_shard_count: i32,

    /// The maximum number of shards.
    shard_limit: i32,

    pub const json_field_names = .{
        .channel_count = "ChannelCount",
        .channel_count_limit = "ChannelCountLimit",
        .on_demand_stream_count = "OnDemandStreamCount",
        .on_demand_stream_count_limit = "OnDemandStreamCountLimit",
        .open_shard_count = "OpenShardCount",
        .shard_limit = "ShardLimit",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLimitsInput, options: CallOptions) !DescribeLimitsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLimitsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.DescribeLimits");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLimitsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeLimitsOutput, body, allocator);
}
