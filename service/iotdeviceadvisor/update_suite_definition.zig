const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuiteDefinitionConfiguration = @import("suite_definition_configuration.zig").SuiteDefinitionConfiguration;

pub const UpdateSuiteDefinitionInput = struct {
    /// Updates a Device Advisor test suite with suite definition configuration.
    suite_definition_configuration: SuiteDefinitionConfiguration,

    /// Suite definition ID of the test suite to be updated.
    suite_definition_id: []const u8,

    pub const json_field_names = .{
        .suite_definition_configuration = "suiteDefinitionConfiguration",
        .suite_definition_id = "suiteDefinitionId",
    };
};

pub const UpdateSuiteDefinitionOutput = struct {
    /// Timestamp of when the test suite was created.
    created_at: ?i64 = null,

    /// Timestamp of when the test suite was updated.
    last_updated_at: ?i64 = null,

    /// Amazon Resource Name (ARN) of the updated test suite.
    suite_definition_arn: ?[]const u8 = null,

    /// Suite definition ID of the updated test suite.
    suite_definition_id: ?[]const u8 = null,

    /// Updates the suite definition name. This is a required parameter.
    suite_definition_name: ?[]const u8 = null,

    /// Suite definition version of the updated test suite.
    suite_definition_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .last_updated_at = "lastUpdatedAt",
        .suite_definition_arn = "suiteDefinitionArn",
        .suite_definition_id = "suiteDefinitionId",
        .suite_definition_name = "suiteDefinitionName",
        .suite_definition_version = "suiteDefinitionVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSuiteDefinitionInput, options: CallOptions) !UpdateSuiteDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSuiteDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotdeviceadvisor", "IotDeviceAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/suiteDefinitions/");
    try path_buf.appendSlice(allocator, input.suite_definition_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"suiteDefinitionConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.suite_definition_configuration), input.suite_definition_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSuiteDefinitionOutput {
    const result: UpdateSuiteDefinitionOutput = try aws.json.parseJsonObject(
        UpdateSuiteDefinitionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
