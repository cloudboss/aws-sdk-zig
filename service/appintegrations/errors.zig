const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        duplicate_resource_exception: DuplicateResourceException,
        internal_service_error: InternalServiceError,
        invalid_request_exception: InvalidRequestException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_quota_exceeded_exception: ResourceQuotaExceededException,
        throttling_exception: ThrottlingException,
        unsupported_operation_exception: UnsupportedOperationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .duplicate_resource_exception => "DuplicateResourceException",
                .internal_service_error => "InternalServiceError",
                .invalid_request_exception => "InvalidRequestException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_quota_exceeded_exception => "ResourceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .duplicate_resource_exception => |e| e.message,
                .internal_service_error => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .duplicate_resource_exception => 409,
                .internal_service_error => 500,
                .invalid_request_exception => 400,
                .resource_not_found_exception => 404,
                .resource_quota_exceeded_exception => 429,
                .throttling_exception => 429,
                .unsupported_operation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .duplicate_resource_exception => |e| e.request_id,
                .internal_service_error => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_quota_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
