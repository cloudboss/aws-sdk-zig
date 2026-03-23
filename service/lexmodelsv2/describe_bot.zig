const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BotMember = @import("bot_member.zig").BotMember;
const BotStatus = @import("bot_status.zig").BotStatus;
const BotType = @import("bot_type.zig").BotType;
const DataPrivacy = @import("data_privacy.zig").DataPrivacy;
const ErrorLogSettings = @import("error_log_settings.zig").ErrorLogSettings;

pub const DescribeBotInput = struct {
    /// The unique identifier of the bot to describe.
    bot_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
    };
};

pub const DescribeBotOutput = struct {
    /// The unique identifier of the bot.
    bot_id: ?[]const u8 = null,

    /// The list of bots in the network that was described.
    bot_members: ?[]const BotMember = null,

    /// The name of the bot.
    bot_name: ?[]const u8 = null,

    /// The current status of the bot. When the status is
    /// `Available` the bot is ready to be used in conversations
    /// with users.
    bot_status: ?BotStatus = null,

    /// The type of the bot that was described.
    bot_type: ?BotType = null,

    /// A timestamp of the date and time that the bot was created.
    creation_date_time: ?i64 = null,

    /// Settings for managing data privacy of the bot and its conversations
    /// with users.
    data_privacy: ?DataPrivacy = null,

    /// The description of the bot.
    description: ?[]const u8 = null,

    /// Contains the configuration for error logging that specifies where and how
    /// bot errors are recorded, including destinations like CloudWatch Logs.
    error_log_settings: ?ErrorLogSettings = null,

    /// If the `botStatus` is `Failed`, this contains
    /// a list of reasons that the bot couldn't be built.
    failure_reasons: ?[]const []const u8 = null,

    /// The maximum time in seconds that Amazon Lex retains the data gathered in
    /// a conversation.
    idle_session_ttl_in_seconds: ?i32 = null,

    /// A timestamp of the date and time that the bot was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that has permission to
    /// access the bot.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_members = "botMembers",
        .bot_name = "botName",
        .bot_status = "botStatus",
        .bot_type = "botType",
        .creation_date_time = "creationDateTime",
        .data_privacy = "dataPrivacy",
        .description = "description",
        .error_log_settings = "errorLogSettings",
        .failure_reasons = "failureReasons",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .last_updated_date_time = "lastUpdatedDateTime",
        .role_arn = "roleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBotInput, options: CallOptions) !DescribeBotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lex");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBotOutput {
    var result: DescribeBotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeBotOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
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
