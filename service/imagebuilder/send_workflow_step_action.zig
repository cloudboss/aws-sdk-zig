const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowStepActionType = @import("workflow_step_action_type.zig").WorkflowStepActionType;

pub const SendWorkflowStepActionInput = struct {
    /// The action to perform on the paused workflow step.
    /// `RESUME` completes the waiting step, and the workflow continues.
    /// `STOP` fails the step, and the step's `onFailure`
    /// setting determines whether the workflow continues or aborts. The workflow
    /// step must be in a waiting state to accept an action. The request fails if
    /// the step has already timed out or been actioned.
    action: WorkflowStepActionType,

    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// The Amazon Resource Name (ARN) of the image build version associated with
    /// the workflow
    /// step execution. This value must match the image that owns the waiting step.
    /// If the ARN does not correspond to the image running the workflow,
    /// then the request fails with a validation error.
    image_build_version_arn: []const u8,

    /// The reason for the action. This value is stored with the step
    /// execution record and is accessible in subsequent workflow steps
    /// via step output references.
    reason: ?[]const u8 = null,

    /// Uniquely identifies the waiting workflow step that you send the action to.
    /// To get this identifier, call ListWaitingWorkflowSteps.
    step_execution_id: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .client_token = "clientToken",
        .image_build_version_arn = "imageBuildVersionArn",
        .reason = "reason",
        .step_execution_id = "stepExecutionId",
    };
};

pub const SendWorkflowStepActionOutput = struct {
    /// The client token that uniquely identifies the request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image build version that received the
    /// action
    /// request.
    image_build_version_arn: ?[]const u8 = null,

    /// The unique identifier for the workflow step that received the action, as
    /// specified in the request.
    step_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .image_build_version_arn = "imageBuildVersionArn",
        .step_execution_id = "stepExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendWorkflowStepActionInput, options: CallOptions) !SendWorkflowStepActionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendWorkflowStepActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/SendWorkflowStepAction";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"imageBuildVersionArn\":");
    try aws.json.writeValue(@TypeOf(input.image_build_version_arn), input.image_build_version_arn, allocator, &body_buf);
    has_prev = true;
    if (input.reason) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reason\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"stepExecutionId\":");
    try aws.json.writeValue(@TypeOf(input.step_execution_id), input.step_execution_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendWorkflowStepActionOutput {
    const result: SendWorkflowStepActionOutput = try aws.json.parseJsonObject(
        SendWorkflowStepActionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
