const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        call_rate_limit_exceeded_exception: CallRateLimitExceededException,
        client_exception: ClientException,
        dry_run_operation_exception: DryRunOperationException,
        forbidden_exception: ForbiddenException,
        idempotent_parameter_mismatch_exception: IdempotentParameterMismatchException,
        invalid_pagination_token_exception: InvalidPaginationTokenException,
        invalid_parameter_combination_exception: InvalidParameterCombinationException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_request_exception: InvalidRequestException,
        invalid_version_number_exception: InvalidVersionNumberException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_dependency_exception: ResourceDependencyException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        service_exception: ServiceException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        service_unavailable_exception: ServiceUnavailableException,
        too_many_requests_exception: TooManyRequestsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .call_rate_limit_exceeded_exception => "CallRateLimitExceededException",
                .client_exception => "ClientException",
                .dry_run_operation_exception => "DryRunOperationException",
                .forbidden_exception => "ForbiddenException",
                .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
                .invalid_pagination_token_exception => "InvalidPaginationTokenException",
                .invalid_parameter_combination_exception => "InvalidParameterCombinationException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_request_exception => "InvalidRequestException",
                .invalid_version_number_exception => "InvalidVersionNumberException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_dependency_exception => "ResourceDependencyException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_exception => "ServiceException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .call_rate_limit_exceeded_exception => |e| e.message,
                .client_exception => |e| e.message,
                .dry_run_operation_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .idempotent_parameter_mismatch_exception => |e| e.message,
                .invalid_pagination_token_exception => |e| e.message,
                .invalid_parameter_combination_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .invalid_version_number_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_dependency_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .call_rate_limit_exceeded_exception => 429,
                .client_exception => 400,
                .dry_run_operation_exception => 412,
                .forbidden_exception => 403,
                .idempotent_parameter_mismatch_exception => 400,
                .invalid_pagination_token_exception => 400,
                .invalid_parameter_combination_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_parameter_value_exception => 400,
                .invalid_request_exception => 400,
                .invalid_version_number_exception => 400,
                .resource_already_exists_exception => 400,
                .resource_dependency_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 404,
                .service_exception => 500,
                .service_quota_exceeded_exception => 402,
                .service_unavailable_exception => 503,
                .too_many_requests_exception => 429,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .call_rate_limit_exceeded_exception => |e| e.request_id,
                .client_exception => |e| e.request_id,
                .dry_run_operation_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .idempotent_parameter_mismatch_exception => |e| e.request_id,
                .invalid_pagination_token_exception => |e| e.request_id,
                .invalid_parameter_combination_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .invalid_version_number_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_dependency_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
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

pub const CallRateLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DryRunOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPaginationTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidVersionNumberException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceDependencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
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

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
