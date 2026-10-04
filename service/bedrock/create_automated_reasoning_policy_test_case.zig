const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedReasoningCheckResult = @import("automated_reasoning_check_result.zig").AutomatedReasoningCheckResult;

pub const CreateAutomatedReasoningPolicyTestCaseInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error.
    client_request_token: ?[]const u8 = null,

    /// The minimum confidence level for logic validation. Content that meets the
    /// threshold is considered a high-confidence finding that can be validated.
    confidence_threshold: ?f64 = null,

    /// The expected result of the Automated Reasoning check. Valid values include:
    /// , TOO_COMPLEX, and NO_TRANSLATIONS.
    ///
    /// * `VALID` - The claims are true. The claims are implied by the premises and
    ///   the Automated Reasoning policy. Given the Automated Reasoning policy and
    ///   premises, it is not possible for these claims to be false. In other words,
    ///   there are no alternative answers that are true that contradict the claims.
    /// * `INVALID` - The claims are false. The claims are not implied by the
    ///   premises and Automated Reasoning policy. Furthermore, there exists
    ///   different claims that are consistent with the premises and Automated
    ///   Reasoning policy.
    /// * `SATISFIABLE` - The claims can be true or false. It depends on what
    ///   assumptions are made for the claim to be implied from the premises and
    ///   Automated Reasoning policy rules. In this situation, different assumptions
    ///   can make input claims false and alternative claims true.
    /// * `IMPOSSIBLE` - Automated Reasoning can’t make a statement about the
    ///   claims. This can happen if the premises are logically incorrect, or if
    ///   there is a conflict within the Automated Reasoning policy itself.
    /// * `TRANSLATION_AMBIGUOUS` - Detected an ambiguity in the translation meant
    ///   it would be unsound to continue with validity checking. Additional context
    ///   or follow-up questions might be needed to get translation to succeed.
    /// * `TOO_COMPLEX` - The input contains too much information for Automated
    ///   Reasoning to process within its latency limits.
    /// * `NO_TRANSLATIONS` - Identifies that some or all of the input prompt wasn't
    ///   translated into logic. This can happen if the input isn't relevant to the
    ///   Automated Reasoning policy, or if the policy doesn't have variables to
    ///   model relevant input. If Automated Reasoning can't translate anything, you
    ///   get a single `NO_TRANSLATIONS` finding. You might also see a
    ///   `NO_TRANSLATIONS` (along with other findings) if some part of the
    ///   validation isn't translated.
    expected_aggregated_findings_result: AutomatedReasoningCheckResult,

    /// The output content that's validated by the Automated Reasoning policy. This
    /// represents the foundation model response that will be checked for accuracy.
    guard_content: []const u8,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy for which
    /// to create the test.
    policy_arn: []const u8,

    /// The input query or prompt that generated the content. This provides context
    /// for the validation.
    query_content: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .confidence_threshold = "confidenceThreshold",
        .expected_aggregated_findings_result = "expectedAggregatedFindingsResult",
        .guard_content = "guardContent",
        .policy_arn = "policyArn",
        .query_content = "queryContent",
    };
};

pub const CreateAutomatedReasoningPolicyTestCaseOutput = struct {
    /// The Amazon Resource Name (ARN) of the policy for which the test was created.
    policy_arn: []const u8,

    /// The unique identifier of the created test.
    test_case_id: []const u8,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
        .test_case_id = "testCaseId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutomatedReasoningPolicyTestCaseInput, options: CallOptions) !CreateAutomatedReasoningPolicyTestCaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAutomatedReasoningPolicyTestCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/test-cases");
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
    if (input.query_content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryContent\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAutomatedReasoningPolicyTestCaseOutput {
    var result: CreateAutomatedReasoningPolicyTestCaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAutomatedReasoningPolicyTestCaseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
