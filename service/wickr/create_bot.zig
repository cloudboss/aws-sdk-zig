const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateBotInput = struct {
    /// The password for the bot account.
    challenge: []const u8,

    /// The display name for the bot that will be visible to users in the network.
    display_name: ?[]const u8 = null,

    /// The ID of the security group to which the bot will be assigned.
    group_id: []const u8,

    /// The ID of the Wickr network where the bot will be created.
    network_id: []const u8,

    /// The username for the bot. This must be unique within the network and follow
    /// the network's naming conventions.
    username: []const u8,

    pub const json_field_names = .{
        .challenge = "challenge",
        .display_name = "displayName",
        .group_id = "groupId",
        .network_id = "networkId",
        .username = "username",
    };
};

pub const CreateBotOutput = struct {
    /// The unique identifier assigned to the newly created bot.
    bot_id: []const u8,

    /// The display name of the newly created bot.
    display_name: ?[]const u8 = null,

    /// The ID of the security group to which the bot was assigned.
    group_id: ?[]const u8 = null,

    /// A message indicating the result of the bot creation operation.
    message: ?[]const u8 = null,

    /// The ID of the network where the bot was created.
    network_id: ?[]const u8 = null,

    /// The username of the newly created bot.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .display_name = "displayName",
        .group_id = "groupId",
        .message = "message",
        .network_id = "networkId",
        .username = "username",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBotInput, options: CallOptions) !CreateBotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wickr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/bots");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"challenge\":");
    try aws.json.writeValue(@TypeOf(input.challenge), input.challenge, allocator, &body_buf);
    has_prev = true;
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"groupId\":");
    try aws.json.writeValue(@TypeOf(input.group_id), input.group_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"username\":");
    try aws.json.writeValue(@TypeOf(input.username), input.username, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBotOutput {
    const result: CreateBotOutput = try aws.json.parseJsonObject(
        CreateBotOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
