const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotStatus = @import("bot_status.zig").BotStatus;

pub const DeleteBotInput = struct {
    /// The identifier of the bot to delete.
    bot_id: []const u8,

    /// By default, Amazon Lex checks if any other resource, such as an alias or
    /// bot network, is using the bot version before it is deleted and throws a
    /// `ResourceInUseException` exception if the bot is
    /// being used by another resource. Set this parameter to `true`
    /// to skip this check and remove the bot even if it is being used by
    /// another resource.
    skip_resource_in_use_check: ?bool = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .skip_resource_in_use_check = "skipResourceInUseCheck",
    };
};

pub const DeleteBotOutput = struct {
    /// The unique identifier of the bot that Amazon Lex is deleting.
    bot_id: ?[]const u8 = null,

    /// The current status of the bot. The status is `Deleting`
    /// while the bot and its associated resources are being deleted.
    bot_status: ?BotStatus = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_status = "botStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBotInput, options: CallOptions) !DeleteBotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.skip_resource_in_use_check) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "skipResourceInUseCheck=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBotOutput {
    const result: DeleteBotOutput = try aws.json.parseJsonObject(
        DeleteBotOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
