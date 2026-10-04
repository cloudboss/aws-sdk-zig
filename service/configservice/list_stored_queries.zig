const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StoredQueryMetadata = @import("stored_query_metadata.zig").StoredQueryMetadata;

pub const ListStoredQueriesInput = struct {
    /// The maximum number of results to be returned with a single call.
    max_results: ?i32 = null,

    /// The nextToken string returned in a previous request that you use to request
    /// the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListStoredQueriesOutput = struct {
    /// If the previous paginated request didn't return all of the remaining
    /// results, the response object's `NextToken` parameter value is set to a
    /// token.
    /// To retrieve the next set of results, call this operation again and assign
    /// that token to the request object's `NextToken` parameter.
    /// If there are no remaining results, the previous response object's
    /// `NextToken` parameter is set to `null`.
    next_token: ?[]const u8 = null,

    /// A list of `StoredQueryMetadata` objects.
    stored_query_metadata: ?[]const StoredQueryMetadata = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .stored_query_metadata = "StoredQueryMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStoredQueriesInput, options: CallOptions) !ListStoredQueriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStoredQueriesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.ListStoredQueries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStoredQueriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListStoredQueriesOutput, body, allocator);
}
