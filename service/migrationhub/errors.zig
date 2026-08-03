const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        dry_run_operation: DryRunOperation,
        home_region_not_set_exception: HomeRegionNotSetException,
        internal_server_error: InternalServerError,
        invalid_input_exception: InvalidInputException,
        policy_error_exception: PolicyErrorException,
        resource_not_found_exception: ResourceNotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        throttling_exception: ThrottlingException,
        unauthorized_operation: UnauthorizedOperation,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .dry_run_operation => "DryRunOperation",
                .home_region_not_set_exception => "HomeRegionNotSetException",
                .internal_server_error => "InternalServerError",
                .invalid_input_exception => "InvalidInputException",
                .policy_error_exception => "PolicyErrorException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .throttling_exception => "ThrottlingException",
                .unauthorized_operation => "UnauthorizedOperation",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .dry_run_operation => |e| e.message,
                .home_region_not_set_exception => |e| e.message,
                .internal_server_error => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .policy_error_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unauthorized_operation => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .dry_run_operation => 400,
                .home_region_not_set_exception => 400,
                .internal_server_error => 500,
                .invalid_input_exception => 400,
                .policy_error_exception => 400,
                .resource_not_found_exception => 400,
                .service_unavailable_exception => 500,
                .throttling_exception => 429,
                .unauthorized_operation => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .dry_run_operation => |e| e.request_id,
                .home_region_not_set_exception => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .policy_error_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unauthorized_operation => |e| e.request_id,
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

/// You do not have sufficient access to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Exception raised to indicate a successfully authorized action when the
/// `DryRun` flag is set to "true".
pub const DryRunOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The home region is not set. Set the home region to continue.
pub const HomeRegionNotSetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Exception raised when an internal, configuration, or dependency error is
/// encountered.
pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Exception raised when the provided input violates a policy constraint or is
/// entered in
/// the wrong format or data type.
pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Exception raised when there are problems accessing Application Discovery
/// Service
/// (Application Discovery Service); most likely due to a misconfigured policy
/// or the
/// `migrationhub-discovery` role is missing or not configured correctly.
pub const PolicyErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Exception raised when the request references a resource (Application
/// Discovery Service
/// configuration, update stream, migration task, etc.) that does not exist in
/// Application
/// Discovery Service (Application Discovery Service) or in Migration Hub's
/// repository.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Exception raised when there is an internal, configuration, or dependency
/// error
/// encountered.
pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was denied due to request throttling.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The number of seconds the caller should wait before retrying.
    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "Message",
        .retry_after_seconds = "RetryAfterSeconds",
    };
};

/// Exception raised to indicate a request was not authorized when the `DryRun`
/// flag is set to "true".
pub const UnauthorizedOperation = struct {
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
