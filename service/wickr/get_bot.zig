const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BotStatus = @import("bot_status.zig").BotStatus;

pub const GetBotInput = struct {
    /// The unique identifier of the bot to retrieve.
    bot_id: []const u8,

    /// The ID of the Wickr network containing the bot.
    network_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .network_id = "networkId",
    };
};

pub const GetBotOutput = struct {
    /// The unique identifier of the bot.
    bot_id: ?[]const u8 = null,

    /// The display name of the bot that is visible to users.
    display_name: ?[]const u8 = null,

    /// The ID of the security group to which the bot belongs.
    group_id: ?[]const u8 = null,

    /// Indicates whether the bot has a password set.
    has_challenge: ?bool = null,

    /// The timestamp of the bot's last login.
    last_login: ?[]const u8 = null,

    /// The public key of the bot used for encryption.
    pubkey: ?[]const u8 = null,

    /// The current status of the bot (1 for pending, 2 for active).
    status: ?BotStatus = null,

    /// Indicates whether the bot is currently suspended.
    suspended: ?bool = null,

    /// The unique username hash identifier for the bot.
    uname: ?[]const u8 = null,

    /// The username of the bot.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .display_name = "displayName",
        .group_id = "groupId",
        .has_challenge = "hasChallenge",
        .last_login = "lastLogin",
        .pubkey = "pubkey",
        .status = "status",
        .suspended = "suspended",
        .uname = "uname",
        .username = "username",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBotInput, options: CallOptions) !GetBotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBotOutput {
    var result: GetBotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBotOutput, body, allocator);
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
