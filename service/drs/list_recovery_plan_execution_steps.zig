const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListRecoveryPlanExecutionStepsFilter = @import("list_recovery_plan_execution_steps_filter.zig").ListRecoveryPlanExecutionStepsFilter;
const RecoveryPlanExecutionStepSummary = @import("recovery_plan_execution_step_summary.zig").RecoveryPlanExecutionStepSummary;

pub const ListRecoveryPlanExecutionStepsInput = struct {
    /// Filters for listing execution steps.
    filter: ?ListRecoveryPlanExecutionStepsFilter = null,

    /// Maximum number of results to return.
    max_results: ?i32 = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The ARN of the Recovery Plan execution.
    recovery_plan_execution_arn: []const u8,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .recovery_plan_execution_arn = "recoveryPlanExecutionArn",
    };
};

pub const ListRecoveryPlanExecutionStepsOutput = struct {
    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The list of execution steps.
    recovery_plan_execution_steps: ?[]const RecoveryPlanExecutionStepSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .recovery_plan_execution_steps = "recoveryPlanExecutionSteps",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecoveryPlanExecutionStepsInput, options: CallOptions) !ListRecoveryPlanExecutionStepsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecoveryPlanExecutionStepsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListRecoveryPlanExecutionSteps";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"recoveryPlanExecutionArn\":");
    try aws.json.writeValue(@TypeOf(input.recovery_plan_execution_arn), input.recovery_plan_execution_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecoveryPlanExecutionStepsOutput {
    const result: ListRecoveryPlanExecutionStepsOutput = try aws.json.parseJsonObject(
        ListRecoveryPlanExecutionStepsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
