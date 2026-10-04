const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedReasoningPolicyTestCase = @import("automated_reasoning_policy_test_case.zig").AutomatedReasoningPolicyTestCase;

pub const GetAutomatedReasoningPolicyTestCaseInput = struct {
    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy that
    /// contains the test.
    policy_arn: []const u8,

    /// The unique identifier of the test to retrieve.
    test_case_id: []const u8,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
        .test_case_id = "testCaseId",
    };
};

pub const GetAutomatedReasoningPolicyTestCaseOutput = struct {
    /// The Amazon Resource Name (ARN) of the policy that contains the test.
    policy_arn: []const u8,

    /// The test details including the content, query, expected result, and
    /// metadata.
    test_case: ?AutomatedReasoningPolicyTestCase = null,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
        .test_case = "testCase",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutomatedReasoningPolicyTestCaseInput, options: CallOptions) !GetAutomatedReasoningPolicyTestCaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutomatedReasoningPolicyTestCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/test-cases/");
    try path_buf.appendSlice(allocator, input.test_case_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutomatedReasoningPolicyTestCaseOutput {
    const result: GetAutomatedReasoningPolicyTestCaseOutput = try aws.json.parseJsonObject(
        GetAutomatedReasoningPolicyTestCaseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
