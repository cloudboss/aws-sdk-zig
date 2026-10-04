const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedReasoningCheckResult = @import("automated_reasoning_check_result.zig").AutomatedReasoningCheckResult;

pub const UpdateAutomatedReasoningPolicyTestCaseInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error.
    client_request_token: ?[]const u8 = null,

    /// The updated minimum confidence level for logic validation. If null is
    /// provided, the threshold will be removed.
    confidence_threshold: ?f64 = null,

    /// The updated expected result of the Automated Reasoning check.
    expected_aggregated_findings_result: AutomatedReasoningCheckResult,

    /// The updated content to be validated by the Automated Reasoning policy.
    guard_content: []const u8,

    /// The timestamp when the test was last updated. This is used as a concurrency
    /// token to prevent conflicting modifications.
    last_updated_at: i64,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy that
    /// contains the test.
    policy_arn: []const u8,

    /// The updated input query or prompt that generated the content.
    query_content: ?[]const u8 = null,

    /// The unique identifier of the test to update.
    test_case_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .confidence_threshold = "confidenceThreshold",
        .expected_aggregated_findings_result = "expectedAggregatedFindingsResult",
        .guard_content = "guardContent",
        .last_updated_at = "lastUpdatedAt",
        .policy_arn = "policyArn",
        .query_content = "queryContent",
        .test_case_id = "testCaseId",
    };
};

pub const UpdateAutomatedReasoningPolicyTestCaseOutput = struct {
    /// The Amazon Resource Name (ARN) of the policy that contains the updated test.
    policy_arn: []const u8,

    /// The unique identifier of the updated test.
    test_case_id: []const u8,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
        .test_case_id = "testCaseId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAutomatedReasoningPolicyTestCaseInput, options: CallOptions) !UpdateAutomatedReasoningPolicyTestCaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAutomatedReasoningPolicyTestCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/test-cases/");
    try path_buf.appendSlice(allocator, input.test_case_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.confidence_threshold) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"confidenceThreshold\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"expectedAggregatedFindingsResult\":");
    try aws.json.writeValue(@TypeOf(input.expected_aggregated_findings_result), input.expected_aggregated_findings_result, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"guardContent\":");
    try aws.json.writeValue(@TypeOf(input.guard_content), input.guard_content, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"lastUpdatedAt\":");
    try aws.json.writeValue(@TypeOf(input.last_updated_at), input.last_updated_at, allocator, &body_buf);
    has_prev = true;
    if (input.query_content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryContent\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAutomatedReasoningPolicyTestCaseOutput {
    const result: UpdateAutomatedReasoningPolicyTestCaseOutput = try aws.json.parseJsonObject(
        UpdateAutomatedReasoningPolicyTestCaseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
