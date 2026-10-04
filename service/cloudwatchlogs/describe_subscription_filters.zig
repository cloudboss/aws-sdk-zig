const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionFilter = @import("subscription_filter.zig").SubscriptionFilter;

pub const DescribeSubscriptionFiltersInput = struct {
    /// The prefix to match. If you don't specify a value, no prefix filter is
    /// applied.
    filter_name_prefix: ?[]const u8 = null,

    /// The maximum number of items returned. If you don't specify a value, the
    /// default is up
    /// to 50 items.
    limit: ?i32 = null,

    /// The name of the log group.
    log_group_name: []const u8,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter_name_prefix = "filterNamePrefix",
        .limit = "limit",
        .log_group_name = "logGroupName",
        .next_token = "nextToken",
    };
};

pub const DescribeSubscriptionFiltersOutput = struct {
    next_token: ?[]const u8 = null,

    /// The subscription filters.
    subscription_filters: ?[]const SubscriptionFilter = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .subscription_filters = "subscriptionFilters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSubscriptionFiltersInput, options: CallOptions) !DescribeSubscriptionFiltersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSubscriptionFiltersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeSubscriptionFilters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSubscriptionFiltersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSubscriptionFiltersOutput, body, allocator);
}
