const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const TaskList = @import("task_list.zig").TaskList;
const HistoryEvent = @import("history_event.zig").HistoryEvent;
const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

pub const PollForDecisionTaskInput = struct {
    /// The name of the domain containing the task lists to poll.
    domain: []const u8,

    /// Identity of the decider making the request, which is recorded in the
    /// DecisionTaskStarted event in the workflow history. This enables diagnostic
    /// tracing when
    /// problems arise. The form of this identity is user defined.
    identity: ?[]const u8 = null,

    /// The maximum number of results that are returned per call.
    /// Use `nextPageToken` to obtain further pages of results.
    ///
    /// This
    /// is an upper limit only; the actual number of results returned per call may
    /// be fewer than the
    /// specified maximum.
    maximum_page_size: ?i32 = null,

    /// If `NextPageToken` is returned there are more results
    /// available. The value of `NextPageToken` is a unique pagination token for
    /// each page. Make the call again using
    /// the returned token to retrieve the next page. Keep all other arguments
    /// unchanged. Each pagination token expires
    /// after 24 hours. Using an expired pagination token will return a `400` error:
    /// "`Specified token has
    /// exceeded its maximum lifetime`".
    ///
    /// The configured `maximumPageSize` determines how many results can be returned
    /// in a single call.
    ///
    /// The `nextPageToken` returned by this action cannot be used with
    /// GetWorkflowExecutionHistory to get the next page. You must call
    /// PollForDecisionTask again (with the `nextPageToken`) to retrieve
    /// the next page of history records. Calling PollForDecisionTask with a
    /// `nextPageToken` doesn't return a new decision task.
    next_page_token: ?[]const u8 = null,

    /// When set to `true`, returns the events in reverse order. By default the
    /// results are returned in ascending order of the `eventTimestamp` of the
    /// events.
    reverse_order: ?bool = null,

    /// When set to `true`, returns the events with `eventTimestamp` greater than or
    /// equal to `eventTimestamp` of the most recent `DecisionTaskStarted` event. By
    /// default, this parameter is set to `false`.
    start_at_previous_started_event: ?bool = null,

    /// Specifies the task list to poll for decision tasks.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    task_list: TaskList,

    pub const json_field_names = .{
        .domain = "domain",
        .identity = "identity",
        .maximum_page_size = "maximumPageSize",
        .next_page_token = "nextPageToken",
        .reverse_order = "reverseOrder",
        .start_at_previous_started_event = "startAtPreviousStartedEvent",
        .task_list = "taskList",
    };
};

pub const PollForDecisionTaskOutput = struct {
    /// A paginated list of history events of the workflow execution. The decider
    /// uses this during the processing of the decision task.
    events: ?[]const HistoryEvent = null,

    /// If a `NextPageToken` was returned by a previous call, there are more
    /// results available. To retrieve the next page of results, make the call again
    /// using the returned token in
    /// `nextPageToken`. Keep all other arguments unchanged.
    ///
    /// The configured `maximumPageSize` determines how many results can be returned
    /// in a single call.
    next_page_token: ?[]const u8 = null,

    /// The ID of the DecisionTaskStarted event of the previous decision task of
    /// this workflow execution that was processed by the decider. This can be used
    /// to determine the events in the history new since the last decision task
    /// received by the decider.
    previous_started_event_id: ?i64 = null,

    /// The ID of the `DecisionTaskStarted` event recorded in the history.
    started_event_id: ?i64 = null,

    /// The opaque string used as a handle on the task. This token is used by
    /// workers to communicate progress and response information back to the system
    /// about the task.
    task_token: []const u8,

    /// The workflow execution for which this decision task was created.
    workflow_execution: ?WorkflowExecution = null,

    /// The type of the workflow execution for which this decision task was created.
    workflow_type: ?WorkflowType = null,

    pub const json_field_names = .{
        .events = "events",
        .next_page_token = "nextPageToken",
        .previous_started_event_id = "previousStartedEventId",
        .started_event_id = "startedEventId",
        .task_token = "taskToken",
        .workflow_execution = "workflowExecution",
        .workflow_type = "workflowType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PollForDecisionTaskInput, options: CallOptions) !PollForDecisionTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PollForDecisionTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.PollForDecisionTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PollForDecisionTaskOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PollForDecisionTaskOutput, body, allocator);
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
