const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ABTestEvaluationConfig = @import("ab_test_evaluation_config.zig").ABTestEvaluationConfig;
const ABTestExecutionStatus = @import("ab_test_execution_status.zig").ABTestExecutionStatus;
const GatewayFilter = @import("gateway_filter.zig").GatewayFilter;
const ABTestResults = @import("ab_test_results.zig").ABTestResults;
const ABTestStatus = @import("ab_test_status.zig").ABTestStatus;
const Variant = @import("variant.zig").Variant;

pub const GetABTestInput = struct {
    /// The unique identifier of the A/B test to retrieve.
    ab_test_id: []const u8,

    pub const json_field_names = .{
        .ab_test_id = "abTestId",
    };
};

pub const GetABTestOutput = struct {
    /// The Amazon Resource Name (ARN) of the A/B test.
    ab_test_arn: []const u8,

    /// The unique identifier of the A/B test.
    ab_test_id: []const u8,

    /// The timestamp when the A/B test was created.
    created_at: i64,

    /// The identifier of the current run of the A/B test.
    current_run_id: ?[]const u8 = null,

    /// The description of the A/B test.
    description: ?[]const u8 = null,

    /// The error details if the A/B test encountered failures.
    error_details: ?[]const []const u8 = null,

    /// The evaluation configuration for measuring variant performance.
    evaluation_config: ?ABTestEvaluationConfig = null,

    /// The execution status indicating whether the A/B test is currently running.
    execution_status: ABTestExecutionStatus,

    /// The Amazon Resource Name (ARN) of the gateway used for traffic splitting.
    gateway_arn: []const u8,

    /// The gateway filter restricting which target paths are included.
    gateway_filter: ?GatewayFilter = null,

    /// The timestamp when the A/B test will automatically expire.
    max_duration_expires_at: ?i64 = null,

    /// The name of the A/B test.
    name: []const u8,

    /// The statistical results of the A/B test, including per-evaluator metrics and
    /// significance analysis.
    results: ?ABTestResults = null,

    /// The IAM role ARN used by the A/B test.
    role_arn: ?[]const u8 = null,

    /// The timestamp when the A/B test was started.
    started_at: ?i64 = null,

    /// The current status of the A/B test.
    status: ABTestStatus,

    /// The timestamp when the A/B test was stopped.
    stopped_at: ?i64 = null,

    /// The timestamp when the A/B test was last updated.
    updated_at: i64,

    /// The list of variants in the A/B test.
    variants: ?[]const Variant = null,

    pub const json_field_names = .{
        .ab_test_arn = "abTestArn",
        .ab_test_id = "abTestId",
        .created_at = "createdAt",
        .current_run_id = "currentRunId",
        .description = "description",
        .error_details = "errorDetails",
        .evaluation_config = "evaluationConfig",
        .execution_status = "executionStatus",
        .gateway_arn = "gatewayArn",
        .gateway_filter = "gatewayFilter",
        .max_duration_expires_at = "maxDurationExpiresAt",
        .name = "name",
        .results = "results",
        .role_arn = "roleArn",
        .started_at = "startedAt",
        .status = "status",
        .stopped_at = "stoppedAt",
        .updated_at = "updatedAt",
        .variants = "variants",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetABTestInput, options: CallOptions) !GetABTestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetABTestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/ab-tests/");
    try path_buf.appendSlice(allocator, input.ab_test_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetABTestOutput {
    var result: GetABTestOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetABTestOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
