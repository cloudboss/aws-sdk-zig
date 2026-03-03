const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
    /// Avoid using periods (".") in property keys if you plan to search for game
    /// sessions by properties. Property keys containing periods cannot be searched
    /// and will be filtered out from search results due to search index
    /// limitations.
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
    /// A game session ARN has the following format:
    /// `arn:aws:gamelift:::gamesession//`. Idempotency tokens remain in use for 30
    /// days after a game session has ended;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGameSessionInput, options: Options) !CreateGameSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "gamelift");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGameSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FleetCapacityExceededException")) {
        return .{ .arena = arena, .kind = .{ .fleet_capacity_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GameSessionFullException")) {
        return .{ .arena = arena, .kind = .{ .game_session_full_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFleetStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_fleet_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGameSessionStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_game_session_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotReadyException")) {
        return .{ .arena = arena, .kind = .{ .not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OutOfCapacityException")) {
        return .{ .arena = arena, .kind = .{ .out_of_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaggingFailedException")) {
        return .{ .arena = arena, .kind = .{ .tagging_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TerminalRoutingStrategyException")) {
        return .{ .arena = arena, .kind = .{ .terminal_routing_strategy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedRegionException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
