const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceCountFilters = @import("resource_count_filters.zig").ResourceCountFilters;
const ResourceCountGroupKey = @import("resource_count_group_key.zig").ResourceCountGroupKey;
const GroupedResourceCount = @import("grouped_resource_count.zig").GroupedResourceCount;

pub const GetAggregateDiscoveredResourceCountsInput = struct {
    /// The name of the configuration aggregator.
    configuration_aggregator_name: []const u8,

    /// Filters the results based on the `ResourceCountFilters` object.
    filters: ?ResourceCountFilters = null,

    /// The key to group the resource counts.
    group_by_key: ?ResourceCountGroupKey = null,

    /// The maximum number of GroupedResourceCount objects returned on each page.
    /// The default is 1000. You cannot specify a number greater than 1000. If you
    /// specify 0, Config uses the default.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_aggregator_name = "ConfigurationAggregatorName",
        .filters = "Filters",
        .group_by_key = "GroupByKey",
        .limit = "Limit",
        .next_token = "NextToken",
    };
};

pub const GetAggregateDiscoveredResourceCountsOutput = struct {
    /// The key passed into the request object. If `GroupByKey` is not provided, the
    /// result will be empty.
    group_by_key: ?[]const u8 = null,

    /// Returns a list of GroupedResourceCount objects.
    grouped_resource_counts: ?[]const GroupedResourceCount = null,

    /// The `nextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// The total number of resources that are present in an aggregator with the
    /// filters that you provide.
    total_discovered_resources: ?i64 = null,

    pub const json_field_names = .{
        .group_by_key = "GroupByKey",
        .grouped_resource_counts = "GroupedResourceCounts",
        .next_token = "NextToken",
        .total_discovered_resources = "TotalDiscoveredResources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAggregateDiscoveredResourceCountsInput, options: CallOptions) !GetAggregateDiscoveredResourceCountsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAggregateDiscoveredResourceCountsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.GetAggregateDiscoveredResourceCounts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAggregateDiscoveredResourceCountsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAggregateDiscoveredResourceCountsOutput, body, allocator);
}
