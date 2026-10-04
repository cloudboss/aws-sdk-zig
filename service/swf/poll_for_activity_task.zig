const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
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
