const std = @import("std");

const AccessDeniedExceptionReason = @import("access_denied_exception_reason.zig").AccessDeniedExceptionReason;
const ConflictExceptionReason = @import("conflict_exception_reason.zig").ConflictExceptionReason;
const ResourceType = @import("resource_type.zig").ResourceType;
const ServiceQuotaExceededExceptionReason = @import("service_quota_exceeded_exception_reason.zig").ServiceQuotaExceededExceptionReason;
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
                .access_denied_exception => 400,
                .conflict_exception => 400,
                .internal_server_exception => 500,
                .resource_not_found_exception => 400,
                .service_quota_exceeded_exception => 400,
                .throttling_exception => 400,
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

/// The request was denied because you don't have sufficient permissions to
/// access the resource.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The reason for the exception.
    reason: ?AccessDeniedExceptionReason = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// Your request has conflicting operations. This can occur if you're trying to
/// perform more than one operation on the same resource at the same time or it
/// could be that the requested action isn't valid for the current state or
/// configuration of the resource.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The reason for the exception.
    reason: ?ConflictExceptionReason = null,

    /// The unique identifier of the request.
    resource_id: ?[]const u8 = null,

    /// The type of resource that caused the exception.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

/// The API encountered an unexpected error and couldn't complete the request.
/// You might be able to successfully issue the request again in the future.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// A requested resource couldn't be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The unique identifier of the resource.
    resource_id: ?[]const u8 = null,

    /// The type of resource that caused the exception.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

/// The request would cause a service quota to be exceeded.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The reason for the exception.
    reason: ?ServiceQuotaExceededExceptionReason = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// An error that occurred because too many requests were sent during a certain
/// amount of time.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A validation exception for a field.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The field that failed validation.
    fields: ?[]const ValidationExceptionField = null,

    /// The reason for the exception.
    reason: ?ValidationExceptionReason = null,

    pub const json_field_names = .{
        .fields = "Fields",
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
