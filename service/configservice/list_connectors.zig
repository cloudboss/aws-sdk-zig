const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorFilter = @import("connector_filter.zig").ConnectorFilter;
const ConnectorSummary = @import("connector_summary.zig").ConnectorSummary;

pub const ListConnectorsInput = struct {
    /// Filters the results based on a list of `ConnectorFilter` objects that you
    /// specify.
    filters: ?[]const ConnectorFilter = null,

    /// The maximum number of results to include in the response.
    max_results: ?i32 = null,

    /// The `NextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListConnectorsOutput = struct {
    /// A list of `ConnectorSummary` objects.
    connector_summaries: ?[]const ConnectorSummary = null,

    /// The `NextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_summaries = "ConnectorSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConnectorsInput, options: CallOptions) !ListConnectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConnectorsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.ListConnectors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConnectorsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListConnectorsOutput, body, allocator);
}
