const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ObservationSummary = @import("observation_summary.zig").ObservationSummary;
const TestCaseExecutionStatus = @import("test_case_execution_status.zig").TestCaseExecutionStatus;

pub const GetTestCaseExecutionSummaryInput = struct {
    /// The identifier of the Amazon Connect instance.
    instance_id: []const u8,

    /// The identifier of the test case execution.
    test_case_execution_id: []const u8,

    /// The identifier of the test case.
    test_case_id: []const u8,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .test_case_execution_id = "TestCaseExecutionId",
        .test_case_id = "TestCaseId",
    };
};

pub const GetTestCaseExecutionSummaryOutput = struct {
    /// The timestamp when the test case execution ended.
    end_time: ?i64 = null,

    /// Summary statistics for the test case execution.
    observation_summary: ?ObservationSummary = null,

    /// The timestamp when the test case execution started.
    start_time: ?i64 = null,

    /// The status of the test case execution.
    status: ?TestCaseExecutionStatus = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .observation_summary = "ObservationSummary",
        .start_time = "StartTime",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTestCaseExecutionSummaryInput, options: CallOptions) !GetTestCaseExecutionSummaryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTestCaseExecutionSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/test-cases/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.test_case_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.test_case_execution_id);
    try path_buf.appendSlice(allocator, "/summary");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTestCaseExecutionSummaryOutput {
    var result: GetTestCaseExecutionSummaryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTestCaseExecutionSummaryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
