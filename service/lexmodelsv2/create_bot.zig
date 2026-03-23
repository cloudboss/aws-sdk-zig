const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BotMember = @import("bot_member.zig").BotMember;
const BotType = @import("bot_type.zig").BotType;
const DataPrivacy = @import("data_privacy.zig").DataPrivacy;
const ErrorLogSettings = @import("error_log_settings.zig").ErrorLogSettings;
const BotStatus = @import("bot_status.zig").BotStatus;

pub const CreateBotInput = struct {
    /// The list of bot members in a network to be created.
    bot_members: ?[]const BotMember = null,

    /// The name of the bot. The bot name must be unique in the account that
    /// creates the bot.
    bot_name: []const u8,

    /// A list of tags to add to the bot. You can only add tags when you
    /// create a bot. You can't use the `UpdateBot` operation to
    /// update tags. To update tags, use the `TagResource`
    /// operation.
    bot_tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of a bot to create.
    bot_type: ?BotType = null,

    /// Provides information on additional privacy protections Amazon Lex should
    /// use with the bot's data.
    data_privacy: DataPrivacy,

    /// A description of the bot. It appears in lists to help you identify a
    /// particular bot.
    description: ?[]const u8 = null,

    /// Specifies the configuration for error logging during bot creation.
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

    /// The Amazon Resource Name (ARN) of an IAM role that has permission to
    /// access the bot.
    role_arn: []const u8,

    /// A list of tags to add to the test alias for a bot. You can only add
    /// tags when you create a bot. You can't use the `UpdateAlias`
    /// operation to update tags. To update tags on the test alias, use the
    /// `TagResource` operation.
    test_bot_alias_tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .bot_members = "botMembers",
        .bot_name = "botName",
        .bot_tags = "botTags",
        .bot_type = "botType",
        .data_privacy = "dataPrivacy",
        .description = "description",
        .error_log_settings = "errorLogSettings",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .role_arn = "roleArn",
        .test_bot_alias_tags = "testBotAliasTags",
    };
};

pub const CreateBotOutput = struct {
    /// A unique identifier for a particular bot. You use this to identify
    /// the bot when you call other Amazon Lex API operations.
    bot_id: ?[]const u8 = null,

    /// The list of bots in a network that was created.
    bot_members: ?[]const BotMember = null,

    /// The name specified for the bot.
    bot_name: ?[]const u8 = null,

    /// Shows the current status of the bot. The bot is first in the
    /// `Creating` status. Once the bot is read for use, it
    /// changes to the `Available` status. After the bot is created,
    /// you can use the `DRAFT` version of the bot.
    bot_status: ?BotStatus = null,

    /// A list of tags associated with the bot.
    bot_tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of a bot that was created.
    bot_type: ?BotType = null,

    /// A timestamp indicating the date and time that the bot was
    /// created.
    creation_date_time: ?i64 = null,

    /// The data privacy settings specified for the bot.
    data_privacy: ?DataPrivacy = null,

    /// The description specified for the bot.
    description: ?[]const u8 = null,

    /// Specifies configuration settings for delivering error logs to Cloudwatch
    /// Logs in an Amazon Lex bot response.
    error_log_settings: ?ErrorLogSettings = null,

    /// The session idle time specified for the bot.
    idle_session_ttl_in_seconds: ?i32 = null,

    /// The IAM role specified for the bot.
    role_arn: ?[]const u8 = null,

    /// A list of tags associated with the test alias for the bot.
    test_bot_alias_tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_members = "botMembers",
        .bot_name = "botName",
        .bot_status = "botStatus",
        .bot_tags = "botTags",
        .bot_type = "botType",
        .creation_date_time = "creationDateTime",
        .data_privacy = "dataPrivacy",
        .description = "description",
        .error_log_settings = "errorLogSettings",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .role_arn = "roleArn",
        .test_bot_alias_tags = "testBotAliasTags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBotInput, options: CallOptions) !CreateBotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/bots";

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
    if (input.bot_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.test_bot_alias_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"testBotAliasTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBotOutput {
    var result: CreateBotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBotOutput, body, allocator);
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
