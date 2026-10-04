const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ABTestEvaluationConfig = @import("ab_test_evaluation_config.zig").ABTestEvaluationConfig;
const GatewayFilter = @import("gateway_filter.zig").GatewayFilter;
const Variant = @import("variant.zig").Variant;
const ABTestExecutionStatus = @import("ab_test_execution_status.zig").ABTestExecutionStatus;
const ABTestStatus = @import("ab_test_status.zig").ABTestStatus;

pub const CreateABTestInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// The description of the A/B test.
    description: ?[]const u8 = null,

    /// Whether to enable the A/B test immediately upon creation. If true, traffic
    /// splitting begins automatically.
    enable_on_create: ?bool = null,

    /// The evaluation configuration specifying which online evaluation
    /// configurations to use for measuring variant performance.
    evaluation_config: ABTestEvaluationConfig,

    /// The Amazon Resource Name (ARN) of the gateway to use for traffic splitting.
    gateway_arn: []const u8,

    /// Optional filter to restrict which gateway target paths are included in the
    /// A/B test.
    gateway_filter: ?GatewayFilter = null,

    /// The name of the A/B test. Must be unique within your account.
    name: []const u8,

    /// The IAM role ARN that grants permissions for the A/B test to access gateway
    /// and evaluation resources.
    role_arn: []const u8,

    /// The list of variants for the A/B test. Must contain exactly two variants: a
    /// control (C) and a treatment (T1), each with a configuration bundle or target
    /// reference and a traffic weight.
    variants: []const Variant,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .enable_on_create = "enableOnCreate",
        .evaluation_config = "evaluationConfig",
        .gateway_arn = "gatewayArn",
        .gateway_filter = "gatewayFilter",
        .name = "name",
        .role_arn = "roleArn",
        .variants = "variants",
    };
};

pub const CreateABTestOutput = struct {
    /// The Amazon Resource Name (ARN) of the created A/B test.
    ab_test_arn: []const u8,

    /// The unique identifier of the created A/B test.
    ab_test_id: []const u8,

    /// The timestamp when the A/B test was created.
    created_at: i64,

    /// The execution status indicating whether the A/B test is currently running.
    execution_status: ABTestExecutionStatus,

    /// The name of the A/B test.
    name: ?[]const u8 = null,

    /// The status of the A/B test.
    status: ABTestStatus,

    pub const json_field_names = .{
        .ab_test_arn = "abTestArn",
        .ab_test_id = "abTestId",
        .created_at = "createdAt",
        .execution_status = "executionStatus",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateABTestInput, options: CallOptions) !CreateABTestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateABTestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ab-tests";

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
    if (input.enable_on_create) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableOnCreate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"evaluationConfig\":");
    try aws.json.writeValue(@TypeOf(input.evaluation_config), input.evaluation_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"gatewayArn\":");
    try aws.json.writeValue(@TypeOf(input.gateway_arn), input.gateway_arn, allocator, &body_buf);
    has_prev = true;
    if (input.gateway_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"gatewayFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"variants\":");
    try aws.json.writeValue(@TypeOf(input.variants), input.variants, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateABTestOutput {
    var result: CreateABTestOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateABTestOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
