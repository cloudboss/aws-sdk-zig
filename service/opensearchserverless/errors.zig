const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        conflict_exception: ConflictException,
        internal_server_exception: InternalServerException,
        ocu_limit_exceeded_exception: OcuLimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => "ConflictException",
                .internal_server_exception => "InternalServerException",
                .ocu_limit_exceeded_exception => "OcuLimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .ocu_limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .conflict_exception => 409,
                .internal_server_exception => 500,
                .ocu_limit_exceeded_exception => 402,
                .resource_not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .ocu_limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
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

/// When creating a resource, thrown when a resource with the same name already
/// exists or is being created. When deleting a resource, thrown when the
/// resource is not in the ACTIVE, FAILED, or UPDATE_FAILED state.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown when an error internal to the service occurs while processing a
/// request.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown when the collection you're attempting to create results in a number
/// of search or indexing OCUs that exceeds the account limit.
pub const OcuLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown when accessing or deleting a resource that does not exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Thrown when you attempt to create more resources than the service allows
/// based on service quotas.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Service Quotas requirement to identify originating quota.
    quota_code: ?[]const u8 = null,

    /// Identifier of the resource affected.
    resource_id: ?[]const u8 = null,

    /// Type of the resource affected.
    resource_type: ?[]const u8 = null,

    /// Service Quotas requirement to identify originating service.
    service_code: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .quota_code = "quotaCode",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .service_code = "serviceCode",
    };
};

/// Thrown when the HTTP request contains invalid input or is missing required
/// input.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
