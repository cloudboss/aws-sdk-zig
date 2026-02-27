const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        forbidden_exception: ForbiddenException,
        idempotency_token_in_use_exception: IdempotencyTokenInUseException,
        idempotent_parameter_mismatch_exception: IdempotentParameterMismatchException,
        internal_server_exception: InternalServerException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        not_management_account_exception: NotManagementAccountException,
        opt_in_required_exception: OptInRequiredException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        service_unavailable_exception: ServiceUnavailableException,
        throttling_exception: ThrottlingException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .forbidden_exception => "ForbiddenException",
                .idempotency_token_in_use_exception => "IdempotencyTokenInUseException",
                .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
                .internal_server_exception => "InternalServerException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .not_management_account_exception => "NotManagementAccountException",
                .opt_in_required_exception => "OptInRequiredException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .throttling_exception => "ThrottlingException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .idempotency_token_in_use_exception => |e| e.message,
                .idempotent_parameter_mismatch_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .not_management_account_exception => |e| e.message,
                .opt_in_required_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .forbidden_exception => 403,
                .idempotency_token_in_use_exception => 409,
                .idempotent_parameter_mismatch_exception => 409,
                .internal_server_exception => 500,
                .invalid_parameter_value_exception => 400,
                .not_management_account_exception => 400,
                .opt_in_required_exception => 403,
                .resource_not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .service_unavailable_exception => 503,
                .throttling_exception => 429,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .idempotency_token_in_use_exception => |e| e.request_id,
                .idempotent_parameter_mismatch_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .not_management_account_exception => |e| e.request_id,
                .opt_in_required_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
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

pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotencyTokenInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotManagementAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OptInRequiredException = struct {
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

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
