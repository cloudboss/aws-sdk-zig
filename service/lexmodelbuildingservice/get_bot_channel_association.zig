const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    type: ?ChannelType = null,

    pub const json_field_names = .{
        .bot_alias = "botAlias",
        .bot_configuration = "botConfiguration",
        .bot_name = "botName",
        .created_date = "createdDate",
        .description = "description",
        .failure_reason = "failureReason",
        .name = "name",
        .status = "status",
        .type = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBotChannelAssociationInput, options: CallOptions) !GetBotChannelAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBotChannelAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_name);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.bot_alias);
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBotChannelAssociationOutput {
    const result: GetBotChannelAssociationOutput = try aws.json.parseJsonObject(
        GetBotChannelAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
