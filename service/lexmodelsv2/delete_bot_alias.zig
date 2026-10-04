const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotAliasStatus = @import("bot_alias_status.zig").BotAliasStatus;

pub const DeleteBotAliasInput = struct {
    /// The unique identifier of the bot alias to delete.
    bot_alias_id: []const u8,

    /// The unique identifier of the bot associated with the alias to
    /// delete.
    bot_id: []const u8,

    /// By default, Amazon Lex checks if any other resource, such as a bot network,
    /// is using the bot alias before it is deleted and throws a
    /// `ResourceInUseException` exception if the alias is
    /// being used by another resource. Set this parameter to `true`
    /// to skip this check and remove the alias even if it is being used by
    /// another resource.
    skip_resource_in_use_check: ?bool = null,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .skip_resource_in_use_check = "skipResourceInUseCheck",
    };
};

pub const DeleteBotAliasOutput = struct {
    /// The unique identifier of the bot alias to delete.
    bot_alias_id: ?[]const u8 = null,

    /// The current status of the alias. The status is `Deleting`
    /// while the alias is in the process of being deleted. Once the alias is
    /// deleted, it will no longer appear in the list of aliases returned by
    /// the `ListBotAliases` operation.
    bot_alias_status: ?BotAliasStatus = null,

    /// The unique identifier of the bot that contains the alias to
    /// delete.
    bot_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_alias_status = "botAliasStatus",
        .bot_id = "botId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBotAliasInput, options: CallOptions) !DeleteBotAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBotAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botaliases/");
    try path_buf.appendSlice(allocator, input.bot_alias_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBotAliasOutput {
    const result: DeleteBotAliasOutput = try aws.json.parseJsonObject(
        DeleteBotAliasOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
