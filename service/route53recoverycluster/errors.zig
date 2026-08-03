const std = @import("std");

const ValidationExceptionField = @import("validation_exception_field.zig").ValidationExceptionField;
const ValidationExceptionReason = @import("validation_exception_reason.zig").ValidationExceptionReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        endpoint_temporarily_unavailable_exception: EndpointTemporarilyUnavailableException,
        internal_server_exception: InternalServerException,
        resource_not_found_exception: ResourceNotFoundException,
        service_limit_exceeded_exception: ServiceLimitExceededException,
        throttling_exception: ThrottlingException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .endpoint_temporarily_unavailable_exception => "EndpointTemporarilyUnavailableException",
                .internal_server_exception => "InternalServerException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_limit_exceeded_exception => "ServiceLimitExceededException",
                .throttling_exception => "ThrottlingException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .endpoint_temporarily_unavailable_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_limit_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conflict_exception => 409,
                .endpoint_temporarily_unavailable_exception => 503,
                .internal_server_exception => 500,
                .resource_not_found_exception => 404,
                .service_limit_exceeded_exception => 402,
                .throttling_exception => 429,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .endpoint_temporarily_unavailable_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_limit_exceeded_exception => |e| e.request_id,
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

/// You don't have sufficient permissions to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There was a conflict with this request. Try again.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Identifier of the resource in use
    resource_id: []const u8,

    /// Type of the resource in use
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// The cluster endpoint isn't available. Try another cluster endpoint.
pub const EndpointTemporarilyUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There was an unexpected error during processing of the request.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "message",
        .retry_after_seconds = "retryAfterSeconds",
    };
};

/// The request references a routing control or control panel that was not
/// found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Hypothetical resource identifier that was not found
    resource_id: []const u8,

    /// Hypothetical resource type that was not found
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// The request can't update that many routing control states at the same time.
/// Try again with fewer routing control states.
pub const ServiceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The code of the limit that was exceeded.
    limit_code: []const u8,

    /// The resource identifier of the limit that was exceeded.
    resource_id: ?[]const u8 = null,

    /// The resource type of the limit that was exceeded.
    resource_type: ?[]const u8 = null,

    /// The service code of the limit that was exceeded.
    service_code: []const u8,

    pub const json_field_names = .{
        .limit_code = "limitCode",
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .service_code = "serviceCode",
    };
};

/// The request was denied because of request throttling.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "message",
        .retry_after_seconds = "retryAfterSeconds",
    };
};

/// There was a validation error on the request.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    fields: ?[]const ValidationExceptionField = null,

    reason: ?ValidationExceptionReason = null,

    pub const json_field_names = .{
        .fields = "fields",
        .message = "message",
        .reason = "reason",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
