const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChildPolicy = @import("child_policy.zig").ChildPolicy;

pub const TerminateWorkflowExecutionInput = struct {
    /// If set, specifies the policy to use for the child workflow executions of the
    /// workflow
    /// execution being terminated. This policy overrides the child policy specified
    /// for the workflow
    /// execution at registration time or when starting the execution.
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

    /// Details for terminating the workflow execution.
    details: ?[]const u8 = null,

    /// The domain of the workflow execution to terminate.
    domain: []const u8,

    /// A descriptive reason for terminating the workflow execution.
    reason: ?[]const u8 = null,

    /// The runId of the workflow execution to terminate.
    run_id: ?[]const u8 = null,

    /// The workflowId of the workflow execution to terminate.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .child_policy = "childPolicy",
        .details = "details",
        .domain = "domain",
        .reason = "reason",
        .run_id = "runId",
        .workflow_id = "workflowId",
    };
};

pub const TerminateWorkflowExecutionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TerminateWorkflowExecutionInput, options: CallOptions) !TerminateWorkflowExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TerminateWorkflowExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.TerminateWorkflowExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TerminateWorkflowExecutionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
