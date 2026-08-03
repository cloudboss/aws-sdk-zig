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

/// Indicates insufficient permissions to perform the requested action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Signals a conflict with the current state of the resource.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Identifier of the conflicting resource.
    resource_id: []const u8,

    /// Type of the conflicting resource.
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

/// Indicates an unexpected server-side error occurred.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Recommended wait time before retrying the request.
    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "Message",
        .retry_after_seconds = "RetryAfterSeconds",
    };
};

/// Indicates the requested resource could not be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Identifier of the resource that was not found.
    resource_id: []const u8,

    /// Type of the resource that was not found.
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

/// Indicates that a service quota has been exceeded.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Specific code for the exceeded quota.
    quota_code: []const u8,

    /// Identifier of the resource related to the quota.
    resource_id: []const u8,

    /// Type of resource related to the quota.
    resource_type: []const u8,

    /// Code identifying the service with the quota limitation.
    service_code: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .quota_code = "QuotaCode",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .service_code = "ServiceCode",
    };
};

/// Indicates the request rate has exceeded limits.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Specific code for the throttling quota.
    quota_code: ?[]const u8 = null,

    /// Recommended wait time before retrying the request.
    retry_after_seconds: ?i32 = null,

    /// Code identifying the service experiencing throttling.
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .quota_code = "QuotaCode",
        .retry_after_seconds = "RetryAfterSeconds",
        .service_code = "ServiceCode",
    };
};

/// Indicates invalid input parameters in the request.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// List of fields that failed validation.
    field_list: ?[]const ValidationExceptionField = null,

    /// Specific reason for the validation failure.
    reason: ValidationExceptionReason,

    pub const json_field_names = .{
        .field_list = "FieldList",
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
