const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const StatusSummary = @import("status_summary.zig").StatusSummary;

pub const GetConfigurationInput = struct {
    /// A service generated identifier for the configuration.
    configuration_id: []const u8,

    pub const json_field_names = .{
        .configuration_id = "ConfigurationId",
    };
};

pub const GetConfigurationOutput = struct {
    /// The ID of the Amazon Web Services account where the configuration was
    /// deployed.
    account: ?[]const u8 = null,

    /// The ID of the configuration definition.
    configuration_definition_id: ?[]const u8 = null,

    /// The datetime stamp when the configuration manager was created.
    created_at: ?i64 = null,

    /// A service generated identifier for the configuration.
    id: ?[]const u8 = null,

    /// The datetime stamp when the configuration manager was last updated.
    last_modified_at: ?i64 = null,

    /// The ARN of the configuration manager.
    manager_arn: ?[]const u8 = null,

    /// The parameters for the configuration definition type.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Web Services Region where the configuration was deployed.
    region: ?[]const u8 = null,

    /// A summary of the state of the configuration manager. This includes
    /// deployment
    /// statuses, association statuses, drift statuses, health checks, and more.
    status_summaries: ?[]const StatusSummary = null,

    /// The type of the Quick Setup configuration.
    @"type": ?[]const u8 = null,

    /// The version of the Quick Setup type used.
    type_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .account = "Account",
        .configuration_definition_id = "ConfigurationDefinitionId",
        .created_at = "CreatedAt",
        .id = "Id",
        .last_modified_at = "LastModifiedAt",
        .manager_arn = "ManagerArn",
        .parameters = "Parameters",
        .region = "Region",
        .status_summaries = "StatusSummaries",
        .@"type" = "Type",
        .type_version = "TypeVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfigurationInput, options: CallOptions) !GetConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ssm-quicksetup");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-quicksetup", "SSM QuickSetup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/getConfiguration/");
    try path_buf.appendSlice(allocator, input.configuration_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfigurationOutput {
    var result: GetConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetConfigurationOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
