const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduledQueryState = @import("scheduled_query_state.zig").ScheduledQueryState;
const ScheduledQuerySummary = @import("scheduled_query_summary.zig").ScheduledQuerySummary;

pub const ListScheduledQueriesInput = struct {
    /// The maximum number of scheduled queries to return. Valid range is 1 to 1000.
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// Filter scheduled queries by state. Valid values are `ENABLED` and
    /// `DISABLED`. If not specified, all scheduled queries are returned.
    state: ?ScheduledQueryState = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .state = "state",
    };
};

pub const ListScheduledQueriesOutput = struct {
    next_token: ?[]const u8 = null,

    /// An array of scheduled query summary information.
    scheduled_queries: ?[]const ScheduledQuerySummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .scheduled_queries = "scheduledQueries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListScheduledQueriesInput, options: CallOptions) !ListScheduledQueriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListScheduledQueriesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.ListScheduledQueries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListScheduledQueriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListScheduledQueriesOutput, body, allocator);
}
