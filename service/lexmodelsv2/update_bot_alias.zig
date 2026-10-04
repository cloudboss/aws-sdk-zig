const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBotAliasInput, options: CallOptions) !UpdateBotAliasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBotAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botaliases/");
    try path_buf.appendSlice(allocator, input.bot_alias_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bot_alias_locale_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botAliasLocaleSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"botAliasName\":");
    try aws.json.writeValue(@TypeOf(input.bot_alias_name), input.bot_alias_name, allocator, &body_buf);
    has_prev = true;
    if (input.bot_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.conversation_log_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"conversationLogSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sentiment_analysis_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sentimentAnalysisSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBotAliasOutput {
    var result: UpdateBotAliasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateBotAliasOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
