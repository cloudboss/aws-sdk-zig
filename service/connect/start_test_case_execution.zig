const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestCaseExecutionStatus = @import("test_case_execution_status.zig").TestCaseExecutionStatus;

pub const StartTestCaseExecutionInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The identifier of the Amazon Connect instance.
    instance_id: []const u8,

    /// The identifier of the test case to execute.
    test_case_id: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .instance_id = "InstanceId",
        .test_case_id = "TestCaseId",
    };
};

pub const StartTestCaseExecutionOutput = struct {
    status: ?TestCaseExecutionStatus = null,

    /// The identifier of the test case execution.
    test_case_execution_id: ?[]const u8 = null,

    /// The identifier of the test case resource that was executed.
    test_case_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
        .test_case_execution_id = "TestCaseExecutionId",
        .test_case_id = "TestCaseId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTestCaseExecutionInput, options: CallOptions) !StartTestCaseExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTestCaseExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/test-cases/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.test_case_id);
    try path_buf.appendSlice(allocator, "/start-execution");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTestCaseExecutionOutput {
    var result: StartTestCaseExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartTestCaseExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
