const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PlayerSession = @import("player_session.zig").PlayerSession;

pub const CreatePlayerSessionsInput = struct {
    /// An identifier for the game session that is unique across all regions to add
    /// players to. The value is always a full ARN in the following format: For Home
    /// Region game session - `arn:aws:gamelift:::gamesession//`. For Remote
    /// Location game session - `arn:aws:gamelift:::gamesession///`.
    game_session_id: []const u8,

    /// Map of string pairs, each specifying a player ID and a set of
    /// developer-defined
    /// information related to the player. Amazon GameLift Servers does not use this
    /// data, so it can be formatted
    /// as needed for use in the game. Any player data strings for player IDs that
    /// are not
    /// included in the `PlayerIds` parameter are ignored.
    player_data_map: ?[]const aws.map.StringMapEntry = null,

    /// List of unique identifiers for the players to be added.
    player_ids: []const []const u8,

    pub const json_field_names = .{
        .game_session_id = "GameSessionId",
        .player_data_map = "PlayerDataMap",
        .player_ids = "PlayerIds",
    };
};

pub const CreatePlayerSessionsOutput = struct {
    /// A collection of player session objects created for the added players.
    player_sessions: ?[]const PlayerSession = null,

    pub const json_field_names = .{
        .player_sessions = "PlayerSessions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePlayerSessionsInput, options: CallOptions) !CreatePlayerSessionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePlayerSessionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.CreatePlayerSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePlayerSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePlayerSessionsOutput, body, allocator);
}
