const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotMember = @import("bot_member.zig").BotMember;
const BotStatus = @import("bot_status.zig").BotStatus;
const BotType = @import("bot_type.zig").BotType;
const DataPrivacy = @import("data_privacy.zig").DataPrivacy;
const ParentBotNetwork = @import("parent_bot_network.zig").ParentBotNetwork;

pub const DescribeBotVersionInput = struct {
    /// The identifier of the bot containing the version to return metadata
    /// for.
    bot_id: []const u8,

    /// The version of the bot to return metadata for.
    bot_version: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
    };
};

pub const DescribeBotVersionOutput = struct {
    /// The identifier of the bot that contains the version.
    bot_id: ?[]const u8 = null,

    /// The members of bot network in the version that was described.
    bot_members: ?[]const BotMember = null,

    /// The name of the bot that contains the version.
    bot_name: ?[]const u8 = null,

    /// The current status of the bot. When the status is
    /// `Available`, the bot version is ready for use.
    bot_status: ?BotStatus = null,

    /// The type of the bot in the version that was described.
    bot_type: ?BotType = null,

    /// The version of the bot that was described.
    bot_version: ?[]const u8 = null,

    /// A timestamp of the date and time that the bot version was
    /// created.
    creation_date_time: ?i64 = null,

    /// Data privacy settings for the bot version.
    data_privacy: ?DataPrivacy = null,

    /// The description specified for the bot.
    description: ?[]const u8 = null,

    /// If the `botStatus` is `Failed`, this contains
    /// a list of reasons that the version couldn't be built.
    failure_reasons: ?[]const []const u8 = null,

    /// The number of seconds that a session with the bot remains active
    /// before it is discarded by Amazon Lex.
    idle_session_ttl_in_seconds: ?i32 = null,

    /// A list of the networks to which the bot version you described belongs.
    parent_bot_networks: ?[]const ParentBotNetwork = null,

    /// The Amazon Resource Name (ARN) of an IAM role that has permission to
    /// access the bot version.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_members = "botMembers",
        .bot_name = "botName",
        .bot_status = "botStatus",
        .bot_type = "botType",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .data_privacy = "dataPrivacy",
        .description = "description",
        .failure_reasons = "failureReasons",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .parent_bot_networks = "parentBotNetworks",
        .role_arn = "roleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBotVersionInput, options: CallOptions) !DescribeBotVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBotVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBotVersionOutput {
    var result: DescribeBotVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeBotVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
