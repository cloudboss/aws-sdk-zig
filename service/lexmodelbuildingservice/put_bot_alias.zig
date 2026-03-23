const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ConversationLogsRequest = @import("conversation_logs_request.zig").ConversationLogsRequest;
const Tag = @import("tag.zig").Tag;
const ConversationLogsResponse = @import("conversation_logs_response.zig").ConversationLogsResponse;

pub const PutBotAliasInput = struct {
    /// The name of the bot.
    bot_name: []const u8,

    /// The version of the bot.
    bot_version: []const u8,

    /// Identifies a specific revision of the `$LATEST`
    /// version.
    ///
    /// When you create a new bot alias, leave the `checksum`
    /// field blank. If you specify a checksum you get a
    /// `BadRequestException` exception.
    ///
    /// When you want to update a bot alias, set the `checksum`
    /// field to the checksum of the most recent revision of the
    /// `$LATEST` version. If you don't specify the `
    /// checksum` field, or if the checksum does not match the
    /// `$LATEST` version, you get a
    /// `PreconditionFailedException` exception.
    checksum: ?[]const u8 = null,

    /// Settings for conversation logs for the alias.
    conversation_logs: ?ConversationLogsRequest = null,

    /// A description of the alias.
    description: ?[]const u8 = null,

    /// The name of the alias. The name is *not* case
    /// sensitive.
    name: []const u8,

    /// A list of tags to add to the bot alias. You can only add tags when you
    /// create an alias, you can't use the `PutBotAlias` operation to
    /// update the tags on a bot alias. To update tags, use the
    /// `TagResource` operation.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .bot_name = "botName",
        .bot_version = "botVersion",
        .checksum = "checksum",
        .conversation_logs = "conversationLogs",
        .description = "description",
        .name = "name",
        .tags = "tags",
    };
};

pub const PutBotAliasOutput = struct {
    /// The name of the bot that the alias points to.
    bot_name: ?[]const u8 = null,

    /// The version of the bot that the alias points to.
    bot_version: ?[]const u8 = null,

    /// The checksum for the current version of the alias.
    checksum: ?[]const u8 = null,

    /// The settings that determine how Amazon Lex uses conversation logs for the
    /// alias.
    conversation_logs: ?ConversationLogsResponse = null,

    /// The date that the bot alias was created.
    created_date: ?i64 = null,

    /// A description of the alias.
    description: ?[]const u8 = null,

    /// The date that the bot alias was updated. When you create a
    /// resource, the creation date and the last updated date are the
    /// same.
    last_updated_date: ?i64 = null,

    /// The name of the alias.
    name: ?[]const u8 = null,

    /// A list of tags associated with a bot.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .bot_name = "botName",
        .bot_version = "botVersion",
        .checksum = "checksum",
        .conversation_logs = "conversationLogs",
        .created_date = "createdDate",
        .description = "description",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBotAliasInput, options: CallOptions) !PutBotAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBotAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_name);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"botVersion\":");
    try aws.json.writeValue(@TypeOf(input.bot_version), input.bot_version, allocator, &body_buf);
    has_prev = true;
    if (input.checksum) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"checksum\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.conversation_logs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"conversationLogs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBotAliasOutput {
    var result: PutBotAliasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutBotAliasOutput, body, allocator);
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
