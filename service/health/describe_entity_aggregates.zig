const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityAggregate = @import("entity_aggregate.zig").EntityAggregate;

pub const DescribeEntityAggregatesInput = struct {
    /// A list of event ARNs (unique identifiers). For example:
    /// `"arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-CDE456", "arn:aws:health:us-west-1::event/EBS/AWS_EBS_LOST_VOLUME/AWS_EBS_LOST_VOLUME_CHI789_JKL101"`
    event_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .event_arns = "eventArns",
    };
};

pub const DescribeEntityAggregatesOutput = struct {
    /// The number of entities that are affected by each of the specified events.
    entity_aggregates: ?[]const EntityAggregate = null,

    pub const json_field_names = .{
        .entity_aggregates = "entityAggregates",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEntityAggregatesInput, options: CallOptions) !DescribeEntityAggregatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "health", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEntityAggregatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health", "Health", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHealth_20160804.DescribeEntityAggregates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEntityAggregatesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEntityAggregatesOutput, body, allocator);
}
