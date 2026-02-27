const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        forbidden_exception: ForbiddenException,
        internal_server_error_exception: InternalServerErrorException,
        not_found_exception: NotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        too_many_requests_exception: TooManyRequestsException,
        unprocessable_entity_exception: UnprocessableEntityException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .forbidden_exception => "ForbiddenException",
                .internal_server_error_exception => "InternalServerErrorException",
                .not_found_exception => "NotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unprocessable_entity_exception => "UnprocessableEntityException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .forbidden_exception => |e| e.message,
                .internal_server_error_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unprocessable_entity_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .forbidden_exception => 403,
                .internal_server_error_exception => 500,
                .not_found_exception => 404,
                .service_unavailable_exception => 503,
                .too_many_requests_exception => 429,
                .unprocessable_entity_exception => 422,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .forbidden_exception => |e| e.request_id,
                .internal_server_error_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .unprocessable_entity_exception => |e| e.request_id,
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

pub const InternalServerErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnprocessableEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
