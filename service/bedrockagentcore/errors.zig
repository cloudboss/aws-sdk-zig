const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        duplicate_id_exception: DuplicateIdException,
        internal_server_exception: InternalServerException,
        invalid_input_exception: InvalidInputException,
        resource_not_found_exception: ResourceNotFoundException,
        retryable_conflict_exception: RetryableConflictException,
        runtime_client_error: RuntimeClientError,
        service_exception: ServiceException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttled_exception: ThrottledException,
        throttling_exception: ThrottlingException,
        unauthorized_exception: UnauthorizedException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .duplicate_id_exception => "DuplicateIdException",
                .internal_server_exception => "InternalServerException",
                .invalid_input_exception => "InvalidInputException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .retryable_conflict_exception => "RetryableConflictException",
                .runtime_client_error => "RuntimeClientError",
                .service_exception => "ServiceException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttled_exception => "ThrottledException",
                .throttling_exception => "ThrottlingException",
                .unauthorized_exception => "UnauthorizedException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .duplicate_id_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .retryable_conflict_exception => |e| e.message,
                .runtime_client_error => |e| e.message,
                .service_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttled_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conflict_exception => 409,
                .duplicate_id_exception => 409,
                .internal_server_exception => 500,
                .invalid_input_exception => 400,
                .resource_not_found_exception => 404,
                .retryable_conflict_exception => 409,
                .runtime_client_error => 424,
                .service_exception => 500,
                .service_quota_exceeded_exception => 402,
                .throttled_exception => 429,
                .throttling_exception => 429,
                .unauthorized_exception => 401,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .duplicate_id_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .retryable_conflict_exception => |e| e.request_id,
                .runtime_client_error => |e| e.request_id,
                .service_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .throttled_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
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

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RetryableConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RuntimeClientError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedException = struct {
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
