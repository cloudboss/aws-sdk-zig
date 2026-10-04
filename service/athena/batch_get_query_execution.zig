const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryExecution = @import("query_execution.zig").QueryExecution;
const UnprocessedQueryExecutionId = @import("unprocessed_query_execution_id.zig").UnprocessedQueryExecutionId;

pub const BatchGetQueryExecutionInput = struct {
    /// An array of query execution IDs.
    query_execution_ids: []const []const u8,

    pub const json_field_names = .{
        .query_execution_ids = "QueryExecutionIds",
    };
};

pub const BatchGetQueryExecutionOutput = struct {
    /// Information about a query execution.
    query_executions: ?[]const QueryExecution = null,

    /// Information about the query executions that failed to run.
    unprocessed_query_execution_ids: ?[]const UnprocessedQueryExecutionId = null,

    pub const json_field_names = .{
        .query_executions = "QueryExecutions",
        .unprocessed_query_execution_ids = "UnprocessedQueryExecutionIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetQueryExecutionInput, options: CallOptions) !BatchGetQueryExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetQueryExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.BatchGetQueryExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetQueryExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetQueryExecutionOutput, body, allocator);
}
