const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartAutomatedReasoningPolicyTestWorkflowInput = struct {
    /// The build workflow identifier. The build workflow must show a `COMPLETED`
    /// status before running tests.
    build_workflow_id: []const u8,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request but doesn't return an error.
    client_request_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy to test.
    policy_arn: []const u8,

    /// The list of test identifiers to run. If not provided, all tests for the
    /// policy are run.
    test_case_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .build_workflow_id = "buildWorkflowId",
        .client_request_token = "clientRequestToken",
        .policy_arn = "policyArn",
        .test_case_ids = "testCaseIds",
    };
};

pub const StartAutomatedReasoningPolicyTestWorkflowOutput = struct {
    /// The Amazon Resource Name (ARN) of the policy for which the test workflow was
    /// started.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAutomatedReasoningPolicyTestWorkflowInput, options: CallOptions) !StartAutomatedReasoningPolicyTestWorkflowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAutomatedReasoningPolicyTestWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/build-workflows/");
    try path_buf.appendSlice(allocator, input.build_workflow_id);
    try path_buf.appendSlice(allocator, "/test-workflows");
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
    if (input.test_case_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"testCaseIds\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAutomatedReasoningPolicyTestWorkflowOutput {
    var result: StartAutomatedReasoningPolicyTestWorkflowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartAutomatedReasoningPolicyTestWorkflowOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
