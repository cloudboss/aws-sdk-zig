const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedReasoningPolicyTestResult = @import("automated_reasoning_policy_test_result.zig").AutomatedReasoningPolicyTestResult;

pub const ListAutomatedReasoningPolicyTestResultsInput = struct {
    /// The unique identifier of the build workflow whose test results you want to
    /// list.
    build_workflow_id: []const u8,

    /// The maximum number of test results to return in a single response. Valid
    /// range is 1-100.
    max_results: ?i32 = null,

    /// A pagination token from a previous request to continue listing test results
    /// from where the previous request left off.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy whose test
    /// results you want to list.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .build_workflow_id = "buildWorkflowId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .policy_arn = "policyArn",
    };
};

pub const ListAutomatedReasoningPolicyTestResultsOutput = struct {
    /// A pagination token to use in subsequent requests to retrieve additional test
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of test results, each containing information about how the policy
    /// performed on specific test scenarios.
    test_results: ?[]const AutomatedReasoningPolicyTestResult = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .test_results = "testResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAutomatedReasoningPolicyTestResultsInput, options: CallOptions) !ListAutomatedReasoningPolicyTestResultsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAutomatedReasoningPolicyTestResultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/build-workflows/");
    try path_buf.appendSlice(allocator, input.build_workflow_id);
    try path_buf.appendSlice(allocator, "/test-results");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAutomatedReasoningPolicyTestResultsOutput {
    var result: ListAutomatedReasoningPolicyTestResultsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAutomatedReasoningPolicyTestResultsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
