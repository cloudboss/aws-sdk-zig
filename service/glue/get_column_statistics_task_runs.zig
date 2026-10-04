const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ColumnStatisticsTaskRun = @import("column_statistics_task_run.zig").ColumnStatisticsTaskRun;

pub const GetColumnStatisticsTaskRunsInput = struct {
    /// The name of the database where the table resides.
    database_name: []const u8,

    /// The maximum size of the response.
    max_results: ?i32 = null,

    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// The name of the table.
    table_name: []const u8,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .table_name = "TableName",
    };
};

pub const GetColumnStatisticsTaskRunsOutput = struct {
    /// A list of column statistics task runs.
    column_statistics_task_runs: ?[]const ColumnStatisticsTaskRun = null,

    /// A continuation token, if not all task runs have yet been returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .column_statistics_task_runs = "ColumnStatisticsTaskRuns",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetColumnStatisticsTaskRunsInput, options: CallOptions) !GetColumnStatisticsTaskRunsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetColumnStatisticsTaskRunsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetColumnStatisticsTaskRuns");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetColumnStatisticsTaskRunsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetColumnStatisticsTaskRunsOutput, body, allocator);
}
