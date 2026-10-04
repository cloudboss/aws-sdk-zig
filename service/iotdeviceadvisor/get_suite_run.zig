const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuiteRunStatus = @import("suite_run_status.zig").SuiteRunStatus;
const SuiteRunConfiguration = @import("suite_run_configuration.zig").SuiteRunConfiguration;
const TestResult = @import("test_result.zig").TestResult;

pub const GetSuiteRunInput = struct {
    /// Suite definition ID for the test suite run.
    suite_definition_id: []const u8,

    /// Suite run ID for the test suite run.
    suite_run_id: []const u8,

    pub const json_field_names = .{
        .suite_definition_id = "suiteDefinitionId",
        .suite_run_id = "suiteRunId",
    };
};

pub const GetSuiteRunOutput = struct {
    /// Date (in Unix epoch time) when the test suite run ended.
    end_time: ?i64 = null,

    /// Error reason for any test suite run failure.
    error_reason: ?[]const u8 = null,

    /// Date (in Unix epoch time) when the test suite run started.
    start_time: ?i64 = null,

    /// Status for the test suite run.
    status: ?SuiteRunStatus = null,

    /// Suite definition ID for the test suite run.
    suite_definition_id: ?[]const u8 = null,

    /// Suite definition version for the test suite run.
    suite_definition_version: ?[]const u8 = null,

    /// The ARN of the suite run.
    suite_run_arn: ?[]const u8 = null,

    /// Suite run configuration for the test suite run.
    suite_run_configuration: ?SuiteRunConfiguration = null,

    /// Suite run ID for the test suite run.
    suite_run_id: ?[]const u8 = null,

    /// The tags attached to the suite run.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Test results for the test suite run.
    test_result: ?TestResult = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .error_reason = "errorReason",
        .start_time = "startTime",
        .status = "status",
        .suite_definition_id = "suiteDefinitionId",
        .suite_definition_version = "suiteDefinitionVersion",
        .suite_run_arn = "suiteRunArn",
        .suite_run_configuration = "suiteRunConfiguration",
        .suite_run_id = "suiteRunId",
        .tags = "tags",
        .test_result = "testResult",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSuiteRunInput, options: CallOptions) !GetSuiteRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotdeviceadvisor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSuiteRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotdeviceadvisor", "IotDeviceAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/suiteDefinitions/");
    try path_buf.appendSlice(allocator, input.suite_definition_id);
    try path_buf.appendSlice(allocator, "/suiteRuns/");
    try path_buf.appendSlice(allocator, input.suite_run_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSuiteRunOutput {
    var result: GetSuiteRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSuiteRunOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
