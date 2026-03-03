const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ChildPolicy = @import("child_policy.zig").ChildPolicy;
const TaskList = @import("task_list.zig").TaskList;

pub const RegisterWorkflowTypeInput = struct {
    /// If set, specifies the default policy to use for the child workflow
    /// executions when a
    /// workflow execution of this type is terminated, by calling the
    /// TerminateWorkflowExecution action explicitly or due to an expired timeout.
    /// This
    /// default can be overridden when starting a workflow execution using the
    /// StartWorkflowExecution action or the `StartChildWorkflowExecution`
    /// Decision.
    ///
    /// The supported child policies are:
    ///
    /// * `TERMINATE` – The child executions are terminated.
    ///
    /// * `REQUEST_CANCEL` – A request to cancel is attempted for each child
    /// execution by recording a `WorkflowExecutionCancelRequested` event in its
    /// history. It is up to the decider to take appropriate actions when it
    /// receives an execution
    /// history with this event.
    ///
    /// * `ABANDON` – No action is taken. The child executions continue to
    /// run.
    default_child_policy: ?ChildPolicy = null,

    /// If set, specifies the default maximum duration for executions of this
    /// workflow type.
    /// You can override this default when starting an execution through the
    /// StartWorkflowExecution Action or `StartChildWorkflowExecution`
    /// Decision.
    ///
    /// The duration is specified in seconds; an integer greater than or equal to 0.
    /// Unlike
    /// some of the other timeout parameters in Amazon SWF, you cannot specify a
    /// value of "NONE" for
    /// `defaultExecutionStartToCloseTimeout`; there is a one-year max limit on the
    /// time
    /// that a workflow execution can run. Exceeding this limit always causes the
    /// workflow execution
    /// to time out.
    default_execution_start_to_close_timeout: ?[]const u8 = null,

    /// The default IAM role attached to this workflow type.
    ///
    /// Executions of this workflow type need IAM roles to invoke Lambda functions.
    /// If you
    /// don't specify an IAM role when you start this workflow type, the default
    /// Lambda role is
    /// attached to the execution. For more information, see
    /// [https://docs.aws.amazon.com/amazonswf/latest/developerguide/lambda-task.html](https://docs.aws.amazon.com/amazonswf/latest/developerguide/lambda-task.html) in the
    /// *Amazon SWF Developer Guide*.
    default_lambda_role: ?[]const u8 = null,

    /// If set, specifies the default task list to use for scheduling decision tasks
    /// for
    /// executions of this workflow type. This default is used only if a task list
    /// isn't provided when
    /// starting the execution through the StartWorkflowExecution Action or
    /// `StartChildWorkflowExecution`
    /// Decision.
    default_task_list: ?TaskList = null,

    /// The default task priority to assign to the workflow type. If not assigned,
    /// then
    /// `0` is used. Valid values are integers that range from Java's
    /// `Integer.MIN_VALUE` (-2147483648) to `Integer.MAX_VALUE` (2147483647).
    /// Higher numbers indicate higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *Amazon SWF Developer Guide*.
    default_task_priority: ?[]const u8 = null,

    /// If set, specifies the default maximum duration of decision tasks for this
    /// workflow
    /// type. This default can be overridden when starting a workflow execution
    /// using the StartWorkflowExecution action or the `StartChildWorkflowExecution`
    /// Decision.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_task_start_to_close_timeout: ?[]const u8 = null,

    /// Textual description of the workflow type.
    description: ?[]const u8 = null,

    /// The name of the domain in which to register the workflow type.
    domain: []const u8,

    /// The name of the workflow type.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    name: []const u8,

    /// The version of the workflow type.
    ///
    /// The workflow type consists of the name and version, the combination of which
    /// must be
    /// unique within the domain. To get a list of all currently registered workflow
    /// types, use the
    /// ListWorkflowTypes action.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    version: []const u8,

    pub const json_field_names = .{
        .default_child_policy = "defaultChildPolicy",
        .default_execution_start_to_close_timeout = "defaultExecutionStartToCloseTimeout",
        .default_lambda_role = "defaultLambdaRole",
        .default_task_list = "defaultTaskList",
        .default_task_priority = "defaultTaskPriority",
        .default_task_start_to_close_timeout = "defaultTaskStartToCloseTimeout",
        .description = "description",
        .domain = "domain",
        .name = "name",
        .version = "version",
    };
};

pub const RegisterWorkflowTypeOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterWorkflowTypeInput, options: CallOptions) !RegisterWorkflowTypeOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterWorkflowTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.RegisterWorkflowType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterWorkflowTypeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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
