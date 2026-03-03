const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DesiredPlayerSession = @import("desired_player_session.zig").DesiredPlayerSession;
const GameProperty = @import("game_property.zig").GameProperty;
const PlayerLatency = @import("player_latency.zig").PlayerLatency;
const PriorityConfigurationOverride = @import("priority_configuration_override.zig").PriorityConfigurationOverride;
const GameSessionPlacement = @import("game_session_placement.zig").GameSessionPlacement;

pub const StartGameSessionPlacementInput = struct {
    /// Set of information on each player to create a player session for.
    desired_player_sessions: ?[]const DesiredPlayerSession = null,

    /// A set of key-value pairs that can store custom data in a game session.
    /// For example: `{"Key": "difficulty", "Value": "novice"}`.
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

    /// A descriptive label that is associated with a game session. Session names do
    /// not need to be unique.
    game_session_name: ?[]const u8 = null,

    /// Name of the queue to use to place the new game session. You can use either
    /// the queue
    /// name or ARN value.
    game_session_queue_name: []const u8,

    /// The maximum number of players that can be connected simultaneously to the
    /// game session.
    maximum_player_session_count: i32,

    /// A unique identifier to assign to the new game session placement. This value
    /// is
    /// developer-defined. The value must be unique across all Regions and cannot be
    /// reused.
    placement_id: []const u8,

    /// A set of values, expressed in milliseconds, that indicates the amount of
    /// latency that a player experiences when connected to Amazon Web Services
    /// Regions. This information is used to try to place the new game session where
    /// it
    /// can offer the best possible gameplay experience for the players.
    player_latencies: ?[]const PlayerLatency = null,

    /// A prioritized list of locations to use for the game session placement and
    /// instructions
    /// on how to use it. This list overrides a queue's prioritized location list
    /// for this game
    /// session placement request only. You can include Amazon Web Services Regions,
    /// local zones, and custom
    /// locations (for Anywhere fleets). You can choose to limit placements to
    /// locations on the
    /// override list only, or you can prioritize locations on the override list
    /// first and then
    /// fall back to the queue's other locations if needed. Choose a fallback
    /// strategy to use in
    /// the event that Amazon GameLift Servers fails to place a game session in any
    /// of the locations on the
    /// priority override list.
    priority_configuration_override: ?PriorityConfigurationOverride = null,

    pub const json_field_names = .{
        .desired_player_sessions = "DesiredPlayerSessions",
        .game_properties = "GameProperties",
        .game_session_data = "GameSessionData",
        .game_session_name = "GameSessionName",
        .game_session_queue_name = "GameSessionQueueName",
        .maximum_player_session_count = "MaximumPlayerSessionCount",
        .placement_id = "PlacementId",
        .player_latencies = "PlayerLatencies",
        .priority_configuration_override = "PriorityConfigurationOverride",
    };
};

pub const StartGameSessionPlacementOutput = struct {
    /// Object that describes the newly created game session placement. This object
    /// includes
    /// all the information provided in the request, as well as start/end time
    /// stamps and
    /// placement status.
    game_session_placement: ?GameSessionPlacement = null,

    pub const json_field_names = .{
        .game_session_placement = "GameSessionPlacement",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartGameSessionPlacementInput, options: Options) !StartGameSessionPlacementOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartGameSessionPlacementInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.StartGameSessionPlacement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartGameSessionPlacementOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartGameSessionPlacementOutput, body, allocator);
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
