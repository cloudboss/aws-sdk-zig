const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotdeviceadvisor");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSuiteDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotdeviceadvisor", "IotDeviceAdvisor", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/suiteDefinitions/");
    try path_buf.appendSlice(allocator, input.suite_definition_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"suiteDefinitionConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.suite_definition_configuration), input.suite_definition_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSuiteDefinitionOutput {
    var result: UpdateSuiteDefinitionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSuiteDefinitionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
