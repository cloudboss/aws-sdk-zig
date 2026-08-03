const std = @import("std");

const DependentEntity = @import("dependent_entity.zig").DependentEntity;
const ValidationExceptionField = @import("validation_exception_field.zig").ValidationExceptionField;
const ValidationExceptionReason = @import("validation_exception_reason.zig").ValidationExceptionReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        data_encryption_exception: DataEncryptionException,
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
                .data_encryption_exception => "DataEncryptionException",
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
                .data_encryption_exception => |e| e.message,
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
                .data_encryption_exception => 400,
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
                .data_encryption_exception => |e| e.request_id,
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

/// You don't have sufficient access to perform this operation.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Updating or deleting a resource causes an inconsistent state.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// List of dependent entities containing information on relation type and
    /// resourceArns linked to the resource in use
    dependent_entities: ?[]const DependentEntity = null,

    /// Identifier of the resource in use
    resource_id: []const u8,

    /// Type of the resource in use
    resource_type: []const u8,

    pub const json_field_names = .{
        .dependent_entities = "DependentEntities",
        .message = "Message",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

/// The operation failed to due an encryption key error.
pub const DataEncryptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Unexpected error occurred while processing the request.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Advice to clients on when the call can be safely retried
    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "Message",
        .retry_after_seconds = "RetryAfterSeconds",
    };
};

/// Request references a resource that doesn't exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Hypothetical resource identifier that was not found
    resource_id: []const u8,

    /// Hypothetical resource type that was not found
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

/// Request would cause a service quota to be exceeded.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Service Quotas requirement to identify originating service
    quota_code: []const u8,

    /// Identifier of the resource affected
    resource_id: ?[]const u8 = null,

    /// Type of the resource affected
    resource_type: ?[]const u8 = null,

    /// Service Quotas requirement to identify originating quota
    service_code: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .quota_code = "QuotaCode",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .service_code = "ServiceCode",
    };
};

/// The request was denied due to request throttling.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Service Quotas requirement to identify originating service
    quota_code: ?[]const u8 = null,

    /// Advice to clients on when the call can be safely retried
    retry_after_seconds: ?i32 = null,

    /// Service Quotas requirement to identify originating quota
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .quota_code = "QuotaCode",
        .retry_after_seconds = "RetryAfterSeconds",
        .service_code = "ServiceCode",
    };
};

/// The input fails to satisfy the constraints specified by an Amazon Web
/// Services
/// service.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The fields that caused the error
    fields: ?[]const ValidationExceptionField = null,

    /// Reason the request failed validation
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
