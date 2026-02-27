const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_modification_exception: ConcurrentModificationException,
        developer_user_already_registered_exception: DeveloperUserAlreadyRegisteredException,
        external_service_exception: ExternalServiceException,
        internal_error_exception: InternalErrorException,
        invalid_identity_pool_configuration_exception: InvalidIdentityPoolConfigurationException,
        invalid_parameter_exception: InvalidParameterException,
        limit_exceeded_exception: LimitExceededException,
        not_authorized_exception: NotAuthorizedException,
        resource_conflict_exception: ResourceConflictException,
        resource_not_found_exception: ResourceNotFoundException,
        too_many_requests_exception: TooManyRequestsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => "ConcurrentModificationException",
                .developer_user_already_registered_exception => "DeveloperUserAlreadyRegisteredException",
                .external_service_exception => "ExternalServiceException",
                .internal_error_exception => "InternalErrorException",
                .invalid_identity_pool_configuration_exception => "InvalidIdentityPoolConfigurationException",
                .invalid_parameter_exception => "InvalidParameterException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_authorized_exception => "NotAuthorizedException",
                .resource_conflict_exception => "ResourceConflictException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.message,
                .developer_user_already_registered_exception => |e| e.message,
                .external_service_exception => |e| e.message,
                .internal_error_exception => |e| e.message,
                .invalid_identity_pool_configuration_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_authorized_exception => |e| e.message,
                .resource_conflict_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_modification_exception => 400,
                .developer_user_already_registered_exception => 400,
                .external_service_exception => 400,
                .internal_error_exception => 500,
                .invalid_identity_pool_configuration_exception => 400,
                .invalid_parameter_exception => 400,
                .limit_exceeded_exception => 400,
                .not_authorized_exception => 403,
                .resource_conflict_exception => 409,
                .resource_not_found_exception => 404,
                .too_many_requests_exception => 429,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.request_id,
                .developer_user_already_registered_exception => |e| e.request_id,
                .external_service_exception => |e| e.request_id,
                .internal_error_exception => |e| e.request_id,
                .invalid_identity_pool_configuration_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_authorized_exception => |e| e.request_id,
                .resource_conflict_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
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

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeveloperUserAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidIdentityPoolConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotAuthorizedException = struct {
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
