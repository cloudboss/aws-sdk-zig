const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        authorization_exception: AuthorizationException,
        conflict_exception: ConflictException,
        entitlement_not_allowed_exception: EntitlementNotAllowedException,
        failed_dependency_exception: FailedDependencyException,
        filter_limit_exceeded_exception: FilterLimitExceededException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_resource_state_exception: InvalidResourceStateException,
        license_usage_exception: LicenseUsageException,
        no_entitlements_allowed_exception: NoEntitlementsAllowedException,
        rate_limit_exceeded_exception: RateLimitExceededException,
        redirect_exception: RedirectException,
        resource_limit_exceeded_exception: ResourceLimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        server_internal_exception: ServerInternalException,
        unsupported_digital_signature_method_exception: UnsupportedDigitalSignatureMethodException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .authorization_exception => "AuthorizationException",
                .conflict_exception => "ConflictException",
                .entitlement_not_allowed_exception => "EntitlementNotAllowedException",
                .failed_dependency_exception => "FailedDependencyException",
                .filter_limit_exceeded_exception => "FilterLimitExceededException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_resource_state_exception => "InvalidResourceStateException",
                .license_usage_exception => "LicenseUsageException",
                .no_entitlements_allowed_exception => "NoEntitlementsAllowedException",
                .rate_limit_exceeded_exception => "RateLimitExceededException",
                .redirect_exception => "RedirectException",
                .resource_limit_exceeded_exception => "ResourceLimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .server_internal_exception => "ServerInternalException",
                .unsupported_digital_signature_method_exception => "UnsupportedDigitalSignatureMethodException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .authorization_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .entitlement_not_allowed_exception => |e| e.message,
                .failed_dependency_exception => |e| e.message,
                .filter_limit_exceeded_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_resource_state_exception => |e| e.message,
                .license_usage_exception => |e| e.message,
                .no_entitlements_allowed_exception => |e| e.message,
                .rate_limit_exceeded_exception => |e| e.message,
                .redirect_exception => |e| e.message,
                .resource_limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .server_internal_exception => |e| e.message,
                .unsupported_digital_signature_method_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 401,
                .authorization_exception => 403,
                .conflict_exception => 409,
                .entitlement_not_allowed_exception => 400,
                .failed_dependency_exception => 424,
                .filter_limit_exceeded_exception => 400,
                .invalid_parameter_value_exception => 400,
                .invalid_resource_state_exception => 400,
                .license_usage_exception => 412,
                .no_entitlements_allowed_exception => 400,
                .rate_limit_exceeded_exception => 429,
                .redirect_exception => 308,
                .resource_limit_exceeded_exception => 400,
                .resource_not_found_exception => 400,
                .server_internal_exception => 500,
                .unsupported_digital_signature_method_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .authorization_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .entitlement_not_allowed_exception => |e| e.request_id,
                .failed_dependency_exception => |e| e.request_id,
                .filter_limit_exceeded_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_resource_state_exception => |e| e.request_id,
                .license_usage_exception => |e| e.request_id,
                .no_entitlements_allowed_exception => |e| e.request_id,
                .rate_limit_exceeded_exception => |e| e.request_id,
                .redirect_exception => |e| e.request_id,
                .resource_limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .server_internal_exception => |e| e.request_id,
                .unsupported_digital_signature_method_exception => |e| e.request_id,
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

/// Access to resource denied.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The Amazon Web Services user account does not have permission to perform the
/// action. Check the IAM
/// policy associated with this account.
pub const AuthorizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// There was a conflict processing the request. Try your request again.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The entitlement is not allowed.
pub const EntitlementNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A dependency required to run the API is missing.
pub const FailedDependencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    error_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};

/// The request uses too many filters or too many filter values.
pub const FilterLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// One or more parameter values are not valid.
pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// License Manager cannot allocate a license to a resource because of its
/// state.
///
/// For example, you cannot allocate a license to an instance in the process of
/// shutting
/// down.
pub const InvalidResourceStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You do not have enough licenses available to support a new resource launch.
pub const LicenseUsageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// There are no entitlements found for this license, or the entitlement maximum
/// count is reached.
pub const NoEntitlementsAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Too many requests have been submitted. Try again after a brief wait.
pub const RateLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This is not the correct Region for the resource. Try again.
pub const RedirectException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    location: ?[]const u8 = null,

    pub const json_field_names = .{
        .location = "Location",
        .message = "Message",
    };
};

/// Your resource limits have been exceeded.
pub const ResourceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource cannot be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The server experienced an internal error. Try again.
pub const ServerInternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The digital signature method is unsupported. Try your request again.
pub const UnsupportedDigitalSignatureMethodException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The provided input is not valid. Try your request again.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
