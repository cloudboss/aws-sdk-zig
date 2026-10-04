const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestExecutionApiMode = @import("test_execution_api_mode.zig").TestExecutionApiMode;
const TestExecutionTarget = @import("test_execution_target.zig").TestExecutionTarget;
const TestExecutionModality = @import("test_execution_modality.zig").TestExecutionModality;
const TestExecutionStatus = @import("test_execution_status.zig").TestExecutionStatus;

pub const DescribeTestExecutionInput = struct {
    /// The execution Id of the test set execution.
    test_execution_id: []const u8,

    pub const json_field_names = .{
        .test_execution_id = "testExecutionId",
    };
};

pub const DescribeTestExecutionOutput = struct {
    /// Indicates whether we use streaming or non-streaming APIs are used for
    /// the test set execution. For streaming, `StartConversation`
    /// Amazon Lex Runtime API is used. Whereas for non-streaming,
    /// `RecognizeUtterance`
    /// and `RecognizeText` Amazon Lex Runtime API is used.
    api_mode: ?TestExecutionApiMode = null,

    /// The execution creation date and time for the test set execution.
    creation_date_time: ?i64 = null,

    /// Reasons for the failure of the test set execution.
    failure_reasons: ?[]const []const u8 = null,

    /// The date and time of the last update for the execution.
    last_updated_date_time: ?i64 = null,

    /// The target bot for the test set execution details.
    target: ?TestExecutionTarget = null,

    /// The execution Id for the test set execution.
    test_execution_id: ?[]const u8 = null,

    /// Indicates whether test set is audio or text.
    test_execution_modality: ?TestExecutionModality = null,

    /// The test execution status for the test execution.
    test_execution_status: ?TestExecutionStatus = null,

    /// The test set Id for the test set execution.
    test_set_id: ?[]const u8 = null,

    /// The test set name of the test set execution.
    test_set_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_mode = "apiMode",
        .creation_date_time = "creationDateTime",
        .failure_reasons = "failureReasons",
        .last_updated_date_time = "lastUpdatedDateTime",
        .target = "target",
        .test_execution_id = "testExecutionId",
        .test_execution_modality = "testExecutionModality",
        .test_execution_status = "testExecutionStatus",
        .test_set_id = "testSetId",
        .test_set_name = "testSetName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTestExecutionInput, options: CallOptions) !DescribeTestExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTestExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/testexecutions/");
    try path_buf.appendSlice(allocator, input.test_execution_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTestExecutionOutput {
    const result: DescribeTestExecutionOutput = try aws.json.parseJsonObject(
        DescribeTestExecutionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
