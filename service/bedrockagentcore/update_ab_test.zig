const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ABTestEvaluationConfig = @import("ab_test_evaluation_config.zig").ABTestEvaluationConfig;
const ABTestExecutionStatus = @import("ab_test_execution_status.zig").ABTestExecutionStatus;
const GatewayFilter = @import("gateway_filter.zig").GatewayFilter;
const Variant = @import("variant.zig").Variant;
const ABTestStatus = @import("ab_test_status.zig").ABTestStatus;

pub const UpdateABTestInput = struct {
    /// The unique identifier of the A/B test to update.
    ab_test_id: []const u8,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// The updated description of the A/B test.
    description: ?[]const u8 = null,

    /// The updated evaluation configuration.
    evaluation_config: ?ABTestEvaluationConfig = null,

    /// The updated execution status to enable or disable the A/B test.
    execution_status: ?ABTestExecutionStatus = null,

    /// The updated gateway filter.
    gateway_filter: ?GatewayFilter = null,

    /// The updated name of the A/B test.
    name: ?[]const u8 = null,

    /// The updated IAM role ARN.
    role_arn: ?[]const u8 = null,

    /// The updated list of variants.
    variants: ?[]const Variant = null,

    pub const json_field_names = .{
        .ab_test_id = "abTestId",
        .client_token = "clientToken",
        .description = "description",
        .evaluation_config = "evaluationConfig",
        .execution_status = "executionStatus",
        .gateway_filter = "gatewayFilter",
        .name = "name",
        .role_arn = "roleArn",
        .variants = "variants",
    };
};

pub const UpdateABTestOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated A/B test.
    ab_test_arn: []const u8,

    /// The unique identifier of the updated A/B test.
    ab_test_id: []const u8,

    /// The execution status of the A/B test.
    execution_status: ABTestExecutionStatus,

    /// The status of the A/B test.
    status: ABTestStatus,

    /// The timestamp when the A/B test was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .ab_test_arn = "abTestArn",
        .ab_test_id = "abTestId",
        .execution_status = "executionStatus",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateABTestInput, options: CallOptions) !UpdateABTestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateABTestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/ab-tests/");
    try path_buf.appendSlice(allocator, input.ab_test_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.evaluation_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evaluationConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.gateway_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"gatewayFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.variants) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"variants\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateABTestOutput {
    const result: UpdateABTestOutput = try aws.json.parseJsonObject(
        UpdateABTestOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
