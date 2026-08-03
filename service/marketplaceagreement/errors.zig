const std = @import("std");

const AccessDeniedExceptionReason = @import("access_denied_exception_reason.zig").AccessDeniedExceptionReason;
const ResourceType = @import("resource_type.zig").ResourceType;
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

/// User does not have sufficient access to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The reason for the access denied exception.
    reason: ?AccessDeniedExceptionReason = null,

    pub const json_field_names = .{
        .message = "message",
        .reason = "reason",
        .request_id = "requestId",
    };
};

/// Request was denied due to a resource conflict.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The unique identifier of the resource involved in the conflict.
    resource_id: ?[]const u8 = null,

    /// The type of the resource involved in the conflict.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .message = "message",
        .request_id = "requestId",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// Unexpected error during processing of request.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
        .request_id = "requestId",
    };
};

/// Request references a resource which does not exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The unique identifier for the resource.
    resource_id: ?[]const u8 = null,

    /// The type of resource.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .message = "message",
        .request_id = "requestId",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// Request exceeded the maximum allowed limit (quota) for a specific resource
/// or API operation.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The code of the quota that was exceeded.
    quota_code: ?[]const u8 = null,

    /// The unique identifier of the resource that exceeded the quota.
    resource_id: ?[]const u8 = null,

    /// The type of the resource that exceeded the quota.
    resource_type: ?[]const u8 = null,

    /// The code of the service whose quota was exceeded.
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .quota_code = "quotaCode",
        .request_id = "requestId",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .service_code = "serviceCode",
    };
};

/// Request was denied due to request throttling.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
        .request_id = "requestId",
    };
};

/// The input fails to satisfy the constraints specified by the service.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The fields associated with the error.
    fields: ?[]const ValidationExceptionField = null,

    /// The reason associated with the error.
    reason: ?ValidationExceptionReason = null,

    pub const json_field_names = .{
        .fields = "fields",
        .message = "message",
        .reason = "reason",
        .request_id = "requestId",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
