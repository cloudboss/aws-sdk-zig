const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const GameSessionQueueDestination = @import("game_session_queue_destination.zig").GameSessionQueueDestination;
const FilterConfiguration = @import("filter_configuration.zig").FilterConfiguration;
const PlayerLatencyPolicy = @import("player_latency_policy.zig").PlayerLatencyPolicy;
const PriorityConfiguration = @import("priority_configuration.zig").PriorityConfiguration;
const Tag = @import("tag.zig").Tag;
const GameSessionQueue = @import("game_session_queue.zig").GameSessionQueue;

pub const CreateGameSessionQueueInput = struct {
    /// Information to be added to all events that are related to this game session
    /// queue.
    custom_event_data: ?[]const u8 = null,

    /// A list of fleets and/or fleet aliases that can be used to fulfill game
    /// session placement requests in the queue.
    /// Destinations are identified by either a fleet ARN or a fleet alias ARN, and
    /// are listed in order of placement preference.
    destinations: ?[]const GameSessionQueueDestination = null,

    /// A list of locations where a queue is allowed to place new game sessions.
    /// Locations
    /// are specified in the form of Amazon Web Services Region codes, such as
    /// `us-west-2`. If this parameter is
    /// not set, game sessions can be placed in any queue location.
    filter_configuration: ?FilterConfiguration = null,

    /// A descriptive label that is associated with game session queue. Queue names
    /// must be unique within each Region.
    name: []const u8,

    /// An SNS topic ARN that is set up to receive game session placement
    /// notifications. See
    /// [ Setting up
    /// notifications for game session
    /// placement](https://docs.aws.amazon.com/gamelift/latest/developerguide/queue-notification.html).
    notification_target: ?[]const u8 = null,

    /// A set of policies that enforce a sliding cap on player latency when
    /// processing game sessions placement requests.
    /// Use multiple policies to gradually relax the cap over time if Amazon
    /// GameLift Servers can't make a placement.
    /// Policies are evaluated in order starting with the lowest maximum latency
    /// value.
    player_latency_policies: ?[]const PlayerLatencyPolicy = null,

    /// Custom settings to use when prioritizing destinations and locations for game
    /// session placements. This
    /// configuration replaces the FleetIQ default prioritization process. Priority
    /// types that are not explicitly
    /// named will be automatically applied at the end of the prioritization
    /// process.
    priority_configuration: ?PriorityConfiguration = null,

    /// A list of labels to assign to the new game session queue resource. Tags are
    /// developer-defined key-value pairs. Tagging Amazon Web Services resources are
    /// useful for resource
    /// management, access management and cost allocation. For more information, see
    /// [ Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference*.
    tags: ?[]const Tag = null,

    /// The maximum time, in seconds, that a new game session placement request
    /// remains in the queue. When a request exceeds this time, the game session
    /// placement changes to a `TIMED_OUT` status. If you don't specify a request
    /// timeout, the queue uses a default value.
    ///
    /// The minimum value is 10 and the maximum value is 600.
    timeout_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .custom_event_data = "CustomEventData",
        .destinations = "Destinations",
        .filter_configuration = "FilterConfiguration",
        .name = "Name",
        .notification_target = "NotificationTarget",
        .player_latency_policies = "PlayerLatencyPolicies",
        .priority_configuration = "PriorityConfiguration",
        .tags = "Tags",
        .timeout_in_seconds = "TimeoutInSeconds",
    };
};

pub const CreateGameSessionQueueOutput = struct {
    /// An object that describes the newly created game session queue.
    game_session_queue: ?GameSessionQueue = null,

    pub const json_field_names = .{
        .game_session_queue = "GameSessionQueue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGameSessionQueueInput, options: CallOptions) !CreateGameSessionQueueOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGameSessionQueueInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.CreateGameSessionQueue");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGameSessionQueueOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateGameSessionQueueOutput, body, allocator);
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
