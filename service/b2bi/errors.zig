const std = @import("std");

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

/// You do not have sufficient access to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A conflict exception is thrown when you attempt to delete a resource (such
/// as a profile or a capability) that is being used by other resources.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when an error occurs in the Amazon Web Services B2B
/// Data Interchange service.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The server attempts to retry a failed command.
    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "message",
        .retry_after_seconds = "retryAfterSeconds",
    };
};

/// Occurs when the requested resource does not exist, or cannot be found. In
/// some cases, the resource exists in a region other than the region specified
/// in the API call.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Occurs when the calling command attempts to exceed one of the service
/// quotas, for example trying to create a capability when you already have the
/// maximum number of capabilities allowed.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The quota that was exceeded, which caused the exception.
    quota_code: []const u8,

    /// The ID for the resource that exceeded the quota, which caused the exception.
    resource_id: []const u8,

    /// The resource type (profile, partnership, transformer, or capability) that
    /// exceeded the quota, which caused the exception.
    resource_type: []const u8,

    /// The code responsible for exceeding the quota, which caused the exception.
    service_code: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .quota_code = "quotaCode",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .service_code = "serviceCode",
    };
};

/// The request was denied due to throttling: the data speed and rendering may
/// be limited depending on various parameters and conditions.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The server attempts to retry a command that was throttled.
    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "message",
        .retry_after_seconds = "retryAfterSeconds",
    };
};

/// Occurs when a B2BI object cannot be validated against a request from another
/// object. This exception can be thrown during standard EDI validation or when
/// custom validation rules fail, such as when element length constraints are
/// violated, invalid codes are used in code list validations, or required
/// elements are missing based on configured element requirement rules.
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
