const std = @import("std");

const AccessDeniedExceptionReason = @import("access_denied_exception_reason.zig").AccessDeniedExceptionReason;
const ConflictExceptionReason = @import("conflict_exception_reason.zig").ConflictExceptionReason;
const ResourceNotFoundExceptionReason = @import("resource_not_found_exception_reason.zig").ResourceNotFoundExceptionReason;
const ServiceQuotaExceededExceptionReason = @import("service_quota_exceeded_exception_reason.zig").ServiceQuotaExceededExceptionReason;
const ValidationError = @import("validation_error.zig").ValidationError;
const ValidationExceptionReason = @import("validation_exception_reason.zig").ValidationExceptionReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        internal_server_exception: InternalServerException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttling_exception: ThrottlingException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .internal_server_exception => "InternalServerException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conflict_exception => 409,
                .internal_server_exception => 500,
                .resource_not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .throttling_exception => 429,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
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

/// The request was denied due to insufficient permissions. The caller does not
/// have the required permissions to perform this operation.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The specific reason for the access denial.
    reason: AccessDeniedExceptionReason,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// The request could not be completed due to a conflict with the current state
/// of the resource. This typically occurs when trying to create a resource that
/// already exists or modify a resource that has been changed by another
/// process.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The specific reason for the conflict.
    reason: ConflictExceptionReason,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// An internal server error occurred while processing the request. This is
/// typically a temporary condition and the request may be retried.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource could not be found. This may occur when referencing a
/// resource that does not exist or has been deleted.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The specific reason why the resource was not found.
    reason: ResourceNotFoundExceptionReason,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// The request was rejected because it would exceed a service quota or limit.
/// This may occur when trying to create more resources than allowed by the
/// service limits.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The specific reason for the service quota being exceeded.
    reason: ServiceQuotaExceededExceptionReason,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// The request was throttled due to too many requests being sent in a short
/// period of time. The client should implement exponential backoff and retry
/// the request.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The quota code associated with the throttling error.
    quota_code: ?[]const u8 = null,

    /// The service code associated with the throttling error.
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .quota_code = "QuotaCode",
        .service_code = "ServiceCode",
    };
};

/// The request failed validation. One or more input parameters are invalid,
/// missing, or do not meet the required format or constraints.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A list of detailed validation errors that occurred during request
    /// processing.
    error_details: ?[]const ValidationError = null,

    /// The reason for the validation failure.
    reason: ValidationExceptionReason,

    pub const json_field_names = .{
        .error_details = "ErrorDetails",
        .message = "Message",
        .reason = "Reason",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
