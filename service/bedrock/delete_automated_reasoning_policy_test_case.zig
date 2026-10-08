const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteAutomatedReasoningPolicyTestCaseInput = struct {
    /// The timestamp when the test was last updated. This is used as a concurrency
    /// token to prevent conflicting modifications.
    last_updated_at: i64,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy that
    /// contains the test.
    policy_arn: []const u8,

    /// The unique identifier of the test to delete.
    test_case_id: []const u8,

    pub const json_field_names = .{
        .last_updated_at = "lastUpdatedAt",
        .policy_arn = "policyArn",
        .test_case_id = "testCaseId",
    };
};

pub const DeleteAutomatedReasoningPolicyTestCaseOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAutomatedReasoningPolicyTestCaseInput, options: CallOptions) !DeleteAutomatedReasoningPolicyTestCaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAutomatedReasoningPolicyTestCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/test-cases/");
    try path_buf.appendSlice(allocator, input.test_case_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "updatedAt=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.last_updated_at}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAutomatedReasoningPolicyTestCaseOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteAutomatedReasoningPolicyTestCaseOutput = .{};

    return result;
}
