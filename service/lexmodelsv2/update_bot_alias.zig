const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BotAliasLocaleSettings = @import("bot_alias_locale_settings.zig").BotAliasLocaleSettings;
const ConversationLogSettings = @import("conversation_log_settings.zig").ConversationLogSettings;
const SentimentAnalysisSettings = @import("sentiment_analysis_settings.zig").SentimentAnalysisSettings;
const BotAliasStatus = @import("bot_alias_status.zig").BotAliasStatus;

pub const UpdateBotAliasInput = struct {
    /// The unique identifier of the bot alias.
    bot_alias_id: []const u8,

    /// The new Lambda functions to use in each locale for the bot
    /// alias.
    bot_alias_locale_settings: ?[]const aws.map.MapEntry(BotAliasLocaleSettings) = null,

    /// The new name to assign to the bot alias.
    bot_alias_name: []const u8,

    /// The identifier of the bot with the updated alias.
    bot_id: []const u8,

    /// The new bot version to assign to the bot alias.
    bot_version: ?[]const u8 = null,

    /// The new settings for storing conversation logs in Amazon CloudWatch Logs and
    /// Amazon S3 buckets.
    conversation_log_settings: ?ConversationLogSettings = null,

    /// The new description to assign to the bot alias.
    description: ?[]const u8 = null,

    sentiment_analysis_settings: ?SentimentAnalysisSettings = null,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_alias_locale_settings = "botAliasLocaleSettings",
        .bot_alias_name = "botAliasName",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .conversation_log_settings = "conversationLogSettings",
        .description = "description",
        .sentiment_analysis_settings = "sentimentAnalysisSettings",
    };
};

pub const UpdateBotAliasOutput = struct {
    /// The identifier of the updated bot alias.
    bot_alias_id: ?[]const u8 = null,

    /// The updated Lambda functions to use in each locale for the bot
    /// alias.
    bot_alias_locale_settings: ?[]const aws.map.MapEntry(BotAliasLocaleSettings) = null,

    /// The updated name of the bot alias.
    bot_alias_name: ?[]const u8 = null,

    /// The current status of the bot alias. When the status is
    /// `Available` the alias is ready for use.
    bot_alias_status: ?BotAliasStatus = null,

    /// The identifier of the bot with the updated alias.
    bot_id: ?[]const u8 = null,

    /// The updated version of the bot that the alias points to.
    bot_version: ?[]const u8 = null,

    /// The updated settings for storing conversation logs in Amazon CloudWatch Logs
    /// and
    /// Amazon S3 buckets.
    conversation_log_settings: ?ConversationLogSettings = null,

    /// A timestamp of the date and time that the bot was created.
    creation_date_time: ?i64 = null,

    /// The updated description of the bot alias.
    description: ?[]const u8 = null,

    /// A timestamp of the date and time that the bot was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    sentiment_analysis_settings: ?SentimentAnalysisSettings = null,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_alias_locale_settings = "botAliasLocaleSettings",
        .bot_alias_name = "botAliasName",
        .bot_alias_status = "botAliasStatus",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .conversation_log_settings = "conversationLogSettings",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .last_updated_date_time = "lastUpdatedDateTime",
        .sentiment_analysis_settings = "sentimentAnalysisSettings",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBotAliasInput, options: Options) !UpdateBotAliasOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateBotAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/bots/");
    try path_buf.appendSlice(alloc, input.bot_id);
    try path_buf.appendSlice(alloc, "/botaliases/");
    try path_buf.appendSlice(alloc, input.bot_alias_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.bot_alias_locale_settings) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"botAliasLocaleSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"botAliasName\":");
    try aws.json.writeValue(@TypeOf(input.bot_alias_name), input.bot_alias_name, alloc, &body_buf);
    has_prev = true;
    if (input.bot_version) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"botVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.conversation_log_settings) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"conversationLogSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sentiment_analysis_settings) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"sentimentAnalysisSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateBotAliasOutput {
    var result: UpdateBotAliasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateBotAliasOutput, body, alloc);
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
