const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        container_not_found_exception: ContainerNotFoundException,
        internal_server_error: InternalServerError,
        object_not_found_exception: ObjectNotFoundException,
        requested_range_not_satisfiable_exception: RequestedRangeNotSatisfiableException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .container_not_found_exception => "ContainerNotFoundException",
                .internal_server_error => "InternalServerError",
                .object_not_found_exception => "ObjectNotFoundException",
                .requested_range_not_satisfiable_exception => "RequestedRangeNotSatisfiableException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .container_not_found_exception => |e| e.message,
                .internal_server_error => |e| e.message,
                .object_not_found_exception => |e| e.message,
                .requested_range_not_satisfiable_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .container_not_found_exception => 404,
                .internal_server_error => 500,
                .object_not_found_exception => 404,
                .requested_range_not_satisfiable_exception => 416,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .container_not_found_exception => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .object_not_found_exception => |e| e.request_id,
                .requested_range_not_satisfiable_exception => |e| e.request_id,
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

pub const ContainerNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ObjectNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestedRangeNotSatisfiableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
