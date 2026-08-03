const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const TaskList = @import("task_list.zig").TaskList;
const ActivityType = @import("activity_type.zig").ActivityType;
const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;

pub const PollForActivityTaskInput = struct {
    /// The name of the domain that contains the task lists being polled.
    domain: []const u8,

    /// Identity of the worker making the request, recorded in the
    /// `ActivityTaskStarted` event in the workflow history. This enables diagnostic
    /// tracing when problems arise. The form of this identity is user defined.
    identity: ?[]const u8 = null,

    /// Specifies the task list to poll for activity tasks.
    ///
    /// The specified string must not start or end with whitespace. It must not
    /// contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    task_list: TaskList,

    pub const json_field_names = .{
        .domain = "domain",
        .identity = "identity",
        .task_list = "taskList",
    };
};

pub const PollForActivityTaskOutput = struct {
    /// The unique ID of the task.
    activity_id: []const u8,

    /// The type of this activity task.
    activity_type: ?ActivityType = null,

    /// The inputs provided when the activity task was scheduled. The form of the
    /// input is user defined and should be meaningful to the activity
    /// implementation.
    input: ?[]const u8 = null,

    /// The ID of the `ActivityTaskStarted` event recorded in the history.
    started_event_id: ?i64 = null,

    /// The opaque string used as a handle on the task. This token is used by
    /// workers to communicate progress and response information back to the system
    /// about the task.
    task_token: []const u8,

    /// The workflow execution that started this activity task.
    workflow_execution: ?WorkflowExecution = null,

    pub const json_field_names = .{
        .activity_id = "activityId",
        .activity_type = "activityType",
        .input = "input",
        .started_event_id = "startedEventId",
        .task_token = "taskToken",
        .workflow_execution = "workflowExecution",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PollForActivityTaskInput, options: CallOptions) !PollForActivityTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "swf", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PollForActivityTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.PollForActivityTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PollForActivityTaskOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PollForActivityTaskOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "DefaultUndefinedFault")) {
        const parsed_error: ?errors.DefaultUndefinedFault = aws.json.parseJsonObject(errors.DefaultUndefinedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .default_undefined_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DomainAlreadyExistsFault")) {
        const parsed_error: ?errors.DomainAlreadyExistsFault = aws.json.parseJsonObject(errors.DomainAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .domain_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DomainDeprecatedFault")) {
        const parsed_error: ?errors.DomainDeprecatedFault = aws.json.parseJsonObject(errors.DomainDeprecatedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .domain_deprecated_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        const parsed_error: ?errors.LimitExceededFault = aws.json.parseJsonObject(errors.LimitExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedFault")) {
        const parsed_error: ?errors.OperationNotPermittedFault = aws.json.parseJsonObject(errors.OperationNotPermittedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_permitted_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsFault")) {
        const parsed_error: ?errors.TooManyTagsFault = aws.json.parseJsonObject(errors.TooManyTagsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TypeAlreadyExistsFault")) {
        const parsed_error: ?errors.TypeAlreadyExistsFault = aws.json.parseJsonObject(errors.TypeAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .type_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TypeDeprecatedFault")) {
        const parsed_error: ?errors.TypeDeprecatedFault = aws.json.parseJsonObject(errors.TypeDeprecatedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .type_deprecated_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TypeNotDeprecatedFault")) {
        const parsed_error: ?errors.TypeNotDeprecatedFault = aws.json.parseJsonObject(errors.TypeNotDeprecatedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .type_not_deprecated_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnknownResourceFault")) {
        const parsed_error: ?errors.UnknownResourceFault = aws.json.parseJsonObject(errors.UnknownResourceFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unknown_resource_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WorkflowExecutionAlreadyStartedFault")) {
        const parsed_error: ?errors.WorkflowExecutionAlreadyStartedFault = aws.json.parseJsonObject(errors.WorkflowExecutionAlreadyStartedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .workflow_execution_already_started_fault = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
