const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        already_exists_exception: AlreadyExistsException,
        client_token_conflict_exception: ClientTokenConflictException,
        concurrent_modification_exception: ConcurrentModificationException,
        concurrent_operation_exception: ConcurrentOperationException,
        general_service_exception: GeneralServiceException,
        handler_failure_exception: HandlerFailureException,
        handler_internal_failure_exception: HandlerInternalFailureException,
        invalid_credentials_exception: InvalidCredentialsException,
        invalid_request_exception: InvalidRequestException,
        network_failure_exception: NetworkFailureException,
        not_stabilized_exception: NotStabilizedException,
        not_updatable_exception: NotUpdatableException,
        private_type_exception: PrivateTypeException,
        request_token_not_found_exception: RequestTokenNotFoundException,
        resource_conflict_exception: ResourceConflictException,
        resource_not_found_exception: ResourceNotFoundException,
        service_internal_error_exception: ServiceInternalErrorException,
        service_limit_exceeded_exception: ServiceLimitExceededException,
        throttling_exception: ThrottlingException,
        type_not_found_exception: TypeNotFoundException,
        unsupported_action_exception: UnsupportedActionException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => "AlreadyExistsException",
                .client_token_conflict_exception => "ClientTokenConflictException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .concurrent_operation_exception => "ConcurrentOperationException",
                .general_service_exception => "GeneralServiceException",
                .handler_failure_exception => "HandlerFailureException",
                .handler_internal_failure_exception => "HandlerInternalFailureException",
                .invalid_credentials_exception => "InvalidCredentialsException",
                .invalid_request_exception => "InvalidRequestException",
                .network_failure_exception => "NetworkFailureException",
                .not_stabilized_exception => "NotStabilizedException",
                .not_updatable_exception => "NotUpdatableException",
                .private_type_exception => "PrivateTypeException",
                .request_token_not_found_exception => "RequestTokenNotFoundException",
                .resource_conflict_exception => "ResourceConflictException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_internal_error_exception => "ServiceInternalErrorException",
                .service_limit_exceeded_exception => "ServiceLimitExceededException",
                .throttling_exception => "ThrottlingException",
                .type_not_found_exception => "TypeNotFoundException",
                .unsupported_action_exception => "UnsupportedActionException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => |e| e.message,
                .client_token_conflict_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .concurrent_operation_exception => |e| e.message,
                .general_service_exception => |e| e.message,
                .handler_failure_exception => |e| e.message,
                .handler_internal_failure_exception => |e| e.message,
                .invalid_credentials_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .network_failure_exception => |e| e.message,
                .not_stabilized_exception => |e| e.message,
                .not_updatable_exception => |e| e.message,
                .private_type_exception => |e| e.message,
                .request_token_not_found_exception => |e| e.message,
                .resource_conflict_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_internal_error_exception => |e| e.message,
                .service_limit_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .type_not_found_exception => |e| e.message,
                .unsupported_action_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .already_exists_exception => 400,
                .client_token_conflict_exception => 409,
                .concurrent_modification_exception => 500,
                .concurrent_operation_exception => 409,
                .general_service_exception => 400,
                .handler_failure_exception => 502,
                .handler_internal_failure_exception => 502,
                .invalid_credentials_exception => 401,
                .invalid_request_exception => 400,
                .network_failure_exception => 502,
                .not_stabilized_exception => 400,
                .not_updatable_exception => 400,
                .private_type_exception => 400,
                .request_token_not_found_exception => 404,
                .resource_conflict_exception => 409,
                .resource_not_found_exception => 404,
                .service_internal_error_exception => 502,
                .service_limit_exceeded_exception => 400,
                .throttling_exception => 429,
                .type_not_found_exception => 404,
                .unsupported_action_exception => 405,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => |e| e.request_id,
                .client_token_conflict_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .concurrent_operation_exception => |e| e.request_id,
                .general_service_exception => |e| e.request_id,
                .handler_failure_exception => |e| e.request_id,
                .handler_internal_failure_exception => |e| e.request_id,
                .invalid_credentials_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .network_failure_exception => |e| e.request_id,
                .not_stabilized_exception => |e| e.request_id,
                .not_updatable_exception => |e| e.request_id,
                .private_type_exception => |e| e.request_id,
                .request_token_not_found_exception => |e| e.request_id,
                .resource_conflict_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_internal_error_exception => |e| e.request_id,
                .service_limit_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .type_not_found_exception => |e| e.request_id,
                .unsupported_action_exception => |e| e.request_id,
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

pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClientTokenConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GeneralServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HandlerFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HandlerInternalFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCredentialsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NetworkFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotStabilizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotUpdatableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PrivateTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestTokenNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceInternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TypeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedActionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
