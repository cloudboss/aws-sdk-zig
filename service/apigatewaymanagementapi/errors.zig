const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        forbidden_exception: ForbiddenException,
        gone_exception: GoneException,
        limit_exceeded_exception: LimitExceededException,
        payload_too_large_exception: PayloadTooLargeException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .forbidden_exception => "ForbiddenException",
                .gone_exception => "GoneException",
                .limit_exceeded_exception => "LimitExceededException",
                .payload_too_large_exception => "PayloadTooLargeException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .forbidden_exception => |e| e.message,
                .gone_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .payload_too_large_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .forbidden_exception => 403,
                .gone_exception => 410,
                .limit_exceeded_exception => 429,
                .payload_too_large_exception => 413,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .forbidden_exception => |e| e.request_id,
                .gone_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .payload_too_large_exception => |e| e.request_id,
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

pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GoneException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PayloadTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
