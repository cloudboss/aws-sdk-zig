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

/// Thrown if there are parallel requests to modify a resource.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The provided developer user identifier is already registered with Cognito
/// under a
/// different identity ID.
pub const DeveloperUserAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An exception thrown when a dependent service such as Facebook or Twitter is
/// not
/// responding
pub const ExternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown when the service encounters an error during processing the request.
pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// If you provided authentication information in the request, the identity pool
/// has no
/// authenticated role configured, or STS returned an error response to the
/// request to assume the authenticated role from the identity pool. If you
/// provided no
/// authentication information in the request, the identity pool has no
/// unauthenticated role
/// configured, or STS returned an error response to the request to assume the
/// unauthenticated role from the identity pool.
///
/// Your role trust policy must grant `AssumeRoleWithWebIdentity` permissions to
/// `cognito-identity.amazonaws.com`.
pub const InvalidIdentityPoolConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown for missing or bad input parameter(s).
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown when the total number of user pools has exceeded a preset limit.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown when a user is not authorized to access the requested resource.
pub const NotAuthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown when a user tries to use a login which is already linked to another
/// account.
pub const ResourceConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown when the requested resource (for example, a dataset or record) does
/// not
/// exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown when a request is throttled.
pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
