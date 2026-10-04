const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduledQuery = @import("scheduled_query.zig").ScheduledQuery;

pub const ListScheduledQueriesInput = struct {
    /// The maximum number of items to return in the output. If the total number of
    /// items
    /// available is more than the value specified, a `NextToken` is provided in the
    /// output. To resume pagination, provide the `NextToken` value as the argument
    /// to the subsequent call to `ListScheduledQueriesRequest`.
    max_results: ?i32 = null,

    /// A pagination token to resume pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListScheduledQueriesOutput = struct {
    /// A token to specify where to start paginating. This is the NextToken from a
    /// previously
    /// truncated response.
    next_token: ?[]const u8 = null,

    /// A list of scheduled queries.
    scheduled_queries: ?[]const ScheduledQuery = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .scheduled_queries = "ScheduledQueries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListScheduledQueriesInput, options: CallOptions) !ListScheduledQueriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListScheduledQueriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("query.timestream", "Timestream Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.ListScheduledQueries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListScheduledQueriesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListScheduledQueriesOutput, body, allocator);
}
