const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PlayerConnectionDetail = @import("player_connection_detail.zig").PlayerConnectionDetail;

pub const GetPlayerConnectionDetailsInput = struct {
    /// An identifier for the game session that is unique across all regions for
    /// which to retrieve player connection details. The value is always a full ARN
    /// in the following format:
    /// `arn:aws:gamelift:::gamesession//`.
    game_session_id: []const u8,

    /// List of unique identifiers for players. Connection details are returned for
    /// each player in this list.
    player_ids: []const []const u8,

    pub const json_field_names = .{
        .game_session_id = "GameSessionId",
        .player_ids = "PlayerIds",
    };
};

pub const GetPlayerConnectionDetailsOutput = struct {
    /// An identifier for the game session that is unique across all regions for
    /// which the player connection details were retrieved. The value is always a
    /// full ARN in the following format:
    /// `arn:aws:gamelift:::gamesession//`.
    game_session_id: ?[]const u8 = null,

    /// A collection of player connection detail objects, one for each requested
    /// player.
    player_connection_details: ?[]const PlayerConnectionDetail = null,

    pub const json_field_names = .{
        .game_session_id = "GameSessionId",
        .player_connection_details = "PlayerConnectionDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPlayerConnectionDetailsInput, options: CallOptions) !GetPlayerConnectionDetailsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPlayerConnectionDetailsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.GetPlayerConnectionDetails");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPlayerConnectionDetailsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPlayerConnectionDetailsOutput, body, allocator);
}
