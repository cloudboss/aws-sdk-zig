const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotAliasReplicaSummary = @import("bot_alias_replica_summary.zig").BotAliasReplicaSummary;

pub const ListBotAliasReplicasInput = struct {
    /// The request for the unique bot ID of the replicated bot created from the
    /// source bot alias.
    bot_id: []const u8,

    /// The request for maximum results to list the replicated bots created from the
    /// source bot alias.
    max_results: ?i32 = null,

    /// The request for the next token for the replicated bot created from the
    /// source bot alias.
    next_token: ?[]const u8 = null,

    /// The request for the secondary region of the replicated bot created from the
    /// source bot alias.
    replica_region: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .replica_region = "replicaRegion",
    };
};

pub const ListBotAliasReplicasOutput = struct {
    /// The summary information of the replicated bot created from the source bot
    /// alias.
    bot_alias_replica_summaries: ?[]const BotAliasReplicaSummary = null,

    /// The unique bot ID of the replicated bot created from the source bot alias.
    bot_id: ?[]const u8 = null,

    /// The next token for the replicated bots created from the source bot alias.
    next_token: ?[]const u8 = null,

    /// The secondary region of the replicated bot created from the source bot
    /// alias.
    replica_region: ?[]const u8 = null,

    /// The source region of the replicated bot created from the source bot alias.
    source_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_alias_replica_summaries = "botAliasReplicaSummaries",
        .bot_id = "botId",
        .next_token = "nextToken",
        .replica_region = "replicaRegion",
        .source_region = "sourceRegion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBotAliasReplicasInput, options: CallOptions) !ListBotAliasReplicasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBotAliasReplicasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/replicas/");
    try path_buf.appendSlice(allocator, input.replica_region);
    try path_buf.appendSlice(allocator, "/botaliases");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBotAliasReplicasOutput {
    var result: ListBotAliasReplicasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListBotAliasReplicasOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
