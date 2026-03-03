const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EMRContainersConfig = @import("emr_containers_config.zig").EMRContainersConfig;
const ProfilerType = @import("profiler_type.zig").ProfilerType;
const Tag = @import("tag.zig").Tag;

pub const CreatePersistentAppUIInput = struct {
    /// The EMR containers configuration.
    emr_containers_config: ?EMRContainersConfig = null,

    /// The profiler type for the persistent application user interface.
    profiler_type: ?ProfilerType = null,

    /// Tags for the persistent application user interface.
    tags: ?[]const Tag = null,

    /// The unique Amazon Resource Name (ARN) of the target resource.
    target_resource_arn: []const u8,

    /// The cross reference for the persistent application user interface.
    x_referer: ?[]const u8 = null,

    pub const json_field_names = .{
        .emr_containers_config = "EMRContainersConfig",
        .profiler_type = "ProfilerType",
        .tags = "Tags",
        .target_resource_arn = "TargetResourceArn",
        .x_referer = "XReferer",
    };
};

pub const CreatePersistentAppUIOutput = struct {
    /// The persistent application user interface identifier.
    persistent_app_ui_id: ?[]const u8 = null,

    /// Represents if the EMR on EC2 cluster that the persisent application user
    /// interface is created for is a runtime role
    /// enabled cluster or not.
    runtime_role_enabled_cluster: ?bool = null,

    pub const json_field_names = .{
        .persistent_app_ui_id = "PersistentAppUIId",
        .runtime_role_enabled_cluster = "RuntimeRoleEnabledCluster",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePersistentAppUIInput, options: Options) !CreatePersistentAppUIOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "emr");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePersistentAppUIInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr", "EMR", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.CreatePersistentAppUI");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePersistentAppUIOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePersistentAppUIOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
