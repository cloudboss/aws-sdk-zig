const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_forbidden: AccessForbidden,
        internal_failure: InternalFailure,
        resource_not_found: ResourceNotFound,
        service_unavailable: ServiceUnavailable,
        validation_error: ValidationError,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_forbidden => "AccessForbidden",
                .internal_failure => "InternalFailure",
                .resource_not_found => "ResourceNotFound",
                .service_unavailable => "ServiceUnavailable",
                .validation_error => "ValidationError",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_forbidden => |e| e.message,
                .internal_failure => |e| e.message,
                .resource_not_found => |e| e.message,
                .service_unavailable => |e| e.message,
                .validation_error => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_forbidden => 403,
                .internal_failure => 500,
                .resource_not_found => 404,
                .service_unavailable => 503,
                .validation_error => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_forbidden => |e| e.request_id,
                .internal_failure => |e| e.request_id,
                .resource_not_found => |e| e.request_id,
                .service_unavailable => |e| e.request_id,
                .validation_error => |e| e.request_id,
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

pub const AccessForbidden = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailable = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
