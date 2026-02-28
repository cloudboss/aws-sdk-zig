const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ApiAccess = @import("api_access.zig").ApiAccess;
const UserStatus = @import("user_status.zig").UserStatus;
const UserType = @import("user_type.zig").UserType;

pub const GetUserInput = struct {
    /// The unique identifier of the user to get data for.
    user_id: []const u8,

    pub const json_field_names = .{
        .user_id = "userId",
    };
};

pub const GetUserOutput = struct {
    /// Indicates whether the user can use the `GetProgrammaticAccessCredentials`
    /// API to obtain credentials that can then be used to access other FinSpace
    /// Data API operations.
    ///
    /// * `ENABLED` – The user has permissions to use the APIs.
    ///
    /// * `DISABLED` – The user does not have permissions to use any APIs.
    api_access: ?ApiAccess = null,

    /// The ARN identifier of an AWS user or role that is allowed to call the
    /// `GetProgrammaticAccessCredentials` API to obtain a credentials token for a
    /// specific FinSpace user. This must be an IAM role within your FinSpace
    /// account.
    api_access_principal_arn: ?[]const u8 = null,

    /// The timestamp at which the user was created in FinSpace. The value is
    /// determined as epoch time in milliseconds.
    create_time: i64 = 0,

    /// The email address that is associated with the user.
    email_address: ?[]const u8 = null,

    /// The first name of the user.
    first_name: ?[]const u8 = null,

    /// Describes the last time the user was deactivated. The value is determined as
    /// epoch time in milliseconds.
    last_disabled_time: i64 = 0,

    /// Describes the last time the user was activated. The value is determined as
    /// epoch time in milliseconds.
    last_enabled_time: i64 = 0,

    /// Describes the last time that the user logged into their account. The value
    /// is determined as epoch time in milliseconds.
    last_login_time: i64 = 0,

    /// Describes the last time the user details were updated. The value is
    /// determined as epoch time in milliseconds.
    last_modified_time: i64 = 0,

    /// The last name of the user.
    last_name: ?[]const u8 = null,

    /// The current status of the user.
    ///
    /// * `CREATING` – The creation is in progress.
    ///
    /// * `ENABLED` – The user is created and is currently active.
    ///
    /// * `DISABLED` – The user is currently inactive.
    status: ?UserStatus = null,

    /// Indicates the type of user.
    ///
    /// * `SUPER_USER` – A user with permission to all the functionality and data in
    ///   FinSpace.
    ///
    /// * `APP_USER` – A user with specific permissions in FinSpace. The users are
    ///   assigned permissions by adding them to a permission group.
    @"type": ?UserType = null,

    /// The unique identifier for the user that is retrieved.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_access = "apiAccess",
        .api_access_principal_arn = "apiAccessPrincipalArn",
        .create_time = "createTime",
        .email_address = "emailAddress",
        .first_name = "firstName",
        .last_disabled_time = "lastDisabledTime",
        .last_enabled_time = "lastEnabledTime",
        .last_login_time = "lastLoginTime",
        .last_modified_time = "lastModifiedTime",
        .last_name = "lastName",
        .status = "status",
        .@"type" = "type",
        .user_id = "userId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserInput, options: Options) !GetUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "finspacedata");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspacedata", "finspace data", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/user/");
    try path_buf.appendSlice(alloc, input.user_id);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetUserOutput {
    var result: GetUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetUserOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
