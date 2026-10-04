const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuiteRunConfiguration = @import("suite_run_configuration.zig").SuiteRunConfiguration;

pub const StartSuiteRunInput = struct {
    /// Suite definition ID of the test suite.
    suite_definition_id: []const u8,

    /// Suite definition version of the test suite.
    suite_definition_version: ?[]const u8 = null,

    /// Suite run configuration.
    suite_run_configuration: SuiteRunConfiguration,

    /// The tags to be attached to the suite run.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .suite_definition_id = "suiteDefinitionId",
        .suite_definition_version = "suiteDefinitionVersion",
        .suite_run_configuration = "suiteRunConfiguration",
        .tags = "tags",
    };
};

pub const StartSuiteRunOutput = struct {
    /// Starts a Device Advisor test suite run based on suite create time.
    created_at: ?i64 = null,

    /// The response of an Device Advisor test endpoint.
    endpoint: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the started suite run.
    suite_run_arn: ?[]const u8 = null,

    /// Suite Run ID of the started suite run.
    suite_run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .endpoint = "endpoint",
        .suite_run_arn = "suiteRunArn",
        .suite_run_id = "suiteRunId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSuiteRunInput, options: CallOptions) !StartSuiteRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSuiteRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotdeviceadvisor", "IotDeviceAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/suiteDefinitions/");
    try path_buf.appendSlice(allocator, input.suite_definition_id);
    try path_buf.appendSlice(allocator, "/suiteRuns");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.suite_definition_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"suiteDefinitionVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"suiteRunConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.suite_run_configuration), input.suite_run_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSuiteRunOutput {
    var result: StartSuiteRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartSuiteRunOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
