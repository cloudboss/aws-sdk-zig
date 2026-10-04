const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PlayerSession = @import("player_session.zig").PlayerSession;

pub const CreatePlayerSessionInput = struct {
    /// An identifier for the game session that is unique across all regions to add
    /// a player to. The value is always a full ARN in the following format: For
    /// Home Region game session - `arn:aws:gamelift:::gamesession//`. For Remote
    /// Location game session - `arn:aws:gamelift:::gamesession///`.
    game_session_id: []const u8,

    /// Developer-defined information related to a player. Amazon GameLift Servers
    /// does not use this data, so it can be formatted as needed for use in the
    /// game.
    player_data: ?[]const u8 = null,

    /// A unique identifier for a player. Player IDs are developer-defined.
    player_id: []const u8,

    pub const json_field_names = .{
        .game_session_id = "GameSessionId",
        .player_data = "PlayerData",
        .player_id = "PlayerId",
    };
};

pub const CreatePlayerSessionOutput = struct {
    /// Object that describes the newly created player session record.
    player_session: ?PlayerSession = null,

    pub const json_field_names = .{
        .player_session = "PlayerSession",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePlayerSessionInput, options: CallOptions) !CreatePlayerSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePlayerSessionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.CreatePlayerSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePlayerSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePlayerSessionOutput, body, allocator);
}
