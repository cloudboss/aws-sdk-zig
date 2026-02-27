const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        bad_request_exception: BadRequestException,
        conflict_exception: ConflictException,
        forbidden_exception: ForbiddenException,
        limit_exceeded_exception: LimitExceededException,
        not_found_exception: NotFoundException,
        resource_not_found_exception: ResourceNotFoundException,
        service_failure_exception: ServiceFailureException,
        service_unavailable_exception: ServiceUnavailableException,
        throttling_exception: ThrottlingException,
        too_many_tags_exception: TooManyTagsException,
        unauthorized_exception: UnauthorizedException,
        unprocessable_entity_exception: UnprocessableEntityException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => "BadRequestException",
                .conflict_exception => "ConflictException",
                .forbidden_exception => "ForbiddenException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_found_exception => "NotFoundException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_failure_exception => "ServiceFailureException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .throttling_exception => "ThrottlingException",
                .too_many_tags_exception => "TooManyTagsException",
                .unauthorized_exception => "UnauthorizedException",
                .unprocessable_entity_exception => "UnprocessableEntityException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_failure_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .unprocessable_entity_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .bad_request_exception => 400,
                .conflict_exception => 409,
                .forbidden_exception => 403,
                .limit_exceeded_exception => 400,
                .not_found_exception => 404,
                .resource_not_found_exception => 404,
                .service_failure_exception => 500,
                .service_unavailable_exception => 503,
                .throttling_exception => 429,
                .too_many_tags_exception => 400,
                .unauthorized_exception => 401,
                .unprocessable_entity_exception => 422,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_failure_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
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

pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedException = struct {
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
