const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ChildPolicy = @import("child_policy.zig").ChildPolicy;
const TaskList = @import("task_list.zig").TaskList;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

pub const StartWorkflowExecutionInput = struct {
    /// If set, specifies the policy to use for the child workflow executions of
    /// this workflow
    /// execution if it is terminated, by calling the TerminateWorkflowExecution
    /// action explicitly or due to an expired timeout. This policy overrides the
    /// default child policy
    /// specified when registering the workflow type using RegisterWorkflowType.
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
    ///
    /// A child policy for this workflow execution must be specified either as a
    /// default for
    /// the workflow type or through this parameter. If neither this parameter is
    /// set nor a default
    /// child policy was specified at registration time then a fault is returned.
    child_policy: ?ChildPolicy = null,

    /// The name of the domain in which the workflow execution is created.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    domain: []const u8,

    /// The total duration for this workflow execution. This overrides the
    /// defaultExecutionStartToCloseTimeout specified when registering the workflow
    /// type.
    ///
    /// The duration is specified in seconds; an integer greater than or equal to
    /// `0`. Exceeding this limit causes the workflow execution to time out. Unlike
    /// some
    /// of the other timeout parameters in Amazon SWF, you cannot specify a value of
    /// "NONE" for this
    /// timeout; there is a one-year max limit on the time that a workflow execution
    /// can
    /// run.
    ///
    /// An execution start-to-close timeout must be specified either through this
    /// parameter
    /// or as a default when the workflow type is registered. If neither this
    /// parameter nor a
    /// default execution start-to-close timeout is specified, a fault is returned.
    execution_start_to_close_timeout: ?[]const u8 = null,

    /// The input for the workflow execution. This is a free form string which
    /// should be
    /// meaningful to the workflow you are starting. This `input` is made available
    /// to the
    /// new workflow execution in the `WorkflowExecutionStarted` history event.
    input: ?[]const u8 = null,

    /// The IAM role to attach to this workflow execution.
    ///
    /// Executions of this workflow type need IAM roles to invoke Lambda functions.
    /// If you
    /// don't attach an IAM role, any attempt to schedule a Lambda task fails. This
    /// results in a
    /// `ScheduleLambdaFunctionFailed` history event. For more information, see
    /// [https://docs.aws.amazon.com/amazonswf/latest/developerguide/lambda-task.html](https://docs.aws.amazon.com/amazonswf/latest/developerguide/lambda-task.html) in the
    /// *Amazon SWF Developer Guide*.
    lambda_role: ?[]const u8 = null,

    /// The list of tags to associate with the workflow execution. You can specify a
    /// maximum of
    /// 5 tags. You can list workflow executions with a specific tag by calling
    /// ListOpenWorkflowExecutions or ListClosedWorkflowExecutions and
    /// specifying a TagFilter.
    tag_list: ?[]const []const u8 = null,

    /// The task list to use for the decision tasks generated for this workflow
    /// execution. This
    /// overrides the `defaultTaskList` specified when registering the workflow
    /// type.
    ///
    /// A task list for this workflow execution must be specified either as a
    /// default for the
    /// workflow type or through this parameter. If neither this parameter is set
    /// nor a default task
    /// list was specified at registration time then a fault is returned.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    task_list: ?TaskList = null,

    /// The task priority to use for this workflow execution. This overrides any
    /// default
    /// priority that was assigned when the workflow type was registered. If not
    /// set, then the default
    /// task priority for the workflow type is used. Valid values are integers that
    /// range from Java's
    /// `Integer.MIN_VALUE` (-2147483648) to `Integer.MAX_VALUE` (2147483647).
    /// Higher numbers indicate higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *Amazon SWF Developer Guide*.
    task_priority: ?[]const u8 = null,

    /// Specifies the maximum duration of decision tasks for this workflow
    /// execution. This
    /// parameter overrides the `defaultTaskStartToCloseTimout` specified when
    /// registering
    /// the workflow type using RegisterWorkflowType.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    ///
    /// A task start-to-close timeout for this workflow execution must be specified
    /// either as
    /// a default for the workflow type or through this parameter. If neither this
    /// parameter is set
    /// nor a default task start-to-close timeout was specified at registration time
    /// then a fault is
    /// returned.
    task_start_to_close_timeout: ?[]const u8 = null,

    /// The user defined identifier associated with the workflow execution. You can
    /// use this to
    /// associate a custom identifier with the workflow execution. You may specify
    /// the same identifier
    /// if a workflow execution is logically a *restart* of a previous execution.
    /// You cannot have two open workflow executions with the same `workflowId` at
    /// the same
    /// time within the same domain.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    workflow_id: []const u8,

    /// The type of the workflow to start.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .child_policy = "childPolicy",
        .domain = "domain",
        .execution_start_to_close_timeout = "executionStartToCloseTimeout",
        .input = "input",
        .lambda_role = "lambdaRole",
        .tag_list = "tagList",
        .task_list = "taskList",
        .task_priority = "taskPriority",
        .task_start_to_close_timeout = "taskStartToCloseTimeout",
        .workflow_id = "workflowId",
        .workflow_type = "workflowType",
    };
};

pub const StartWorkflowExecutionOutput = struct {
    /// The `runId` of a workflow execution. This ID is generated by the service and
    /// can be used to uniquely identify the workflow execution within a domain.
    run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .run_id = "runId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartWorkflowExecutionInput, options: CallOptions) !StartWorkflowExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartWorkflowExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.StartWorkflowExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartWorkflowExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartWorkflowExecutionOutput, body, allocator);
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
