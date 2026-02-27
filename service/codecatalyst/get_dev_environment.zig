const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Ide = @import("ide.zig").Ide;
const InstanceType = @import("instance_type.zig").InstanceType;
const PersistentStorage = @import("persistent_storage.zig").PersistentStorage;
const DevEnvironmentRepositorySummary = @import("dev_environment_repository_summary.zig").DevEnvironmentRepositorySummary;
const DevEnvironmentStatus = @import("dev_environment_status.zig").DevEnvironmentStatus;

pub const GetDevEnvironmentInput = struct {
    /// The system-generated unique ID of the Dev Environment for which you want to
    /// view information. To retrieve a list of Dev Environment IDs, use
    /// ListDevEnvironments.
    id: []const u8,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .project_name = "projectName",
        .space_name = "spaceName",
    };
};

pub const GetDevEnvironmentOutput = struct {
    /// The user-specified alias for the Dev Environment.
    alias: ?[]const u8 = null,

    /// The system-generated unique ID of the user who created the Dev Environment.
    creator_id: []const u8,

    /// The system-generated unique ID of the Dev Environment.
    id: []const u8,

    /// Information about the integrated development environment (IDE) configured
    /// for the Dev Environment.
    ides: ?[]const Ide = null,

    /// The amount of time the Dev Environment will run without any activity
    /// detected before stopping, in minutes.
    inactivity_timeout_minutes: i32 = 0,

    /// The Amazon EC2 instace type to use for the Dev Environment.
    instance_type: InstanceType,

    /// The time when the Dev Environment was last updated, in coordinated universal
    /// time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    last_updated_time: i64,

    /// Information about the amount of storage allocated to the Dev Environment. By
    /// default, a Dev Environment is configured to have 16GB of persistent storage.
    persistent_storage: ?PersistentStorage = null,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The source repository that contains the branch cloned into the Dev
    /// Environment.
    repositories: ?[]const DevEnvironmentRepositorySummary = null,

    /// The name of the space.
    space_name: []const u8,

    /// The current status of the Dev Environment.
    status: DevEnvironmentStatus,

    /// The reason for the status.
    status_reason: ?[]const u8 = null,

    /// The name of the connection used to connect to Amazon VPC used when the Dev
    /// Environment was created, if any.
    vpc_connection_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "alias",
        .creator_id = "creatorId",
        .id = "id",
        .ides = "ides",
        .inactivity_timeout_minutes = "inactivityTimeoutMinutes",
        .instance_type = "instanceType",
        .last_updated_time = "lastUpdatedTime",
        .persistent_storage = "persistentStorage",
        .project_name = "projectName",
        .repositories = "repositories",
        .space_name = "spaceName",
        .status = "status",
        .status_reason = "statusReason",
        .vpc_connection_name = "vpcConnectionName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDevEnvironmentInput, options: Options) !GetDevEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codecatalyst");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetDevEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v1/spaces/");
    try path_buf.appendSlice(alloc, input.space_name);
    try path_buf.appendSlice(alloc, "/projects/");
    try path_buf.appendSlice(alloc, input.project_name);
    try path_buf.appendSlice(alloc, "/devEnvironments/");
    try path_buf.appendSlice(alloc, input.id);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetDevEnvironmentOutput {
    var result: GetDevEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDevEnvironmentOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
