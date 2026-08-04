const std = @import("std");

const ValidationExceptionField = @import("validation_exception_field.zig").ValidationExceptionField;
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

/// You don't have sufficient access to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// You don't have sufficient access to perform this action.
    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_name = "resourceName",
    };
};

/// The request could not be completed due to a conflict with the current state
/// of the resource. This exception occurs when a concurrent modification is
/// detected during an update operation, or when attempting to create a resource
/// that already exists.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The identifier of the resource that caused the conflict.
    resource_id: ?[]const u8 = null,

    /// The type of resource that caused the conflict.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// The processing request failed because of an unknown error, exception, or
/// failure.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The processing request failed because of an unknown error, exception, or
    /// failure.
    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "message",
        .retry_after_seconds = "retryAfterSeconds",
    };
};

/// The resource could not be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The resource could not be found.
    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_name = "resourceName",
    };
};

/// The request was rejected because it attempted to create resources beyond the
/// current Amazon Web Services account limits. The error message describes the
/// limit exceeded.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was denied due to request throttling.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The input fails to satisfy the constraints specified by an Amazon Web
/// Services service.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The input fails to satisfy the constraints specified by an Amazon Web
    /// Services service.
    field_list: ?[]const ValidationExceptionField = null,

    /// You don't have sufficient access to perform this action.
    reason: ?ValidationExceptionReason = null,

    /// You don't have sufficient access to perform this action.
    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_list = "fieldList",
        .message = "message",
        .reason = "reason",
        .resource_name = "resourceName",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
