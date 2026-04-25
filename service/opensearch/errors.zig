const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        base_exception: BaseException,
        conflict_exception: ConflictException,
        dependency_failure_exception: DependencyFailureException,
        disabled_operation_exception: DisabledOperationException,
        internal_exception: InternalException,
        invalid_pagination_token_exception: InvalidPaginationTokenException,
        invalid_type_exception: InvalidTypeException,
        limit_exceeded_exception: LimitExceededException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        slot_not_available_exception: SlotNotAvailableException,
        throttling_exception: ThrottlingException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .base_exception => "BaseException",
                .conflict_exception => "ConflictException",
                .dependency_failure_exception => "DependencyFailureException",
                .disabled_operation_exception => "DisabledOperationException",
                .internal_exception => "InternalException",
                .invalid_pagination_token_exception => "InvalidPaginationTokenException",
                .invalid_type_exception => "InvalidTypeException",
                .limit_exceeded_exception => "LimitExceededException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .slot_not_available_exception => "SlotNotAvailableException",
                .throttling_exception => "ThrottlingException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .base_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .dependency_failure_exception => |e| e.message,
                .disabled_operation_exception => |e| e.message,
                .internal_exception => |e| e.message,
                .invalid_pagination_token_exception => |e| e.message,
                .invalid_type_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .slot_not_available_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .base_exception => 400,
                .conflict_exception => 409,
                .dependency_failure_exception => 424,
                .disabled_operation_exception => 409,
                .internal_exception => 500,
                .invalid_pagination_token_exception => 400,
                .invalid_type_exception => 409,
                .limit_exceeded_exception => 409,
                .resource_already_exists_exception => 409,
                .resource_not_found_exception => 409,
                .service_quota_exceeded_exception => 402,
                .slot_not_available_exception => 409,
                .throttling_exception => 429,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .base_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .dependency_failure_exception => |e| e.request_id,
                .disabled_operation_exception => |e| e.request_id,
                .internal_exception => |e| e.request_id,
                .invalid_pagination_token_exception => |e| e.request_id,
                .invalid_type_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .slot_not_available_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
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

pub const BaseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DependencyFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DisabledOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPaginationTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
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

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SlotNotAvailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
