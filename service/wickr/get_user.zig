const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetUserInput = struct {
    /// The end time for filtering the user's last activity. Only activity before
    /// this timestamp will be considered. Time is specified in epoch seconds.
    end_time: ?i64 = null,

    /// The ID of the Wickr network containing the user.
    network_id: []const u8,

    /// The start time for filtering the user's last activity. Only activity after
    /// this timestamp will be considered. Time is specified in epoch seconds.
    start_time: ?i64 = null,

    /// The unique identifier of the user to retrieve.
    user_id: []const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .network_id = "networkId",
        .start_time = "startTime",
        .user_id = "userId",
    };
};

pub const GetUserOutput = struct {
    /// The first name of the user.
    first_name: ?[]const u8 = null,

    /// Indicates whether the user has administrator privileges in the network.
    is_admin: ?bool = null,

    /// The timestamp of the user's last activity in the network, specified in epoch
    /// seconds.
    last_activity: ?i32 = null,

    /// The timestamp of the user's last login to the network, specified in epoch
    /// seconds.
    last_login: ?i32 = null,

    /// The last name of the user.
    last_name: ?[]const u8 = null,

    /// A list of security group IDs to which the user belongs.
    security_group_ids: ?[]const []const u8 = null,

    /// The current status of the user (1 for pending, 2 for active).
    status: ?i32 = null,

    /// Indicates whether the user is currently suspended.
    suspended: ?bool = null,

    /// The unique identifier of the user.
    user_id: []const u8,

    /// The email address or username of the user.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .first_name = "firstName",
        .is_admin = "isAdmin",
        .last_activity = "lastActivity",
        .last_login = "lastLogin",
        .last_name = "lastName",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .suspended = "suspended",
        .user_id = "userId",
        .username = "username",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserInput, options: CallOptions) !GetUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "wickr");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.user_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.end_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.start_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUserOutput {
    var result: GetUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetUserOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadRequestError")) {
        return .{ .arena = arena, .kind = .{ .bad_request_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenError")) {
        return .{ .arena = arena, .kind = .{ .forbidden_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RateLimitError")) {
        return .{ .arena = arena, .kind = .{ .rate_limit_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundError")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedError")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationError")) {
        return .{ .arena = arena, .kind = .{ .validation_error = .{
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
