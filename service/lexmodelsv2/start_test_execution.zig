const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestExecutionApiMode = @import("test_execution_api_mode.zig").TestExecutionApiMode;
const TestExecutionTarget = @import("test_execution_target.zig").TestExecutionTarget;
const TestExecutionModality = @import("test_execution_modality.zig").TestExecutionModality;

pub const StartTestExecutionInput = struct {
    /// Indicates whether we use streaming or non-streaming APIs for the test set
    /// execution. For streaming, StartConversation Runtime API is used. Whereas,
    /// for
    /// non-streaming, RecognizeUtterance and RecognizeText Amazon Lex
    /// Runtime API are used.
    api_mode: TestExecutionApiMode,

    /// The target bot for the test set execution.
    target: TestExecutionTarget,

    /// Indicates whether audio or text is used.
    test_execution_modality: ?TestExecutionModality = null,

    /// The test set Id for the test set execution.
    test_set_id: []const u8,

    pub const json_field_names = .{
        .api_mode = "apiMode",
        .target = "target",
        .test_execution_modality = "testExecutionModality",
        .test_set_id = "testSetId",
    };
};

pub const StartTestExecutionOutput = struct {
    /// Indicates whether we use streaming or non-streaming APIs for the test set
    /// execution. For streaming, StartConversation Amazon Lex Runtime API is used.
    /// Whereas
    /// for non-streaming, RecognizeUtterance and RecognizeText Amazon Lex Runtime
    /// API are used.
    api_mode: ?TestExecutionApiMode = null,

    /// The creation date and time for the test set execution.
    creation_date_time: ?i64 = null,

    /// The target bot for the test set execution.
    target: ?TestExecutionTarget = null,

    /// The unique identifier of the test set execution.
    test_execution_id: ?[]const u8 = null,

    /// Indicates whether audio or text is used.
    test_execution_modality: ?TestExecutionModality = null,

    /// The test set Id for the test set execution.
    test_set_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_mode = "apiMode",
        .creation_date_time = "creationDateTime",
        .target = "target",
        .test_execution_id = "testExecutionId",
        .test_execution_modality = "testExecutionModality",
        .test_set_id = "testSetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTestExecutionInput, options: CallOptions) !StartTestExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTestExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/testsets/");
    try path_buf.appendSlice(allocator, input.test_set_id);
    try path_buf.appendSlice(allocator, "/testexecutions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"apiMode\":");
    try aws.json.writeValue(@TypeOf(input.api_mode), input.api_mode, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"target\":");
    try aws.json.writeValue(@TypeOf(input.target), input.target, allocator, &body_buf);
    has_prev = true;
    if (input.test_execution_modality) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"testExecutionModality\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTestExecutionOutput {
    var result: StartTestExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartTestExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
