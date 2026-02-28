const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChannelStatus = @import("channel_status.zig").ChannelStatus;
const ChannelType = @import("channel_type.zig").ChannelType;

pub const GetBotChannelAssociationInput = struct {
    /// An alias pointing to the specific version of the Amazon Lex bot to which
    /// this association is being made.
    bot_alias: []const u8,

    /// The name of the Amazon Lex bot.
    bot_name: []const u8,

    /// The name of the association between the bot and the channel. The
    /// name is case sensitive.
    name: []const u8,

    pub const json_field_names = .{
        .bot_alias = "botAlias",
        .bot_name = "botName",
        .name = "name",
    };
};

pub const GetBotChannelAssociationOutput = struct {
    /// An alias pointing to the specific version of the Amazon Lex bot to which
    /// this association is being made.
    bot_alias: ?[]const u8 = null,

    /// Provides information that the messaging platform needs to
    /// communicate with the Amazon Lex bot.
    bot_configuration: ?[]const aws.map.StringMapEntry = null,

    /// The name of the Amazon Lex bot.
    bot_name: ?[]const u8 = null,

    /// The date that the association between the bot and the channel was
    /// created.
    created_date: ?i64 = null,

    /// A description of the association between the bot and the
    /// channel.
    description: ?[]const u8 = null,

    /// If `status` is `FAILED`, Amazon Lex provides the
    /// reason that it failed to create the association.
    failure_reason: ?[]const u8 = null,

    /// The name of the association between the bot and the
    /// channel.
    name: ?[]const u8 = null,

    /// The status of the bot channel.
    ///
    /// * `CREATED` - The channel has been created and is
    /// ready for use.
    ///
    /// * `IN_PROGRESS` - Channel creation is in
    /// progress.
    ///
    /// * `FAILED` - There was an error creating the channel.
    /// For information about the reason for the failure, see the
    /// `failureReason` field.
    status: ?ChannelStatus = null,

    /// The type of the messaging platform.
    @"type": ?ChannelType = null,

    pub const json_field_names = .{
        .bot_alias = "botAlias",
        .bot_configuration = "botConfiguration",
        .bot_name = "botName",
        .created_date = "createdDate",
        .description = "description",
        .failure_reason = "failureReason",
        .name = "name",
        .status = "status",
        .@"type" = "type",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBotChannelAssociationInput, options: Options) !GetBotChannelAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelbuildingservice");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetBotChannelAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelbuildingservice", "Lex Model Building Service", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/bots/");
    try path_buf.appendSlice(alloc, input.bot_name);
    try path_buf.appendSlice(alloc, "/aliases/");
    try path_buf.appendSlice(alloc, input.bot_alias);
    try path_buf.appendSlice(alloc, "/channels/");
    try path_buf.appendSlice(alloc, input.name);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetBotChannelAssociationOutput {
    var result: GetBotChannelAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBotChannelAssociationOutput, body, alloc);
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
