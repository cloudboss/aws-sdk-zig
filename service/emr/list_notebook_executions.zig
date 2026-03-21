const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const NotebookExecutionStatus = @import("notebook_execution_status.zig").NotebookExecutionStatus;
const NotebookExecutionSummary = @import("notebook_execution_summary.zig").NotebookExecutionSummary;

pub const ListNotebookExecutionsInput = struct {
    /// The unique ID of the editor associated with the notebook execution.
    editor_id: ?[]const u8 = null,

    /// The unique ID of the execution engine.
    execution_engine_id: ?[]const u8 = null,

    /// The beginning of time range filter for listing notebook executions. The
    /// default is the
    /// timestamp of 30 days ago.
    from: ?i64 = null,

    /// The pagination token, returned by a previous `ListNotebookExecutions` call,
    /// that indicates the start of the list for this `ListNotebookExecutions`
    /// call.
    marker: ?[]const u8 = null,

    /// The status filter for listing notebook executions.
    ///
    /// * `START_PENDING` indicates that the cluster has received the execution
    /// request but execution has not begun.
    ///
    /// * `STARTING` indicates that the execution is starting on the
    /// cluster.
    ///
    /// * `RUNNING` indicates that the execution is being processed by the
    /// cluster.
    ///
    /// * `FINISHING` indicates that execution processing is in the final
    /// stages.
    ///
    /// * `FINISHED` indicates that the execution has completed without
    /// error.
    ///
    /// * `FAILING` indicates that the execution is failing and will not finish
    /// successfully.
    ///
    /// * `FAILED` indicates that the execution failed.
    ///
    /// * `STOP_PENDING` indicates that the cluster has received a
    /// `StopNotebookExecution` request and the stop is pending.
    ///
    /// * `STOPPING` indicates that the cluster is in the process of stopping the
    /// execution as a result of a `StopNotebookExecution` request.
    ///
    /// * `STOPPED` indicates that the execution stopped because of a
    /// `StopNotebookExecution` request.
    status: ?NotebookExecutionStatus = null,

    /// The end of time range filter for listing notebook executions. The default is
    /// the current
    /// timestamp.
    to: ?i64 = null,

    pub const json_field_names = .{
        .editor_id = "EditorId",
        .execution_engine_id = "ExecutionEngineId",
        .from = "From",
        .marker = "Marker",
        .status = "Status",
        .to = "To",
    };
};

pub const ListNotebookExecutionsOutput = struct {
    /// A pagination token that a subsequent `ListNotebookExecutions` can use to
    /// determine the next set of results to retrieve.
    marker: ?[]const u8 = null,

    /// A list of notebook executions.
    notebook_executions: ?[]const NotebookExecutionSummary = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .notebook_executions = "NotebookExecutions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNotebookExecutionsInput, options: CallOptions) !ListNotebookExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "elasticmapreduce");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListNotebookExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.ListNotebookExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNotebookExecutionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListNotebookExecutionsOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
