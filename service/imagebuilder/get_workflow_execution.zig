const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowExecutionStatus = @import("workflow_execution_status.zig").WorkflowExecutionStatus;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

pub const GetWorkflowExecutionInput = struct {
    /// Use the unique identifier for a runtime instance of the workflow to get
    /// runtime details.
    workflow_execution_id: []const u8,

    pub const json_field_names = .{
        .workflow_execution_id = "workflowExecutionId",
    };
};

pub const GetWorkflowExecutionOutput = struct {
    /// The timestamp when the specified runtime instance of the workflow finished.
    end_time: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image build version that owns the
    /// specified runtime
    /// instance of the workflow.
    image_build_version_arn: ?[]const u8 = null,

    /// The output message from the specified runtime instance of the workflow, if
    /// applicable.
    message: ?[]const u8 = null,

    /// The name of the parallel group that this runtime instance of the workflow
    /// ran in, if configured. Parallel groups apply only to test workflows.
    parallel_group: ?[]const u8 = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    /// The timestamp when the specified runtime instance of the workflow started.
    start_time: ?[]const u8 = null,

    /// The current runtime status for the specified runtime instance of the
    /// workflow.
    /// `COMPLETED`, `FAILED`, `ROLLBACK_COMPLETED`,
    /// `CANCELLED`, and `SKIPPED` are terminal states.
    status: ?WorkflowExecutionStatus = null,

    /// The total number of steps that the workflow document defines for this
    /// runtime
    /// instance of the workflow. Image Builder sets this count before any steps
    /// run. The sum of
    /// succeeded, skipped, and failed steps only reaches this total if every step
    /// finishes in one of those states.
    total_step_count: ?i32 = null,

    /// A runtime count for the number of steps that failed in the specified runtime
    /// instance
    /// of the workflow.
    total_steps_failed: ?i32 = null,

    /// A runtime count for the number of steps that were skipped in the specified
    /// runtime
    /// instance of the workflow.
    total_steps_skipped: ?i32 = null,

    /// A runtime count for the number of steps that ran successfully in the
    /// specified runtime
    /// instance of the workflow.
    total_steps_succeeded: ?i32 = null,

    /// The type of workflow that Image Builder ran for the specified runtime
    /// instance of the workflow.
    @"type": ?WorkflowType = null,

    /// The Amazon Resource Name (ARN) of the build version for the Image Builder
    /// workflow resource
    /// that defines the specified runtime instance of the workflow.
    workflow_build_version_arn: ?[]const u8 = null,

    /// The unique identifier that Image Builder assigned to keep track of runtime
    /// details
    /// when it ran the workflow.
    workflow_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .image_build_version_arn = "imageBuildVersionArn",
        .message = "message",
        .parallel_group = "parallelGroup",
        .request_id = "requestId",
        .start_time = "startTime",
        .status = "status",
        .total_step_count = "totalStepCount",
        .total_steps_failed = "totalStepsFailed",
        .total_steps_skipped = "totalStepsSkipped",
        .total_steps_succeeded = "totalStepsSucceeded",
        .@"type" = "type",
        .workflow_build_version_arn = "workflowBuildVersionArn",
        .workflow_execution_id = "workflowExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowExecutionInput, options: CallOptions) !GetWorkflowExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetWorkflowExecution";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "workflowExecutionId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.workflow_execution_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowExecutionOutput {
    const result: GetWorkflowExecutionOutput = try aws.json.parseJsonObject(
        GetWorkflowExecutionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
