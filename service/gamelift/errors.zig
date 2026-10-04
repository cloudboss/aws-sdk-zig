const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        conflict_exception: ConflictException,
        fleet_capacity_exceeded_exception: FleetCapacityExceededException,
        game_session_full_exception: GameSessionFullException,
        idempotent_parameter_mismatch_exception: IdempotentParameterMismatchException,
        internal_service_exception: InternalServiceException,
        invalid_fleet_status_exception: InvalidFleetStatusException,
        invalid_game_session_status_exception: InvalidGameSessionStatusException,
        invalid_request_exception: InvalidRequestException,
        limit_exceeded_exception: LimitExceededException,
        not_found_exception: NotFoundException,
        not_ready_exception: NotReadyException,
        out_of_capacity_exception: OutOfCapacityException,
        tagging_failed_exception: TaggingFailedException,
        terminal_routing_strategy_exception: TerminalRoutingStrategyException,
        unauthorized_exception: UnauthorizedException,
        unsupported_region_exception: UnsupportedRegionException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => "ConflictException",
                .fleet_capacity_exceeded_exception => "FleetCapacityExceededException",
                .game_session_full_exception => "GameSessionFullException",
                .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
                .internal_service_exception => "InternalServiceException",
                .invalid_fleet_status_exception => "InvalidFleetStatusException",
                .invalid_game_session_status_exception => "InvalidGameSessionStatusException",
                .invalid_request_exception => "InvalidRequestException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_found_exception => "NotFoundException",
                .not_ready_exception => "NotReadyException",
                .out_of_capacity_exception => "OutOfCapacityException",
                .tagging_failed_exception => "TaggingFailedException",
                .terminal_routing_strategy_exception => "TerminalRoutingStrategyException",
                .unauthorized_exception => "UnauthorizedException",
                .unsupported_region_exception => "UnsupportedRegionException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => |e| e.message,
                .fleet_capacity_exceeded_exception => |e| e.message,
                .game_session_full_exception => |e| e.message,
                .idempotent_parameter_mismatch_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_fleet_status_exception => |e| e.message,
                .invalid_game_session_status_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .not_ready_exception => |e| e.message,
                .out_of_capacity_exception => |e| e.message,
                .tagging_failed_exception => |e| e.message,
                .terminal_routing_strategy_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .unsupported_region_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .conflict_exception => 400,
                .fleet_capacity_exceeded_exception => 400,
                .game_session_full_exception => 400,
                .idempotent_parameter_mismatch_exception => 400,
                .internal_service_exception => 500,
                .invalid_fleet_status_exception => 400,
                .invalid_game_session_status_exception => 400,
                .invalid_request_exception => 400,
                .limit_exceeded_exception => 400,
                .not_found_exception => 400,
                .not_ready_exception => 400,
                .out_of_capacity_exception => 400,
                .tagging_failed_exception => 400,
                .terminal_routing_strategy_exception => 400,
                .unauthorized_exception => 400,
                .unsupported_region_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => |e| e.request_id,
                .fleet_capacity_exceeded_exception => |e| e.request_id,
                .game_session_full_exception => |e| e.request_id,
                .idempotent_parameter_mismatch_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_fleet_status_exception => |e| e.request_id,
                .invalid_game_session_status_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .not_ready_exception => |e| e.request_id,
                .out_of_capacity_exception => |e| e.request_id,
                .tagging_failed_exception => |e| e.request_id,
                .terminal_routing_strategy_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
                .unsupported_region_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

/// The requested operation would cause a conflict with the current state of a
/// service
/// resource associated with the request. Resolve the conflict before retrying
/// this
/// request.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified fleet has no available instances to fulfill a
/// `CreateGameSession` request. Clients can retry such requests immediately
/// or after a waiting period.
pub const FleetCapacityExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The game instance is currently full and cannot allow the requested player(s)
/// to join.
/// Clients can retry such requests immediately or after a waiting period.
pub const GameSessionFullException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A game session with this custom ID string already exists in this fleet.
/// Resolve this
/// conflict before retrying this request.
pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The service encountered an unrecoverable internal failure while processing
/// the
/// request. Clients can retry such requests immediately or after a waiting
/// period.
pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The requested operation would cause a conflict with the current state of a
/// resource
/// associated with the request and/or the fleet. Resolve the conflict before
/// retrying.
pub const InvalidFleetStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The requested operation would cause a conflict with the current state of a
/// resource
/// associated with the request and/or the game instance. Resolve the conflict
/// before
/// retrying.
pub const InvalidGameSessionStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// One or more parameter values in the request are invalid. Correct the invalid
/// parameter
/// values before retrying.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The requested operation would cause the resource to exceed the allowed
/// service limit.
/// Resolve the issue before retrying.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The requested resource was not found. The resource was either not created
/// yet or deleted.
pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operation failed because Amazon GameLift Servers has not yet finished
/// validating this compute. We
/// recommend attempting 8 to 10 retries over 3 to 5 minutes with [exponential
/// backoffs and
/// jitter](http://aws.amazon.com/blogs/https:/aws.amazon.com/blogs/architecture/exponential-backoff-and-jitter/).
pub const NotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified game server group has no available game servers to fulfill a
/// `ClaimGameServer` request. Clients can retry such requests immediately or
/// after a waiting period.
pub const OutOfCapacityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The requested tagging operation did not succeed. This may be due to invalid
/// tag format
/// or the maximum tag limit may have been exceeded. Resolve the issue before
/// retrying.
pub const TaggingFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The service is unable to resolve the routing for a particular alias because
/// it has a
/// terminal `RoutingStrategy` associated with it. The message returned in this
/// exception is the message defined in the routing strategy itself. Such
/// requests should
/// only be retried if the routing strategy for the specified alias is modified.
pub const TerminalRoutingStrategyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The client failed authentication. Clients should not retry such requests.
pub const UnauthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The requested operation is not supported in the Region specified.
pub const UnsupportedRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
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
        const parsed_error: ?ConflictException = aws.json.parseJsonObject(ConflictException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?FleetCapacityExceededException = aws.json.parseJsonObject(FleetCapacityExceededException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?GameSessionFullException = aws.json.parseJsonObject(GameSessionFullException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?IdempotentParameterMismatchException = aws.json.parseJsonObject(IdempotentParameterMismatchException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InternalServiceException = aws.json.parseJsonObject(InternalServiceException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidFleetStatusException = aws.json.parseJsonObject(InvalidFleetStatusException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidGameSessionStatusException = aws.json.parseJsonObject(InvalidGameSessionStatusException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidRequestException = aws.json.parseJsonObject(InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?LimitExceededException = aws.json.parseJsonObject(LimitExceededException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?NotFoundException = aws.json.parseJsonObject(NotFoundException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?NotReadyException = aws.json.parseJsonObject(NotReadyException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?OutOfCapacityException = aws.json.parseJsonObject(OutOfCapacityException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?TaggingFailedException = aws.json.parseJsonObject(TaggingFailedException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?TerminalRoutingStrategyException = aws.json.parseJsonObject(TerminalRoutingStrategyException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?UnauthorizedException = aws.json.parseJsonObject(UnauthorizedException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?UnsupportedRegionException = aws.json.parseJsonObject(UnsupportedRegionException, body, arena_alloc) catch |err| switch (err) {
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
