const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Statement = @import("statement.zig").Statement;
const Prompt = @import("prompt.zig").Prompt;
const Intent = @import("intent.zig").Intent;
const Locale = @import("locale.zig").Locale;
const Status = @import("status.zig").Status;

pub const CreateBotVersionInput = struct {
    /// Identifies a specific revision of the `$LATEST` version
    /// of the bot. If you specify a checksum and the `$LATEST` version
    /// of the bot has a different checksum, a
    /// `PreconditionFailedException` exception is returned and Amazon Lex
    /// doesn't publish a new version. If you don't specify a checksum, Amazon Lex
    /// publishes the `$LATEST` version.
    checksum: ?[]const u8 = null,

    /// The name of the bot that you want to create a new version of. The
    /// name is case sensitive.
    name: []const u8,

    pub const json_field_names = .{
        .checksum = "checksum",
        .name = "name",
    };
};

pub const CreateBotVersionOutput = struct {
    /// The message that Amazon Lex uses to cancel a conversation. For more
    /// information, see PutBot.
    abort_statement: ?Statement = null,

    /// Checksum identifying the version of the bot that was
    /// created.
    checksum: ?[]const u8 = null,

    /// For each Amazon Lex bot created with the Amazon Lex Model Building Service,
    /// you must specify whether your use of Amazon Lex is related to a website,
    /// program, or other application that is directed or targeted, in whole or in
    /// part, to children under age 13 and subject to the Children's Online
    /// Privacy Protection Act (COPPA) by specifying `true` or
    /// `false` in the `childDirected` field. By
    /// specifying `true` in the `childDirected` field, you
    /// confirm that your use of Amazon Lex **is** related
    /// to a website, program, or other application that is directed or targeted,
    /// in whole or in part, to children under age 13 and subject to COPPA. By
    /// specifying `false` in the `childDirected` field, you
    /// confirm that your use of Amazon Lex **is not**
    /// related to a website, program, or other application that is directed or
    /// targeted, in whole or in part, to children under age 13 and subject to
    /// COPPA. You may not specify a default value for the
    /// `childDirected` field that does not accurately reflect
    /// whether your use of Amazon Lex is related to a website, program, or other
    /// application that is directed or targeted, in whole or in part, to children
    /// under age 13 and subject to COPPA.
    ///
    /// If your use of Amazon Lex relates to a website, program, or other
    /// application that is directed in whole or in part, to children under age
    /// 13, you must obtain any required verifiable parental consent under COPPA.
    /// For information regarding the use of Amazon Lex in connection with websites,
    /// programs, or other applications that are directed or targeted, in whole or
    /// in part, to children under age 13, see the [Amazon Lex
    /// FAQ.](https://aws.amazon.com/lex/faqs#data-security)
    child_directed: ?bool = null,

    /// The message that Amazon Lex uses when it doesn't understand the user's
    /// request. For more information, see PutBot.
    clarification_prompt: ?Prompt = null,

    /// The date when the bot version was created.
    created_date: ?i64 = null,

    /// A description of the bot.
    description: ?[]const u8 = null,

    /// Indicates whether utterances entered by the user should be sent to
    /// Amazon Comprehend for sentiment analysis.
    detect_sentiment: ?bool = null,

    /// Indicates whether the bot uses accuracy improvements.
    /// `true` indicates that the bot is using the improvements,
    /// otherwise, `false`.
    enable_model_improvements: ?bool = null,

    /// If `status` is `FAILED`, Amazon Lex provides the
    /// reason that it failed to build the bot.
    failure_reason: ?[]const u8 = null,

    /// The maximum time in seconds that Amazon Lex retains the data gathered in
    /// a conversation. For more information, see PutBot.
    idle_session_ttl_in_seconds: ?i32 = null,

    /// An array of `Intent` objects. For more information, see
    /// PutBot.
    intents: ?[]const Intent = null,

    /// The date when the `$LATEST` version of this bot was
    /// updated.
    last_updated_date: ?i64 = null,

    /// Specifies the target locale for the bot.
    locale: ?Locale = null,

    /// The name of the bot.
    name: ?[]const u8 = null,

    /// When you send a request to create or update a bot, Amazon Lex sets the
    /// `status` response element to `BUILDING`. After
    /// Amazon Lex builds the bot, it sets `status` to `READY`.
    /// If Amazon Lex can't build the bot, it sets `status` to
    /// `FAILED`. Amazon Lex returns the reason for the failure in the
    /// `failureReason` response element.
    status: ?Status = null,

    /// The version of the bot.
    version: ?[]const u8 = null,

    /// The Amazon Polly voice ID that Amazon Lex uses for voice interactions
    /// with the user.
    voice_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .abort_statement = "abortStatement",
        .checksum = "checksum",
        .child_directed = "childDirected",
        .clarification_prompt = "clarificationPrompt",
        .created_date = "createdDate",
        .description = "description",
        .detect_sentiment = "detectSentiment",
        .enable_model_improvements = "enableModelImprovements",
        .failure_reason = "failureReason",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .intents = "intents",
        .last_updated_date = "lastUpdatedDate",
        .locale = "locale",
        .name = "name",
        .status = "status",
        .version = "version",
        .voice_id = "voiceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBotVersionInput, options: CallOptions) !CreateBotVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBotVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.checksum) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"checksum\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBotVersionOutput {
    var result: CreateBotVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBotVersionOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
