const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EncryptionSetting = @import("encryption_setting.zig").EncryptionSetting;
const BotRecommendationStatus = @import("bot_recommendation_status.zig").BotRecommendationStatus;
const TranscriptSourceSetting = @import("transcript_source_setting.zig").TranscriptSourceSetting;

pub const UpdateBotRecommendationInput = struct {
    /// The unique identifier of the bot containing the bot recommendation
    /// to be updated.
    bot_id: []const u8,

    /// The unique identifier of the bot recommendation to be
    /// updated.
    bot_recommendation_id: []const u8,

    /// The version of the bot containing the bot recommendation to be
    /// updated.
    bot_version: []const u8,

    /// The object representing the passwords that will be used to encrypt
    /// the data related to the bot recommendation results, as well as the KMS
    /// key ARN used to encrypt the associated metadata.
    encryption_setting: EncryptionSetting,

    /// The identifier of the language and locale of the bot recommendation
    /// to update. The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html)
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_recommendation_id = "botRecommendationId",
        .bot_version = "botVersion",
        .encryption_setting = "encryptionSetting",
        .locale_id = "localeId",
    };
};

pub const UpdateBotRecommendationOutput = struct {
    /// The unique identifier of the bot containing the bot recommendation
    /// that has been updated.
    bot_id: ?[]const u8 = null,

    /// The unique identifier of the bot recommendation to be
    /// updated.
    bot_recommendation_id: ?[]const u8 = null,

    /// The status of the bot recommendation.
    ///
    /// If the status is Failed, then the reasons for the failure are listed
    /// in the failureReasons field.
    bot_recommendation_status: ?BotRecommendationStatus = null,

    /// The version of the bot containing the bot recommendation that has
    /// been updated.
    bot_version: ?[]const u8 = null,

    /// A timestamp of the date and time that the bot recommendation was
    /// created.
    creation_date_time: ?i64 = null,

    /// The object representing the passwords that were used to encrypt the
    /// data related to the bot recommendation results, as well as the KMS key
    /// ARN used to encrypt the associated metadata.
    encryption_setting: ?EncryptionSetting = null,

    /// A timestamp of the date and time that the bot recommendation was
    /// last updated.
    last_updated_date_time: ?i64 = null,

    /// The identifier of the language and locale of the bot recommendation
    /// to update. The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html)
    locale_id: ?[]const u8 = null,

    /// The object representing the Amazon S3 bucket containing the transcript,
    /// as well as the associated metadata.
    transcript_source_setting: ?TranscriptSourceSetting = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_recommendation_id = "botRecommendationId",
        .bot_recommendation_status = "botRecommendationStatus",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .encryption_setting = "encryptionSetting",
        .last_updated_date_time = "lastUpdatedDateTime",
        .locale_id = "localeId",
        .transcript_source_setting = "transcriptSourceSetting",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBotRecommendationInput, options: Options) !UpdateBotRecommendationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateBotRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/bots/");
    try path_buf.appendSlice(alloc, input.bot_id);
    try path_buf.appendSlice(alloc, "/botversions/");
    try path_buf.appendSlice(alloc, input.bot_version);
    try path_buf.appendSlice(alloc, "/botlocales/");
    try path_buf.appendSlice(alloc, input.locale_id);
    try path_buf.appendSlice(alloc, "/botrecommendations/");
    try path_buf.appendSlice(alloc, input.bot_recommendation_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"encryptionSetting\":");
    try aws.json.writeValue(@TypeOf(input.encryption_setting), input.encryption_setting, alloc, &body_buf);
    has_prev = true;

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateBotRecommendationOutput {
    var result: UpdateBotRecommendationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateBotRecommendationOutput, body, alloc);
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
