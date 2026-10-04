const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryStatistics = @import("query_statistics.zig").QueryStatistics;
const QueryStatus = @import("query_status.zig").QueryStatus;

pub const DescribeQueryInput = struct {
    /// The unique identifier for the query execution.
    query_id: []const u8,

    /// The name of the workspace associated with the query.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .query_id = "queryId",
        .workspace_name = "workspaceName",
    };
};

pub const DescribeQueryOutput = struct {
    /// The date and time when the query reached a terminal state, in Unix epoch
    /// time. This field is present when the query status is COMPLETED, FAILED, or
    /// CANCELED.
    completed_at: ?i64 = null,

    /// A human-readable error description. This field is present when the query
    /// status is FAILED.
    error_message: ?[]const u8 = null,

    /// The unique identifier for the query execution.
    query_id: []const u8,

    /// The query execution statistics. This field is present when the query status
    /// is COMPLETED.
    statistics: ?QueryStatistics = null,

    /// The current query status.
    status: QueryStatus,

    /// The date and time when the query was submitted, in Unix epoch time.
    submitted_at: i64,

    pub const json_field_names = .{
        .completed_at = "completedAt",
        .error_message = "errorMessage",
        .query_id = "queryId",
        .statistics = "statistics",
        .status = "status",
        .submitted_at = "submittedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeQueryInput, options: CallOptions) !DescribeQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/queries/");
    try path_buf.appendSlice(allocator, input.query_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeQueryOutput {
    const result: DescribeQueryOutput = try aws.json.parseJsonObject(
        DescribeQueryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
