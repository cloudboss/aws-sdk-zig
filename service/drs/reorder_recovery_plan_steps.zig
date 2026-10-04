const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecoveryPlanStep = @import("recovery_plan_step.zig").RecoveryPlanStep;

pub const ReorderRecoveryPlanStepsInput = struct {
    /// Ordered list of all step ARNs representing the desired sequence.
    ordered_step_arns: []const []const u8,

    /// The ARN of the Recovery Plan.
    recovery_plan_arn: []const u8,

    pub const json_field_names = .{
        .ordered_step_arns = "orderedStepArns",
        .recovery_plan_arn = "recoveryPlanArn",
    };
};

pub const ReorderRecoveryPlanStepsOutput = struct {
    /// The steps with updated order.
    recovery_plan_steps: ?[]const RecoveryPlanStep = null,

    pub const json_field_names = .{
        .recovery_plan_steps = "recoveryPlanSteps",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReorderRecoveryPlanStepsInput, options: CallOptions) !ReorderRecoveryPlanStepsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ReorderRecoveryPlanStepsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ReorderRecoveryPlanSteps";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"orderedStepArns\":");
    try aws.json.writeValue(@TypeOf(input.ordered_step_arns), input.ordered_step_arns, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"recoveryPlanArn\":");
    try aws.json.writeValue(@TypeOf(input.recovery_plan_arn), input.recovery_plan_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReorderRecoveryPlanStepsOutput {
    const result: ReorderRecoveryPlanStepsOutput = try aws.json.parseJsonObject(
        ReorderRecoveryPlanStepsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
