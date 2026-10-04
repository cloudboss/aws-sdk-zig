const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;
const WorkflowExecutionConfiguration = @import("workflow_execution_configuration.zig").WorkflowExecutionConfiguration;
const WorkflowExecutionInfo = @import("workflow_execution_info.zig").WorkflowExecutionInfo;
const WorkflowExecutionOpenCounts = @import("workflow_execution_open_counts.zig").WorkflowExecutionOpenCounts;

pub const DescribeWorkflowExecutionInput = struct {
    /// The name of the domain containing the workflow execution.
    domain: []const u8,

    /// The workflow execution to describe.
    execution: WorkflowExecution,

    pub const json_field_names = .{
        .domain = "domain",
        .execution = "execution",
    };
};

pub const DescribeWorkflowExecutionOutput = struct {
    /// The configuration settings for this workflow execution including timeout
    /// values, tasklist etc.
    execution_configuration: ?WorkflowExecutionConfiguration = null,

    /// Information about the workflow execution.
    execution_info: ?WorkflowExecutionInfo = null,

    /// The time when the last activity task was scheduled for this workflow
    /// execution. You can use this information to determine if the workflow has not
    /// made progress for an unusually long period of time and might require a
    /// corrective action.
    latest_activity_task_timestamp: ?i64 = null,

    /// The latest executionContext provided by the decider for this workflow
    /// execution. A decider can provide an
    /// executionContext (a free-form string) when closing a decision task using
    /// RespondDecisionTaskCompleted.
    latest_execution_context: ?[]const u8 = null,

    /// The number of tasks for this workflow execution. This includes open and
    /// closed tasks of all types.
    open_counts: ?WorkflowExecutionOpenCounts = null,

    pub const json_field_names = .{
        .execution_configuration = "executionConfiguration",
        .execution_info = "executionInfo",
        .latest_activity_task_timestamp = "latestActivityTaskTimestamp",
        .latest_execution_context = "latestExecutionContext",
        .open_counts = "openCounts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkflowExecutionInput, options: CallOptions) !DescribeWorkflowExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkflowExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.DescribeWorkflowExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkflowExecutionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeWorkflowExecutionOutput, body, allocator);
}
