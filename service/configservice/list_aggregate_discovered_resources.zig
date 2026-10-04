const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceFilters = @import("resource_filters.zig").ResourceFilters;
const ResourceType = @import("resource_type.zig").ResourceType;
const AggregateResourceIdentifier = @import("aggregate_resource_identifier.zig").AggregateResourceIdentifier;

pub const ListAggregateDiscoveredResourcesInput = struct {
    /// The name of the configuration aggregator.
    configuration_aggregator_name: []const u8,

    /// Filters the results based on the `ResourceFilters` object.
    filters: ?ResourceFilters = null,

    /// The maximum number of resource identifiers returned on each page. You cannot
    /// specify a number greater than 100. If you specify 0, Config uses the
    /// default.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// The type of resources that you want Config to list in the response.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .configuration_aggregator_name = "ConfigurationAggregatorName",
        .filters = "Filters",
        .limit = "Limit",
        .next_token = "NextToken",
        .resource_type = "ResourceType",
    };
};

pub const ListAggregateDiscoveredResourcesOutput = struct {
    /// The `nextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// Returns a list of `ResourceIdentifiers` objects.
    resource_identifiers: ?[]const AggregateResourceIdentifier = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_identifiers = "ResourceIdentifiers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAggregateDiscoveredResourcesInput, options: CallOptions) !ListAggregateDiscoveredResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAggregateDiscoveredResourcesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.ListAggregateDiscoveredResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAggregateDiscoveredResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAggregateDiscoveredResourcesOutput, body, allocator);
}
