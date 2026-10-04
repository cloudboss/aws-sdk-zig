const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GameProperty = @import("game_property.zig").GameProperty;
const PlayerSessionCreationPolicy = @import("player_session_creation_policy.zig").PlayerSessionCreationPolicy;
const ProtectionPolicy = @import("protection_policy.zig").ProtectionPolicy;
const GameSession = @import("game_session.zig").GameSession;

pub const UpdateGameSessionInput = struct {
    /// A set of key-value pairs that can store custom data in a game session.
    /// For example: `{"Key": "difficulty", "Value": "novice"}`.
    /// You can use this parameter to modify game properties in an active game
    /// session.
    /// This action adds new properties and modifies existing properties.
    /// There is no way to delete properties.
    /// For an example, see [Update the value of a game
    /// property](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-client-api.html#game-properties-update).
    ///
    /// * Avoid using periods (".") in property keys if you plan to search for game
    ///   sessions by properties. Property keys containing periods cannot be
    ///   searched and will be filtered out from search results due to search index
    ///   limitations.
    ///
    /// * If you use SearchGameSessions API, there is a limit of 500 game property
    ///   keys across all game sessions and all fleets per region. If the limit is
    ///   exceeded, there will potentially be game session entries missing from
    ///   SearchGameSessions API results.
    game_properties: ?[]const GameProperty = null,

    /// An identifier for the game session that is unique across all regions to
    /// update. The value is always a full ARN in the following format:
    /// `arn:aws:gamelift:::gamesession//`.
    game_session_id: []const u8,

    /// The maximum number of players that can be connected simultaneously to the
    /// game session.
    maximum_player_session_count: ?i32 = null,

    /// A descriptive label that is associated with a game session. Session names do
    /// not need to be unique.
    name: ?[]const u8 = null,

    /// A policy that determines whether the game session is accepting new players.
    player_session_creation_policy: ?PlayerSessionCreationPolicy = null,

    /// Game session protection policy to apply to this game session only.
    ///
    /// * `NoProtection` -- The game session can be terminated during a
    /// scale-down event.
    ///
    /// * `FullProtection` -- If the game session is in an
    /// `ACTIVE` status, it cannot be terminated during a scale-down
    /// event.
    protection_policy: ?ProtectionPolicy = null,

    pub const json_field_names = .{
        .game_properties = "GameProperties",
        .game_session_id = "GameSessionId",
        .maximum_player_session_count = "MaximumPlayerSessionCount",
        .name = "Name",
        .player_session_creation_policy = "PlayerSessionCreationPolicy",
        .protection_policy = "ProtectionPolicy",
    };
};

pub const UpdateGameSessionOutput = struct {
    /// The updated game session properties.
    game_session: ?GameSession = null,

    pub const json_field_names = .{
        .game_session = "GameSession",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGameSessionInput, options: CallOptions) !UpdateGameSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGameSessionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateGameSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGameSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGameSessionOutput, body, allocator);
}
