const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BotAliasLocaleSettings = @import("bot_alias_locale_settings.zig").BotAliasLocaleSettings;
const ConversationLogSettings = @import("conversation_log_settings.zig").ConversationLogSettings;
const SentimentAnalysisSettings = @import("sentiment_analysis_settings.zig").SentimentAnalysisSettings;
const BotAliasStatus = @import("bot_alias_status.zig").BotAliasStatus;

pub const CreateBotAliasInput = struct {
    /// Maps configuration information to a specific locale. You can use
    /// this parameter to specify a specific Lambda function to run different
    /// functions in different locales.
    bot_alias_locale_settings: ?[]const aws.map.MapEntry(BotAliasLocaleSettings) = null,

    /// The alias to create. The name must be unique for the bot.
    bot_alias_name: []const u8,

    /// The unique identifier of the bot that the alias applies to.
    bot_id: []const u8,

    /// The version of the bot that this alias points to. You can use the
    /// [UpdateBotAlias](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_UpdateBotAlias.html) operation to change the
    /// bot version associated with the alias.
    bot_version: ?[]const u8 = null,

    /// Specifies whether Amazon Lex logs text and audio for a conversation with
    /// the bot. When you enable conversation logs, text logs store text input,
    /// transcripts of audio input, and associated metadata in Amazon CloudWatch
    /// Logs. Audio
    /// logs store audio input in Amazon S3.
    conversation_log_settings: ?ConversationLogSettings = null,

    /// A description of the alias. Use this description to help identify
    /// the alias.
    description: ?[]const u8 = null,

    sentiment_analysis_settings: ?SentimentAnalysisSettings = null,

    /// A list of tags to add to the bot alias. You can only add tags when
    /// you create an alias, you can't use the `UpdateBotAlias`
    /// operation to update the tags on a bot alias. To update tags, use the
    /// `TagResource` operation.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .bot_alias_locale_settings = "botAliasLocaleSettings",
        .bot_alias_name = "botAliasName",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .conversation_log_settings = "conversationLogSettings",
        .description = "description",
        .sentiment_analysis_settings = "sentimentAnalysisSettings",
        .tags = "tags",
    };
};

pub const CreateBotAliasOutput = struct {
    /// The unique identifier of the bot alias.
    bot_alias_id: ?[]const u8 = null,

    /// Configuration information for a specific locale.
    bot_alias_locale_settings: ?[]const aws.map.MapEntry(BotAliasLocaleSettings) = null,

    /// The name specified for the bot alias.
    bot_alias_name: ?[]const u8 = null,

    /// The current status of the alias. The alias is first put into the
    /// `Creating` state. When the alias is ready to be used, it
    /// is put into the `Available` state. You can use the
    /// `DescribeBotAlias` operation to get the current state of
    /// an alias.
    bot_alias_status: ?BotAliasStatus = null,

    /// The unique identifier of the bot that this alias applies to.
    bot_id: ?[]const u8 = null,

    /// The version of the bot associated with this alias.
    bot_version: ?[]const u8 = null,

    /// The conversation log settings specified for the alias.
    conversation_log_settings: ?ConversationLogSettings = null,

    /// A Unix timestamp indicating the date and time that the bot alias was
    /// created.
    creation_date_time: ?i64 = null,

    /// The description specified for the bot alias.
    description: ?[]const u8 = null,

    sentiment_analysis_settings: ?SentimentAnalysisSettings = null,

    /// A list of tags associated with the bot alias.
    tags: ?[]const aws.map.StringMapEntry = null,

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
        .sentiment_analysis_settings = "sentimentAnalysisSettings",
        .tags = "tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBotAliasInput, options: Options) !CreateBotAliasOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateBotAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/bots/");
    try path_buf.appendSlice(alloc, input.bot_id);
    try path_buf.appendSlice(alloc, "/botaliases");
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateBotAliasOutput {
    var result: CreateBotAliasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBotAliasOutput, body, alloc);
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
