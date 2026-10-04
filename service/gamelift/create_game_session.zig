const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GameProperty = @import("game_property.zig").GameProperty;
const GameSession = @import("game_session.zig").GameSession;

pub const CreateGameSessionInput = struct {
    /// A unique identifier for the alias associated with the fleet to create a game
    /// session in. You can use either the
    /// alias ID or ARN value. Each request must reference either a fleet ID or
    /// alias ID, but
    /// not both.
    alias_id: ?[]const u8 = null,

    /// A unique identifier for a player or entity creating the game session.
    ///
    /// If you add a resource creation limit policy to a fleet, the
    /// `CreateGameSession` operation requires a `CreatorId`. Amazon GameLift
    /// Servers
    /// limits the number of game session creation requests with the same
    /// `CreatorId`
    /// in a specified time period.
    ///
    /// If you your fleet doesn't have a resource creation limit policy and you
    /// provide a
    /// `CreatorId` in your `CreateGameSession` requests, Amazon GameLift Servers
    /// limits requests to one request per `CreatorId` per second.
    ///
    /// To not limit `CreateGameSession` requests with the same
    /// `CreatorId`, don't provide a `CreatorId` in your
    /// `CreateGameSession` request.
    creator_id: ?[]const u8 = null,

    /// A unique identifier for the fleet to create a game session in. You can use
    /// either the fleet ID or ARN value. Each
    /// request must reference either a fleet ID or alias ID, but not both.
    fleet_id: ?[]const u8 = null,

    /// A set of key-value pairs that can store custom data in a game session.
    /// For example: `{"Key": "difficulty", "Value": "novice"}`.
    /// For an example, see [Create a game session with custom
    /// properties](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-client-api.html#game-properties-create).
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

    /// A set of custom game session properties, formatted as a single string value.
    /// This data is passed to a game server process with a request to start a new
    /// game session. For more information, see [Start a game
    /// session](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-api.html#gamelift-sdk-server-startsession).
    game_session_data: ?[]const u8 = null,

    /// *This parameter is deprecated. Use `IdempotencyToken`
    /// instead.*
    ///
    /// Custom string that uniquely identifies a request for a new game session.
    /// Maximum token
    /// length is 48 characters. If provided, this string is included in the new
    /// game session's
    /// ID.
    game_session_id: ?[]const u8 = null,

    /// Custom string that uniquely identifies the new game session request. This is
    /// useful
    /// for ensuring that game session requests with the same idempotency token are
    /// processed
    /// only once. Subsequent requests with the same string return the original
    /// `GameSession` object, with an updated status. Maximum token length is 48
    /// characters. If provided, this string is included in the new game session's
    /// ID.
    /// The value is always a full ARN in the following format: For Home Region game
    /// session - `arn:aws:gamelift:::gamesession//`. For Remote Location game
    /// session - `arn:aws:gamelift:::gamesession///`. Idempotency tokens remain in
    /// use for 30 days after a game session has ended;
    /// game session objects are retained for this time period and then deleted.
    idempotency_token: ?[]const u8 = null,

    /// A fleet's remote location to place the new game session in. If this
    /// parameter is not
    /// set, the new game session is placed in the fleet's home Region. Specify a
    /// remote
    /// location with an Amazon Web Services Region code such as `us-west-2`. When
    /// using an
    /// Anywhere fleet, this parameter is required and must be set to the Anywhere
    /// fleet's
    /// custom location.
    location: ?[]const u8 = null,

    /// The maximum number of players that can be connected simultaneously to the
    /// game session.
    maximum_player_session_count: i32,

    /// A descriptive label that is associated with a game session. Session names do
    /// not need to be unique.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias_id = "AliasId",
        .creator_id = "CreatorId",
        .fleet_id = "FleetId",
        .game_properties = "GameProperties",
        .game_session_data = "GameSessionData",
        .game_session_id = "GameSessionId",
        .idempotency_token = "IdempotencyToken",
        .location = "Location",
        .maximum_player_session_count = "MaximumPlayerSessionCount",
        .name = "Name",
    };
};

pub const CreateGameSessionOutput = struct {
    /// Object that describes the newly created game session record.
    game_session: ?GameSession = null,

    pub const json_field_names = .{
        .game_session = "GameSession",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGameSessionInput, options: CallOptions) !CreateGameSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGameSessionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.CreateGameSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGameSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateGameSessionOutput, body, allocator);
}
