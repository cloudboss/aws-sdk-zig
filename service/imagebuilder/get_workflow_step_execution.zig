const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowStepExecutionRollbackStatus = @import("workflow_step_execution_rollback_status.zig").WorkflowStepExecutionRollbackStatus;
const WorkflowStepExecutionStatus = @import("workflow_step_execution_status.zig").WorkflowStepExecutionStatus;

pub const GetWorkflowStepExecutionInput = struct {
    /// Use the unique identifier for a specific runtime instance of the workflow
    /// step to
    /// get runtime details for that step.
    step_execution_id: []const u8,

    pub const json_field_names = .{
        .step_execution_id = "stepExecutionId",
    };
};

pub const GetWorkflowStepExecutionOutput = struct {
    /// The name of the action that the specified step performs.
    action: ?[]const u8 = null,

    /// Describes the specified workflow step.
    description: ?[]const u8 = null,

    /// The timestamp when the specified runtime instance of the workflow step
    /// finished.
    end_time: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image resource build version that the
    /// specified
    /// runtime instance of the workflow step creates.
    image_build_version_arn: ?[]const u8 = null,

    /// Input parameters that Image Builder provided for the specified runtime
    /// instance of
    /// the workflow step.
    inputs: ?[]const u8 = null,

    /// The output message from the specified runtime instance of the workflow step,
    /// if applicable.
    message: ?[]const u8 = null,

    /// The name of the specified runtime instance of the workflow step.
    name: ?[]const u8 = null,

    /// The action to perform if the workflow step fails.
    on_failure: ?[]const u8 = null,

    /// The file names that the specified runtime version of the workflow step
    /// created as output.
    outputs: ?[]const u8 = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    /// Reports on the rollback status of the specified runtime version of the
    /// workflow step,
    /// if applicable.
    rollback_status: ?WorkflowStepExecutionRollbackStatus = null,

    /// The timestamp when the specified runtime version of the workflow step
    /// started.
    start_time: ?[]const u8 = null,

    /// The current status for the specified runtime version of the workflow step.
    status: ?WorkflowStepExecutionStatus = null,

    /// The unique identifier for the runtime version of the workflow step that you
    /// specified
    /// in the request.
    step_execution_id: ?[]const u8 = null,

    /// The maximum duration in seconds for this step to complete its action.
    timeout_seconds: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the build version for the Image Builder
    /// workflow resource
    /// that defines this workflow step.
    workflow_build_version_arn: ?[]const u8 = null,

    /// The unique identifier that Image Builder assigned to keep track of runtime
    /// details
    /// when it ran the workflow.
    workflow_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .description = "description",
        .end_time = "endTime",
        .image_build_version_arn = "imageBuildVersionArn",
        .inputs = "inputs",
        .message = "message",
        .name = "name",
        .on_failure = "onFailure",
        .outputs = "outputs",
        .request_id = "requestId",
        .rollback_status = "rollbackStatus",
        .start_time = "startTime",
        .status = "status",
        .step_execution_id = "stepExecutionId",
        .timeout_seconds = "timeoutSeconds",
        .workflow_build_version_arn = "workflowBuildVersionArn",
        .workflow_execution_id = "workflowExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowStepExecutionInput, options: CallOptions) !GetWorkflowStepExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowStepExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetWorkflowStepExecution";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "stepExecutionId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.step_execution_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowStepExecutionOutput {
    var result: GetWorkflowStepExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWorkflowStepExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
