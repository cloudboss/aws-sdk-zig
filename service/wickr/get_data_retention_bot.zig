const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetDataRetentionBotInput = struct {
    /// The ID of the Wickr network containing the data retention bot.
    network_id: []const u8,

    pub const json_field_names = .{
        .network_id = "networkId",
    };
};

pub const GetDataRetentionBotOutput = struct {
    /// Indicates whether a data retention bot exists in the network.
    bot_exists: ?bool = null,

    /// The name of the data retention bot.
    bot_name: ?[]const u8 = null,

    /// Indicates whether the data retention bot is active and operational.
    is_bot_active: ?bool = null,

    /// Indicates whether the data retention bot has been registered with the
    /// network.
    is_data_retention_bot_registered: ?bool = null,

    /// Indicates whether the data retention service is enabled for the network.
    is_data_retention_service_enabled: ?bool = null,

    /// Indicates whether the public key message has been acknowledged by the bot.
    is_pubkey_msg_acked: ?bool = null,

    pub const json_field_names = .{
        .bot_exists = "botExists",
        .bot_name = "botName",
        .is_bot_active = "isBotActive",
        .is_data_retention_bot_registered = "isDataRetentionBotRegistered",
        .is_data_retention_service_enabled = "isDataRetentionServiceEnabled",
        .is_pubkey_msg_acked = "isPubkeyMsgAcked",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataRetentionBotInput, options: CallOptions) !GetDataRetentionBotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataRetentionBotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/data-retention-bots");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataRetentionBotOutput {
    var result: GetDataRetentionBotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataRetentionBotOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
