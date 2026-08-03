const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const GameSession = @import("game_session.zig").GameSession;

pub const SearchGameSessionsInput = struct {
    /// A unique identifier for the alias associated with the fleet to search for
    /// active game sessions. You can use either
    /// the alias ID or ARN value. Each request must reference either a fleet ID or
    /// alias ID,
    /// but not both.
    alias_id: ?[]const u8 = null,

    /// String containing the search criteria for the session search. If no filter
    /// expression
    /// is included, the request returns results for all game sessions in the fleet
    /// that are in
    /// `ACTIVE` status.
    ///
    /// A filter expression can contain one or multiple conditions. Each condition
    /// consists of
    /// the following:
    ///
    /// * **Operand** -- Name of a game session attribute.
    /// Valid values are `gameSessionName`, `gameSessionId`,
    /// `gameSessionProperties`, `maximumSessions`,
    /// `creationTimeMillis`, `playerSessionCount`,
    /// `hasAvailablePlayerSessions`.
    ///
    /// * **Comparator** -- Valid comparators are:
    /// `=`, `<>`, ``,
    /// `=`.
    ///
    /// * **Value** -- Value to be searched for. Values may
    /// be numbers, boolean values (true/false) or strings depending on the operand.
    /// String values are case sensitive and must be enclosed in single quotes.
    /// Special
    /// characters must be escaped. Boolean and string values can only be used with
    /// the
    /// comparators `=` and `<>`. For example, the following
    /// filter expression searches on `gameSessionName`:
    /// "`FilterExpression": "gameSessionName = 'Matt\\'s Awesome Game
    /// 1'"`.
    ///
    /// To chain multiple conditions in a single expression, use the logical
    /// keywords
    /// `AND`, `OR`, and `NOT` and parentheses as needed.
    /// For example: `x AND y AND NOT z`, `NOT (x OR y)`.
    ///
    /// Session search evaluates conditions from left to right using the following
    /// precedence
    /// rules:
    ///
    /// * `=`, `<>`, ``,
    /// `=`
    ///
    /// * Parentheses
    ///
    /// * NOT
    ///
    /// * AND
    ///
    /// * OR
    ///
    /// For example, this filter expression retrieves game sessions hosting at least
    /// ten
    /// players that have an open player slot: `"maximumSessions>=10 AND
    /// hasAvailablePlayerSessions=true"`.
    filter_expression: ?[]const u8 = null,

    /// A unique identifier for the fleet to search for active game sessions. You
    /// can use either the fleet ID or ARN
    /// value. Each request must reference either a fleet ID or alias ID, but not
    /// both.
    fleet_id: ?[]const u8 = null,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages. The maximum number of results
    /// returned is 20, even if this value is not set or
    /// is set higher than 20.
    limit: ?i32 = null,

    /// A fleet location to search for game sessions. You can specify a fleet's home
    /// Region or
    /// a remote location. Use the Amazon Web Services Region code format, such as
    /// `us-west-2`.
    location: ?[]const u8 = null,

    /// A token that indicates the start of the next sequential page of results. Use
    /// the token that is returned with a previous call to this operation. To start
    /// at the beginning of the result set, do not specify a value.
    next_token: ?[]const u8 = null,

    /// Instructions on how to sort the search results. If no sort expression is
    /// included, the
    /// request returns results in random order. A sort expression consists of the
    /// following
    /// elements:
    ///
    /// * **Operand** -- Name of a game session attribute.
    /// Valid values are `gameSessionName`, `gameSessionId`,
    /// `gameSessionProperties`, `maximumSessions`,
    /// `creationTimeMillis`, `playerSessionCount`,
    /// `hasAvailablePlayerSessions`.
    ///
    /// * **Order** -- Valid sort orders are `ASC`
    /// (ascending) and `DESC` (descending).
    ///
    /// For example, this sort expression returns the oldest active sessions first:
    /// `"SortExpression": "creationTimeMillis ASC"`. Results with a null value
    /// for the sort operand are returned at the end of the list.
    sort_expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias_id = "AliasId",
        .filter_expression = "FilterExpression",
        .fleet_id = "FleetId",
        .limit = "Limit",
        .location = "Location",
        .next_token = "NextToken",
        .sort_expression = "SortExpression",
    };
};

pub const SearchGameSessionsOutput = struct {
    /// A collection of objects containing game session properties for each session
    /// that
    /// matches the request.
    game_sessions: ?[]const GameSession = null,

    /// A token that indicates where to resume retrieving results on the next call
    /// to this operation. If no token is returned, these results represent the end
    /// of the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .game_sessions = "GameSessions",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchGameSessionsInput, options: CallOptions) !SearchGameSessionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchGameSessionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.SearchGameSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchGameSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchGameSessionsOutput, body, allocator);
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
