const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        internal_exception: InternalException,
        invalid_request_exception: InvalidRequestException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .internal_exception => "InternalException",
                .invalid_request_exception => "InvalidRequestException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .internal_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .internal_exception => 500,
                .invalid_request_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .internal_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
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

/// This exception is thrown when an error occurs in the DataSync
/// service.
pub const InternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    error_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .message = "message",
    };
};

/// This exception is thrown when the client submits a malformed request.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    datasync_error_code: ?[]const u8 = null,

    error_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .datasync_error_code = "datasyncErrorCode",
        .error_code = "errorCode",
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
