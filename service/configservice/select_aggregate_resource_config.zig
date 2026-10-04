const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryInfo = @import("query_info.zig").QueryInfo;

pub const SelectAggregateResourceConfigInput = struct {
    /// The name of the configuration aggregator.
    configuration_aggregator_name: []const u8,

    /// The SQL query SELECT command.
    expression: []const u8,

    /// The maximum number of query results returned on each page.
    limit: ?i32 = null,

    /// The maximum number of query results returned on each page. Config also
    /// allows the Limit request parameter.
    max_results: ?i32 = null,

    /// The nextToken string returned in a previous request that you use to request
    /// the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_aggregator_name = "ConfigurationAggregatorName",
        .expression = "Expression",
        .limit = "Limit",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const SelectAggregateResourceConfigOutput = struct {
    /// The nextToken string returned in a previous request that you use to request
    /// the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    query_info: ?QueryInfo = null,

    /// Returns the results for the SQL query.
    results: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .query_info = "QueryInfo",
        .results = "Results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SelectAggregateResourceConfigInput, options: CallOptions) !SelectAggregateResourceConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SelectAggregateResourceConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.SelectAggregateResourceConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SelectAggregateResourceConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SelectAggregateResourceConfigOutput, body, allocator);
}
