const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const GameSessionQueueDestination = @import("game_session_queue_destination.zig").GameSessionQueueDestination;
const FilterConfiguration = @import("filter_configuration.zig").FilterConfiguration;
const PlayerLatencyPolicy = @import("player_latency_policy.zig").PlayerLatencyPolicy;
const PriorityConfiguration = @import("priority_configuration.zig").PriorityConfiguration;
const GameSessionQueue = @import("game_session_queue.zig").GameSessionQueue;

pub const UpdateGameSessionQueueInput = struct {
    /// Information to be added to all events that are related to this game session
    /// queue.
    custom_event_data: ?[]const u8 = null,

    /// A list of fleets and/or fleet aliases that can be used to fulfill game
    /// session placement requests in the queue.
    /// Destinations are identified by either a fleet ARN or a fleet alias ARN, and
    /// are listed in order of placement preference. When updating this list,
    /// provide a complete list of destinations.
    destinations: ?[]const GameSessionQueueDestination = null,

    /// A list of locations where a queue is allowed to place new game sessions.
    /// Locations
    /// are specified in the form of Amazon Web Services Region codes, such as
    /// `us-west-2`. If this parameter is
    /// not set, game sessions can be placed in any queue location. To remove an
    /// existing filter configuration, pass in an empty set.
    filter_configuration: ?FilterConfiguration = null,

    /// A descriptive label that is associated with game session queue. Queue names
    /// must be unique within each Region. You can use either the queue ID or ARN
    /// value.
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
    /// value. When updating policies, provide a complete collection of policies.
    player_latency_policies: ?[]const PlayerLatencyPolicy = null,

    /// Custom settings to use when prioritizing destinations and locations for game
    /// session placements. This
    /// configuration replaces the FleetIQ default prioritization process. Priority
    /// types that are not explicitly
    /// named will be automatically applied at the end of the prioritization
    /// process. To remove an existing priority configuration, pass in an empty set.
    priority_configuration: ?PriorityConfiguration = null,

    /// The maximum time, in seconds, that a new game session placement request
    /// remains in the queue. When a request exceeds this time, the game session
    /// placement changes to a `TIMED_OUT` status.
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
        .timeout_in_seconds = "TimeoutInSeconds",
    };
};

pub const UpdateGameSessionQueueOutput = struct {
    /// An object that describes the newly updated game session queue.
    game_session_queue: ?GameSessionQueue = null,

    pub const json_field_names = .{
        .game_session_queue = "GameSessionQueue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGameSessionQueueInput, options: CallOptions) !UpdateGameSessionQueueOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGameSessionQueueInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateGameSessionQueue");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGameSessionQueueOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGameSessionQueueOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FleetCapacityExceededException")) {
        const parsed_error: ?errors.FleetCapacityExceededException = aws.json.parseJsonObject(errors.FleetCapacityExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .fleet_capacity_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GameSessionFullException")) {
        const parsed_error: ?errors.GameSessionFullException = aws.json.parseJsonObject(errors.GameSessionFullException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .game_session_full_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        const parsed_error: ?errors.IdempotentParameterMismatchException = aws.json.parseJsonObject(errors.IdempotentParameterMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        const parsed_error: ?errors.InternalServiceException = aws.json.parseJsonObject(errors.InternalServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFleetStatusException")) {
        const parsed_error: ?errors.InvalidFleetStatusException = aws.json.parseJsonObject(errors.InvalidFleetStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_fleet_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidGameSessionStatusException")) {
        const parsed_error: ?errors.InvalidGameSessionStatusException = aws.json.parseJsonObject(errors.InvalidGameSessionStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_game_session_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        const parsed_error: ?errors.InvalidRequestException = aws.json.parseJsonObject(errors.InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        const parsed_error: ?errors.NotFoundException = aws.json.parseJsonObject(errors.NotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotReadyException")) {
        const parsed_error: ?errors.NotReadyException = aws.json.parseJsonObject(errors.NotReadyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_ready_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OutOfCapacityException")) {
        const parsed_error: ?errors.OutOfCapacityException = aws.json.parseJsonObject(errors.OutOfCapacityException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .out_of_capacity_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TaggingFailedException")) {
        const parsed_error: ?errors.TaggingFailedException = aws.json.parseJsonObject(errors.TaggingFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tagging_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TerminalRoutingStrategyException")) {
        const parsed_error: ?errors.TerminalRoutingStrategyException = aws.json.parseJsonObject(errors.TerminalRoutingStrategyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .terminal_routing_strategy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        const parsed_error: ?errors.UnauthorizedException = aws.json.parseJsonObject(errors.UnauthorizedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unauthorized_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedRegionException")) {
        const parsed_error: ?errors.UnsupportedRegionException = aws.json.parseJsonObject(errors.UnsupportedRegionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_region_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
