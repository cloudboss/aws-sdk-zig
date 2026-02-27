const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_modification_exception: ConcurrentModificationException,
        constraint_violation_exception: ConstraintViolationException,
        internal_service_exception: InternalServiceException,
        invalid_parameter_exception: InvalidParameterException,
        pagination_token_expired_exception: PaginationTokenExpiredException,
        throttled_exception: ThrottledException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => "ConcurrentModificationException",
                .constraint_violation_exception => "ConstraintViolationException",
                .internal_service_exception => "InternalServiceException",
                .invalid_parameter_exception => "InvalidParameterException",
                .pagination_token_expired_exception => "PaginationTokenExpiredException",
                .throttled_exception => "ThrottledException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.message,
                .constraint_violation_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .pagination_token_expired_exception => |e| e.message,
                .throttled_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_modification_exception => 400,
                .constraint_violation_exception => 400,
                .internal_service_exception => 500,
                .invalid_parameter_exception => 400,
                .pagination_token_expired_exception => 400,
                .throttled_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.request_id,
                .constraint_violation_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .pagination_token_expired_exception => |e| e.request_id,
                .throttled_exception => |e| e.request_id,
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

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConstraintViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PaginationTokenExpiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
