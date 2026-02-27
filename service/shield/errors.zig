const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        access_denied_for_dependency_exception: AccessDeniedForDependencyException,
        internal_error_exception: InternalErrorException,
        invalid_operation_exception: InvalidOperationException,
        invalid_pagination_token_exception: InvalidPaginationTokenException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_resource_exception: InvalidResourceException,
        limits_exceeded_exception: LimitsExceededException,
        locked_subscription_exception: LockedSubscriptionException,
        no_associated_role_exception: NoAssociatedRoleException,
        optimistic_lock_exception: OptimisticLockException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .access_denied_for_dependency_exception => "AccessDeniedForDependencyException",
                .internal_error_exception => "InternalErrorException",
                .invalid_operation_exception => "InvalidOperationException",
                .invalid_pagination_token_exception => "InvalidPaginationTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_resource_exception => "InvalidResourceException",
                .limits_exceeded_exception => "LimitsExceededException",
                .locked_subscription_exception => "LockedSubscriptionException",
                .no_associated_role_exception => "NoAssociatedRoleException",
                .optimistic_lock_exception => "OptimisticLockException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .access_denied_for_dependency_exception => |e| e.message,
                .internal_error_exception => |e| e.message,
                .invalid_operation_exception => |e| e.message,
                .invalid_pagination_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_resource_exception => |e| e.message,
                .limits_exceeded_exception => |e| e.message,
                .locked_subscription_exception => |e| e.message,
                .no_associated_role_exception => |e| e.message,
                .optimistic_lock_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .access_denied_for_dependency_exception => 400,
                .internal_error_exception => 500,
                .invalid_operation_exception => 400,
                .invalid_pagination_token_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_resource_exception => 400,
                .limits_exceeded_exception => 400,
                .locked_subscription_exception => 400,
                .no_associated_role_exception => 400,
                .optimistic_lock_exception => 400,
                .resource_already_exists_exception => 400,
                .resource_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .access_denied_for_dependency_exception => |e| e.request_id,
                .internal_error_exception => |e| e.request_id,
                .invalid_operation_exception => |e| e.request_id,
                .invalid_pagination_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_resource_exception => |e| e.request_id,
                .limits_exceeded_exception => |e| e.request_id,
                .locked_subscription_exception => |e| e.request_id,
                .no_associated_role_exception => |e| e.request_id,
                .optimistic_lock_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccessDeniedForDependencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPaginationTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LockedSubscriptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoAssociatedRoleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OptimisticLockException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
