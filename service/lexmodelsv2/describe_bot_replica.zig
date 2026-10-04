const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotReplicaStatus = @import("bot_replica_status.zig").BotReplicaStatus;

pub const DescribeBotReplicaInput = struct {
    /// The request for the unique bot ID of the replicated bot being monitored.
    bot_id: []const u8,

    /// The request for the region of the replicated bot being monitored.
    replica_region: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .replica_region = "replicaRegion",
    };
};

pub const DescribeBotReplicaOutput = struct {
    /// The unique bot ID of the replicated bot being monitored.
    bot_id: ?[]const u8 = null,

    /// The operational status of the replicated bot being monitored.
    bot_replica_status: ?BotReplicaStatus = null,

    /// The creation date and time of the replicated bot being monitored.
    creation_date_time: ?i64 = null,

    /// The failure reasons the bot being monitored failed to replicate.
    failure_reasons: ?[]const []const u8 = null,

    /// The region of the replicated bot being monitored.
    replica_region: ?[]const u8 = null,

    /// The source region of the replicated bot being monitored.
    source_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_replica_status = "botReplicaStatus",
        .creation_date_time = "creationDateTime",
        .failure_reasons = "failureReasons",
        .replica_region = "replicaRegion",
        .source_region = "sourceRegion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBotReplicaInput, options: CallOptions) !DescribeBotReplicaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBotReplicaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/replicas/");
    try path_buf.appendSlice(allocator, input.replica_region);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBotReplicaOutput {
    var result: DescribeBotReplicaOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeBotReplicaOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
