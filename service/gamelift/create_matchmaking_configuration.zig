const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BackfillMode = @import("backfill_mode.zig").BackfillMode;
const FlexMatchMode = @import("flex_match_mode.zig").FlexMatchMode;
const GameProperty = @import("game_property.zig").GameProperty;
const Tag = @import("tag.zig").Tag;
const MatchmakingConfiguration = @import("matchmaking_configuration.zig").MatchmakingConfiguration;

pub const CreateMatchmakingConfigurationInput = struct {
    /// A flag that determines whether a match that was created with this
    /// configuration must
    /// be accepted by the matched players. To require acceptance, set to `TRUE`.
    /// With this option enabled, matchmaking tickets use the status
    /// `REQUIRES_ACCEPTANCE` to indicate when a completed potential match is
    /// waiting for player acceptance.
    acceptance_required: bool,

    /// The length of time (in seconds) to wait for players to accept a proposed
    /// match, if
    /// acceptance is required.
    acceptance_timeout_seconds: ?i32 = null,

    /// The number of player slots in a match to keep open for future players. For
    /// example, if the configuration's rule set specifies
    /// a match for a single 12-person team, and the additional player count is set
    /// to 2, only 10 players are selected for the match. This parameter is not used
    /// if `FlexMatchMode` is set to
    /// `STANDALONE`.
    additional_player_count: ?i32 = null,

    /// The method used to backfill game sessions that are created with this
    /// matchmaking
    /// configuration. Specify `MANUAL` when your game manages backfill requests
    /// manually or does not use the match backfill feature. Specify `AUTOMATIC` to
    /// have Amazon GameLift Servers create a backfill request whenever a game
    /// session has one or more open
    /// slots. Learn more about manual and automatic backfill in [ Backfill Existing
    /// Games
    /// with
    /// FlexMatch](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-backfill.html). Automatic backfill is not available when
    /// `FlexMatchMode` is set to `STANDALONE`.
    backfill_mode: ?BackfillMode = null,

    /// Information to be added to all events related to this matchmaking
    /// configuration.
    custom_event_data: ?[]const u8 = null,

    /// A human-readable description of the matchmaking configuration.
    description: ?[]const u8 = null,

    /// Indicates whether this matchmaking configuration is being used with Amazon
    /// GameLift Servers hosting or
    /// as a standalone matchmaking solution.
    ///
    /// * **STANDALONE** - FlexMatch forms matches and
    /// returns match information, including players and team assignments, in a [
    /// MatchmakingSucceeded](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-events.html#match-events-matchmakingsucceeded) event.
    ///
    /// * **WITH_QUEUE** - FlexMatch forms matches and uses
    /// the specified Amazon GameLift Servers queue to start a game session for the
    /// match.
    flex_match_mode: ?FlexMatchMode = null,

    /// A set of key-value pairs that can store custom data in a game session.
    /// For example: `{"Key": "difficulty", "Value": "novice"}`. This information is
    /// added to the new `GameSession` object that is
    /// created for a successful match. This parameter is not used if
    /// `FlexMatchMode`
    /// is set to `STANDALONE`.
    ///
    /// Avoid using periods (".") in property keys if you plan to search for game
    /// sessions by properties. Property keys containing periods cannot be searched
    /// and will be filtered out from search results due to search index
    /// limitations.
    game_properties: ?[]const GameProperty = null,

    /// A set of custom game session properties, formatted as a single string value.
    /// This data is passed to a game server process with a request to start a new
    /// game session. For more information, see [Start a game
    /// session](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-api.html#gamelift-sdk-server-startsession). This information is added to the new `GameSession` object that is
    /// created for a successful match. This parameter is not used if
    /// `FlexMatchMode`
    /// is set to `STANDALONE`.
    game_session_data: ?[]const u8 = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers game session queue resource
    /// and uniquely identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::gamesessionqueue/`. Queues can be located in any Region.
    /// Queues are used to start new
    /// Amazon GameLift Servers-hosted game sessions for matches that are created
    /// with this matchmaking
    /// configuration. If `FlexMatchMode` is set to `STANDALONE`, do not
    /// set this parameter.
    game_session_queue_arns: ?[]const []const u8 = null,

    /// A unique identifier for the matchmaking configuration. This name is used to
    /// identify the configuration associated with a matchmaking
    /// request or ticket.
    name: []const u8,

    /// An SNS topic ARN that is set up to receive matchmaking notifications. See [
    /// Setting up notifications for
    /// matchmaking](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-notification.html) for more information.
    notification_target: ?[]const u8 = null,

    /// The maximum duration, in seconds, that a matchmaking ticket can remain in
    /// process
    /// before timing out. Requests that fail due to timing out can be resubmitted
    /// as
    /// needed.
    request_timeout_seconds: i32,

    /// A unique identifier for the matchmaking rule set to use with this
    /// configuration. You can use either the rule set name or ARN
    /// value. A matchmaking configuration can only use rule sets that are defined
    /// in the same
    /// Region.
    rule_set_name: []const u8,

    /// A list of labels to assign to the new matchmaking configuration resource.
    /// Tags are
    /// developer-defined key-value pairs. Tagging Amazon Web Services resources are
    /// useful for resource
    /// management, access management and cost allocation. For more information, see
    /// [ Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .acceptance_required = "AcceptanceRequired",
        .acceptance_timeout_seconds = "AcceptanceTimeoutSeconds",
        .additional_player_count = "AdditionalPlayerCount",
        .backfill_mode = "BackfillMode",
        .custom_event_data = "CustomEventData",
        .description = "Description",
        .flex_match_mode = "FlexMatchMode",
        .game_properties = "GameProperties",
        .game_session_data = "GameSessionData",
        .game_session_queue_arns = "GameSessionQueueArns",
        .name = "Name",
        .notification_target = "NotificationTarget",
        .request_timeout_seconds = "RequestTimeoutSeconds",
        .rule_set_name = "RuleSetName",
        .tags = "Tags",
    };
};

pub const CreateMatchmakingConfigurationOutput = struct {
    /// Object that describes the newly created matchmaking configuration.
    configuration: ?MatchmakingConfiguration = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMatchmakingConfigurationInput, options: CallOptions) !CreateMatchmakingConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMatchmakingConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.CreateMatchmakingConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMatchmakingConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMatchmakingConfigurationOutput, body, allocator);
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
