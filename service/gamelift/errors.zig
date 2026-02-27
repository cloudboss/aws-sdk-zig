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

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FleetCapacityExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GameSessionFullException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFleetStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidGameSessionStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OutOfCapacityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TaggingFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TerminalRoutingStrategyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
