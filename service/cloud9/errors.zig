const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        bad_request_exception: BadRequestException,
        concurrent_access_exception: ConcurrentAccessException,
        conflict_exception: ConflictException,
        forbidden_exception: ForbiddenException,
        internal_server_error_exception: InternalServerErrorException,
        limit_exceeded_exception: LimitExceededException,
        not_found_exception: NotFoundException,
        too_many_requests_exception: TooManyRequestsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => "BadRequestException",
                .concurrent_access_exception => "ConcurrentAccessException",
                .conflict_exception => "ConflictException",
                .forbidden_exception => "ForbiddenException",
                .internal_server_error_exception => "InternalServerErrorException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_found_exception => "NotFoundException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.message,
                .concurrent_access_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .internal_server_error_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .bad_request_exception => 400,
                .concurrent_access_exception => 400,
                .conflict_exception => 400,
                .forbidden_exception => 400,
                .internal_server_error_exception => 500,
                .limit_exceeded_exception => 400,
                .not_found_exception => 400,
                .too_many_requests_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.request_id,
                .concurrent_access_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .internal_server_error_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
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

/// The target request is invalid.
pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// A concurrent access issue occurred.
pub const ConcurrentAccessException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// A conflict occurred.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// An access permissions issue occurred.
pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// An internal server error occurred.
pub const InternalServerErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// A service limit was exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// The target resource cannot be found.
pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// Too many service requests were made over the given time period.
pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
