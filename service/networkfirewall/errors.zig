const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        insufficient_capacity_exception: InsufficientCapacityException,
        internal_server_error: InternalServerError,
        invalid_operation_exception: InvalidOperationException,
        invalid_request_exception: InvalidRequestException,
        invalid_resource_policy_exception: InvalidResourcePolicyException,
        invalid_token_exception: InvalidTokenException,
        limit_exceeded_exception: LimitExceededException,
        log_destination_permission_exception: LogDestinationPermissionException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_owner_check_exception: ResourceOwnerCheckException,
        throttling_exception: ThrottlingException,
        unsupported_operation_exception: UnsupportedOperationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .insufficient_capacity_exception => "InsufficientCapacityException",
                .internal_server_error => "InternalServerError",
                .invalid_operation_exception => "InvalidOperationException",
                .invalid_request_exception => "InvalidRequestException",
                .invalid_resource_policy_exception => "InvalidResourcePolicyException",
                .invalid_token_exception => "InvalidTokenException",
                .limit_exceeded_exception => "LimitExceededException",
                .log_destination_permission_exception => "LogDestinationPermissionException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_owner_check_exception => "ResourceOwnerCheckException",
                .throttling_exception => "ThrottlingException",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .insufficient_capacity_exception => |e| e.message,
                .internal_server_error => |e| e.message,
                .invalid_operation_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .invalid_resource_policy_exception => |e| e.message,
                .invalid_token_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .log_destination_permission_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_owner_check_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .insufficient_capacity_exception => 500,
                .internal_server_error => 500,
                .invalid_operation_exception => 400,
                .invalid_request_exception => 400,
                .invalid_resource_policy_exception => 400,
                .invalid_token_exception => 400,
                .limit_exceeded_exception => 400,
                .log_destination_permission_exception => 400,
                .resource_not_found_exception => 400,
                .resource_owner_check_exception => 400,
                .throttling_exception => 400,
                .unsupported_operation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .insufficient_capacity_exception => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .invalid_operation_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .invalid_resource_policy_exception => |e| e.request_id,
                .invalid_token_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .log_destination_permission_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_owner_check_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
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

pub const InsufficientCapacityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourcePolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LogDestinationPermissionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceOwnerCheckException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
