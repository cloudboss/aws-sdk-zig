const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SortPipelineExecutionsBy = @import("sort_pipeline_executions_by.zig").SortPipelineExecutionsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const PipelineExecutionSummary = @import("pipeline_execution_summary.zig").PipelineExecutionSummary;

pub const ListPipelineExecutionsInput = struct {
    /// A filter that returns the pipeline executions that were created after a
    /// specified time.
    created_after: ?i64 = null,

    /// A filter that returns the pipeline executions that were created before a
    /// specified time.
    created_before: ?i64 = null,

    /// The maximum number of pipeline executions to return in the response.
    max_results: ?i32 = null,

    /// If the result of the previous `ListPipelineExecutions` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// pipeline executions, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) of the pipeline.
    pipeline_name: []const u8,

    /// The field by which to sort results. The default is `CreatedTime`.
    sort_by: ?SortPipelineExecutionsBy = null,

    /// The sort order for results.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .pipeline_name = "PipelineName",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListPipelineExecutionsOutput = struct {
    /// If the result of the previous `ListPipelineExecutions` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// pipeline executions, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// Contains a sorted list of pipeline execution summary objects matching the
    /// specified filters. Each run summary includes the Amazon Resource Name (ARN)
    /// of the pipeline execution, the run date, and the status. This list can be
    /// empty.
    pipeline_execution_summaries: ?[]const PipelineExecutionSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .pipeline_execution_summaries = "PipelineExecutionSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPipelineExecutionsInput, options: CallOptions) !ListPipelineExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPipelineExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListPipelineExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPipelineExecutionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPipelineExecutionsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
