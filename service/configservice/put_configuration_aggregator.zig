const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountAggregationSource = @import("account_aggregation_source.zig").AccountAggregationSource;
const AggregatorFilters = @import("aggregator_filters.zig").AggregatorFilters;
const OrganizationAggregationSource = @import("organization_aggregation_source.zig").OrganizationAggregationSource;
const Tag = @import("tag.zig").Tag;
const ConfigurationAggregator = @import("configuration_aggregator.zig").ConfigurationAggregator;

pub const PutConfigurationAggregatorInput = struct {
    /// A list of AccountAggregationSource object.
    account_aggregation_sources: ?[]const AccountAggregationSource = null,

    /// An object to filter configuration recorders in an aggregator. Either
    /// `ResourceType` or `ServicePrincipal` is required.
    aggregator_filters: ?AggregatorFilters = null,

    /// The name of the configuration aggregator.
    configuration_aggregator_name: []const u8,

    /// An OrganizationAggregationSource object.
    organization_aggregation_source: ?OrganizationAggregationSource = null,

    /// An array of tag object.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .account_aggregation_sources = "AccountAggregationSources",
        .aggregator_filters = "AggregatorFilters",
        .configuration_aggregator_name = "ConfigurationAggregatorName",
        .organization_aggregation_source = "OrganizationAggregationSource",
        .tags = "Tags",
    };
};

pub const PutConfigurationAggregatorOutput = struct {
    /// Returns a ConfigurationAggregator object.
    configuration_aggregator: ?ConfigurationAggregator = null,

    pub const json_field_names = .{
        .configuration_aggregator = "ConfigurationAggregator",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutConfigurationAggregatorInput, options: CallOptions) !PutConfigurationAggregatorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutConfigurationAggregatorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.PutConfigurationAggregator");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutConfigurationAggregatorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutConfigurationAggregatorOutput, body, allocator);
}
