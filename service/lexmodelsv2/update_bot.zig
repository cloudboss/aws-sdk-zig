const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BotMember = @import("bot_member.zig").BotMember;
const BotType = @import("bot_type.zig").BotType;
const DataPrivacy = @import("data_privacy.zig").DataPrivacy;
const ErrorLogSettings = @import("error_log_settings.zig").ErrorLogSettings;
const BotStatus = @import("bot_status.zig").BotStatus;

pub const UpdateBotInput = struct {
    /// The unique identifier of the bot to update. This identifier is
    /// returned by the
    /// [CreateBot](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_CreateBot.html) operation.
    bot_id: []const u8,

    /// The list of bot members in the network associated
    /// with the update action.
    bot_members: ?[]const BotMember = null,

    /// The new name of the bot. The name must be unique in the account that
    /// creates the bot.
    bot_name: []const u8,

    /// The type of the bot to be updated.
    bot_type: ?BotType = null,

    /// Provides information on additional privacy protections Amazon Lex should
    /// use with the bot's data.
    data_privacy: DataPrivacy,

    /// A description of the bot.
    description: ?[]const u8 = null,

    /// Allows you to modify how Amazon Lex logs errors during bot interactions,
    /// including destinations for error logs and the types of errors to be
    /// captured.
    error_log_settings: ?ErrorLogSettings = null,

    /// The time, in seconds, that Amazon Lex should keep information about a
    /// user's conversation with the bot.
    ///
    /// A user interaction remains active for the amount of time specified.
    /// If no conversation occurs during this time, the session expires and
    /// Amazon Lex deletes any data provided before the timeout.
    ///
    /// You can specify between 60 (1 minute) and 86,400 (24 hours)
    /// seconds.
    idle_session_ttl_in_seconds: i32,

    /// The Amazon Resource Name (ARN) of an IAM role that has permissions
    /// to access the bot.
    role_arn: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_members = "botMembers",
        .bot_name = "botName",
        .bot_type = "botType",
        .data_privacy = "dataPrivacy",
        .description = "description",
        .error_log_settings = "errorLogSettings",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .role_arn = "roleArn",
    };
};

pub const UpdateBotOutput = struct {
    /// The unique identifier of the bot that was updated.
    bot_id: ?[]const u8 = null,

    /// The list of bot members in the network that was updated.
    bot_members: ?[]const BotMember = null,

    /// The name of the bot after the update.
    bot_name: ?[]const u8 = null,

    /// Shows the current status of the bot. The bot is first in the
    /// `Creating` status. Once the bot is read for use, it
    /// changes to the `Available` status. After the bot is created,
    /// you can use the `DRAFT` version of the bot.
    bot_status: ?BotStatus = null,

    /// The type of the bot that was updated.
    bot_type: ?BotType = null,

    /// A timestamp of the date and time that the bot was created.
    creation_date_time: ?i64 = null,

    /// The data privacy settings for the bot after the update.
    data_privacy: ?DataPrivacy = null,

    /// The description of the bot after the update.
    description: ?[]const u8 = null,

    /// Settings for managing error logs within the response of an update bot
    /// operation.
    error_log_settings: ?ErrorLogSettings = null,

    /// The session timeout, in seconds, for the bot after the
    /// update.
    idle_session_ttl_in_seconds: ?i32 = null,

    /// A timestamp of the date and time that the bot was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the IAM role used by the bot after
    /// the update.
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
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .last_updated_date_time = "lastUpdatedDateTime",
        .role_arn = "roleArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBotInput, options: Options) !UpdateBotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelsv2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bot_members) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botMembers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"botName\":");
    try aws.json.writeValue(@TypeOf(input.bot_name), input.bot_name, allocator, &body_buf);
    has_prev = true;
    if (input.bot_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataPrivacy\":");
    try aws.json.writeValue(@TypeOf(input.data_privacy), input.data_privacy, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.error_log_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"errorLogSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"idleSessionTTLInSeconds\":");
    try aws.json.writeValue(@TypeOf(input.idle_session_ttl_in_seconds), input.idle_session_ttl_in_seconds, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBotOutput {
    var result: UpdateBotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateBotOutput, body, allocator);
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
