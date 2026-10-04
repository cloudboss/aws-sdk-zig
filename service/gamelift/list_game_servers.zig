const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortOrder = @import("sort_order.zig").SortOrder;
const GameServer = @import("game_server.zig").GameServer;

pub const ListGameServersInput = struct {
    /// An identifier for the game server group to retrieve a list of game servers
    /// from. Use
    /// either the name or ARN value.
    game_server_group_name: []const u8,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages.
    limit: ?i32 = null,

    /// A token that indicates the start of the next sequential page of results. Use
    /// the token that is returned with a previous call to this operation. To start
    /// at the beginning of the result set, do not specify a value.
    next_token: ?[]const u8 = null,

    /// Indicates how to sort the returned data based on game server registration
    /// timestamp.
    /// Use `ASCENDING` to retrieve oldest game servers first, or use
    /// `DESCENDING` to retrieve newest game servers first. If this parameter is
    /// left empty, game servers are returned in no particular order.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .game_server_group_name = "GameServerGroupName",
        .limit = "Limit",
        .next_token = "NextToken",
        .sort_order = "SortOrder",
    };
};

pub const ListGameServersOutput = struct {
    /// A collection of game server objects that match the request.
    game_servers: ?[]const GameServer = null,

    /// A token that indicates where to resume retrieving results on the next call
    /// to this operation. If no token is returned, these results represent the end
    /// of the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .game_servers = "GameServers",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGameServersInput, options: CallOptions) !ListGameServersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGameServersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.ListGameServers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGameServersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListGameServersOutput, body, allocator);
}
