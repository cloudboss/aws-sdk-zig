const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        bad_request_exception: BadRequestException,
        forbidden_exception: ForbiddenException,
        internal_server_error_exception: InternalServerErrorException,
        method_not_allowed_exception: MethodNotAllowedException,
        not_found_exception: NotFoundException,
        too_many_requests_exception: TooManyRequestsException,
        unauthorized_exception: UnauthorizedException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => "BadRequestException",
                .forbidden_exception => "ForbiddenException",
                .internal_server_error_exception => "InternalServerErrorException",
                .method_not_allowed_exception => "MethodNotAllowedException",
                .not_found_exception => "NotFoundException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unauthorized_exception => "UnauthorizedException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .internal_server_error_exception => |e| e.message,
                .method_not_allowed_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .bad_request_exception => 400,
                .forbidden_exception => 403,
                .internal_server_error_exception => 500,
                .method_not_allowed_exception => 405,
                .not_found_exception => 404,
                .too_many_requests_exception => 429,
                .unauthorized_exception => 401,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .internal_server_error_exception => |e| e.request_id,
                .method_not_allowed_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
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

pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MethodNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
