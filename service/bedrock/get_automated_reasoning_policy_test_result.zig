const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedReasoningPolicyTestResult = @import("automated_reasoning_policy_test_result.zig").AutomatedReasoningPolicyTestResult;

pub const GetAutomatedReasoningPolicyTestResultInput = struct {
    /// The build workflow identifier. The build workflow must display a `COMPLETED`
    /// status to get results.
    build_workflow_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy.
    policy_arn: []const u8,

    /// The unique identifier of the test for which to retrieve results.
    test_case_id: []const u8,

    pub const json_field_names = .{
        .build_workflow_id = "buildWorkflowId",
        .policy_arn = "policyArn",
        .test_case_id = "testCaseId",
    };
};

pub const GetAutomatedReasoningPolicyTestResultOutput = struct {
    /// The test result containing validation findings, execution status, and
    /// detailed analysis.
    test_result: ?AutomatedReasoningPolicyTestResult = null,

    pub const json_field_names = .{
        .test_result = "testResult",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutomatedReasoningPolicyTestResultInput, options: CallOptions) !GetAutomatedReasoningPolicyTestResultOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutomatedReasoningPolicyTestResultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/build-workflows/");
    try path_buf.appendSlice(allocator, input.build_workflow_id);
    try path_buf.appendSlice(allocator, "/test-cases/");
    try path_buf.appendSlice(allocator, input.test_case_id);
    try path_buf.appendSlice(allocator, "/test-results");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutomatedReasoningPolicyTestResultOutput {
    const result: GetAutomatedReasoningPolicyTestResultOutput = try aws.json.parseJsonObject(
        GetAutomatedReasoningPolicyTestResultOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
