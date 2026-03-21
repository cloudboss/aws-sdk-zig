const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BotAliasHistoryEvent = @import("bot_alias_history_event.zig").BotAliasHistoryEvent;
const BotAliasLocaleSettings = @import("bot_alias_locale_settings.zig").BotAliasLocaleSettings;
const BotAliasStatus = @import("bot_alias_status.zig").BotAliasStatus;
const ConversationLogSettings = @import("conversation_log_settings.zig").ConversationLogSettings;
const ParentBotNetwork = @import("parent_bot_network.zig").ParentBotNetwork;
const SentimentAnalysisSettings = @import("sentiment_analysis_settings.zig").SentimentAnalysisSettings;

pub const DescribeBotAliasInput = struct {
    /// The identifier of the bot alias to describe.
    bot_alias_id: []const u8,

    /// The identifier of the bot associated with the bot alias to
    /// describe.
    bot_id: []const u8,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
    };
};

pub const DescribeBotAliasOutput = struct {
    /// A list of events that affect a bot alias. For example, an event is
    /// recorded when the version that the alias points to changes.
    bot_alias_history_events: ?[]const BotAliasHistoryEvent = null,

    /// The identifier of the bot alias.
    bot_alias_id: ?[]const u8 = null,

    /// The locale settings that are unique to the alias.
    bot_alias_locale_settings: ?[]const aws.map.MapEntry(BotAliasLocaleSettings) = null,

    /// The name of the bot alias.
    bot_alias_name: ?[]const u8 = null,

    /// The current status of the alias. When the alias is
    /// `Available`, the alias is ready for use with your
    /// bot.
    bot_alias_status: ?BotAliasStatus = null,

    /// The identifier of the bot associated with the bot alias.
    bot_id: ?[]const u8 = null,

    /// The version of the bot associated with the bot alias.
    bot_version: ?[]const u8 = null,

    /// Specifics of how Amazon Lex logs text and audio conversations with the
    /// bot associated with the alias.
    conversation_log_settings: ?ConversationLogSettings = null,

    /// A timestamp of the date and time that the alias was created.
    creation_date_time: ?i64 = null,

    /// The description of the bot alias.
    description: ?[]const u8 = null,

    /// A timestamp of the date and time that the alias was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// A list of the networks to which the bot alias you described belongs.
    parent_bot_networks: ?[]const ParentBotNetwork = null,

    sentiment_analysis_settings: ?SentimentAnalysisSettings = null,

    pub const json_field_names = .{
        .bot_alias_history_events = "botAliasHistoryEvents",
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
        .parent_bot_networks = "parentBotNetworks",
        .sentiment_analysis_settings = "sentimentAnalysisSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBotAliasInput, options: CallOptions) !DescribeBotAliasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBotAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botaliases/");
    try path_buf.appendSlice(allocator, input.bot_alias_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBotAliasOutput {
    var result: DescribeBotAliasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeBotAliasOutput, body, allocator);
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
