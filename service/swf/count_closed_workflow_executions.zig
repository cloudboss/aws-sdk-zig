const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CloseStatusFilter = @import("close_status_filter.zig").CloseStatusFilter;
const ExecutionTimeFilter = @import("execution_time_filter.zig").ExecutionTimeFilter;
const WorkflowExecutionFilter = @import("workflow_execution_filter.zig").WorkflowExecutionFilter;
const TagFilter = @import("tag_filter.zig").TagFilter;
const WorkflowTypeFilter = @import("workflow_type_filter.zig").WorkflowTypeFilter;

pub const CountClosedWorkflowExecutionsInput = struct {
    /// If specified, only workflow executions that match this close status are
    /// counted. This
    /// filter has an affect only if `executionStatus` is specified as
    /// `CLOSED`.
    ///
    /// `closeStatusFilter`, `executionFilter`, `typeFilter` and
    /// `tagFilter` are mutually exclusive. You can specify at most one of these in
    /// a
    /// request.
    close_status_filter: ?CloseStatusFilter = null,

    /// If specified, only workflow executions that meet the close time criteria of
    /// the filter
    /// are counted.
    ///
    /// `startTimeFilter` and `closeTimeFilter` are mutually exclusive. You
    /// must specify one of these in a request but not both.
    close_time_filter: ?ExecutionTimeFilter = null,

    /// The name of the domain containing the workflow executions to count.
    domain: []const u8,

    /// If specified, only workflow executions matching the `WorkflowId` in the
    /// filter are counted.
    ///
    /// `closeStatusFilter`, `executionFilter`, `typeFilter` and
    /// `tagFilter` are mutually exclusive. You can specify at most one of these in
    /// a
    /// request.
    execution_filter: ?WorkflowExecutionFilter = null,

    /// If specified, only workflow executions that meet the start time criteria of
    /// the filter
    /// are counted.
    ///
    /// `startTimeFilter` and `closeTimeFilter` are mutually exclusive. You
    /// must specify one of these in a request but not both.
    start_time_filter: ?ExecutionTimeFilter = null,

    /// If specified, only executions that have a tag that matches the filter are
    /// counted.
    ///
    /// `closeStatusFilter`, `executionFilter`, `typeFilter` and
    /// `tagFilter` are mutually exclusive. You can specify at most one of these in
    /// a
    /// request.
    tag_filter: ?TagFilter = null,

    /// If specified, indicates the type of the workflow executions to be counted.
    ///
    /// `closeStatusFilter`, `executionFilter`, `typeFilter` and
    /// `tagFilter` are mutually exclusive. You can specify at most one of these in
    /// a
    /// request.
    type_filter: ?WorkflowTypeFilter = null,

    pub const json_field_names = .{
        .close_status_filter = "closeStatusFilter",
        .close_time_filter = "closeTimeFilter",
        .domain = "domain",
        .execution_filter = "executionFilter",
        .start_time_filter = "startTimeFilter",
        .tag_filter = "tagFilter",
        .type_filter = "typeFilter",
    };
};

pub const CountClosedWorkflowExecutionsOutput = struct {
    /// The number of workflow executions.
    count: ?i32 = null,

    /// If set to true, indicates that the actual count was more than the maximum
    /// supported by this API and the count returned is the truncated value.
    truncated: ?bool = null,

    pub const json_field_names = .{
        .count = "count",
        .truncated = "truncated",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CountClosedWorkflowExecutionsInput, options: Options) !CountClosedWorkflowExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "swf");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CountClosedWorkflowExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "SimpleWorkflowService.CountClosedWorkflowExecutions");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CountClosedWorkflowExecutionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CountClosedWorkflowExecutionsOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "DefaultUndefinedFault")) {
        return .{ .arena = arena, .kind = .{ .default_undefined_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .domain_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainDeprecatedFault")) {
        return .{ .arena = arena, .kind = .{ .domain_deprecated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedFault")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsFault")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .type_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeDeprecatedFault")) {
        return .{ .arena = arena, .kind = .{ .type_deprecated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeNotDeprecatedFault")) {
        return .{ .arena = arena, .kind = .{ .type_not_deprecated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownResourceFault")) {
        return .{ .arena = arena, .kind = .{ .unknown_resource_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WorkflowExecutionAlreadyStartedFault")) {
        return .{ .arena = arena, .kind = .{ .workflow_execution_already_started_fault = .{
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
