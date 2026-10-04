const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecoveryPlanServer = @import("recovery_plan_server.zig").RecoveryPlanServer;
const RecoveryPlanExecutionStepStatus = @import("recovery_plan_execution_step_status.zig").RecoveryPlanExecutionStepStatus;
const RecoveryPlanExecutionStep = @import("recovery_plan_execution_step.zig").RecoveryPlanExecutionStep;

pub const UpdateRecoveryPlanExecutionStepInput = struct {
    /// The ARN of the execution step to update.
    recovery_plan_execution_step_arn: []const u8,

    /// Full replacement of the server list. Only allowed when the step is in
    /// NOT_STARTED status (Server type steps only).
    servers: ?[]const RecoveryPlanServer = null,

    /// Only SKIPPED is accepted. Step must be in NOT_STARTED or FAILED status.
    status: ?RecoveryPlanExecutionStepStatus = null,

    /// Updated wait duration. Only allowed when the step is in NOT_STARTED status
    /// (Wait type steps only).
    wait_duration_minutes: ?i32 = null,

    pub const json_field_names = .{
        .recovery_plan_execution_step_arn = "recoveryPlanExecutionStepArn",
        .servers = "servers",
        .status = "status",
        .wait_duration_minutes = "waitDurationMinutes",
    };
};

pub const UpdateRecoveryPlanExecutionStepOutput = struct {
    recovery_plan_execution_step: ?RecoveryPlanExecutionStep = null,

    pub const json_field_names = .{
        .recovery_plan_execution_step = "recoveryPlanExecutionStep",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRecoveryPlanExecutionStepInput, options: CallOptions) !UpdateRecoveryPlanExecutionStepOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "drs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRecoveryPlanExecutionStepInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateRecoveryPlanExecutionStep";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"recoveryPlanExecutionStepArn\":");
    try aws.json.writeValue(@TypeOf(input.recovery_plan_execution_step_arn), input.recovery_plan_execution_step_arn, allocator, &body_buf);
    has_prev = true;
    if (input.servers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"servers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.wait_duration_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"waitDurationMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRecoveryPlanExecutionStepOutput {
    const result: UpdateRecoveryPlanExecutionStepOutput = try aws.json.parseJsonObject(
        UpdateRecoveryPlanExecutionStepOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
