const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        bad_gateway_exception: BadGatewayException,
        bad_request_exception: BadRequestException,
        conflict_exception: ConflictException,
        dependency_failed_exception: DependencyFailedException,
        internal_failure_exception: InternalFailureException,
        limit_exceeded_exception: LimitExceededException,
        loop_detected_exception: LoopDetectedException,
        not_acceptable_exception: NotAcceptableException,
        not_found_exception: NotFoundException,
        request_timeout_exception: RequestTimeoutException,
        unsupported_media_type_exception: UnsupportedMediaTypeException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .bad_gateway_exception => "BadGatewayException",
                .bad_request_exception => "BadRequestException",
                .conflict_exception => "ConflictException",
                .dependency_failed_exception => "DependencyFailedException",
                .internal_failure_exception => "InternalFailureException",
                .limit_exceeded_exception => "LimitExceededException",
                .loop_detected_exception => "LoopDetectedException",
                .not_acceptable_exception => "NotAcceptableException",
                .not_found_exception => "NotFoundException",
                .request_timeout_exception => "RequestTimeoutException",
                .unsupported_media_type_exception => "UnsupportedMediaTypeException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .bad_gateway_exception => |e| e.message,
                .bad_request_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .dependency_failed_exception => |e| e.message,
                .internal_failure_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .loop_detected_exception => |e| e.message,
                .not_acceptable_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .request_timeout_exception => |e| e.message,
                .unsupported_media_type_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .bad_gateway_exception => 502,
                .bad_request_exception => 400,
                .conflict_exception => 409,
                .dependency_failed_exception => 424,
                .internal_failure_exception => 500,
                .limit_exceeded_exception => 429,
                .loop_detected_exception => 508,
                .not_acceptable_exception => 406,
                .not_found_exception => 404,
                .request_timeout_exception => 408,
                .unsupported_media_type_exception => 415,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .bad_gateway_exception => |e| e.request_id,
                .bad_request_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .dependency_failed_exception => |e| e.request_id,
                .internal_failure_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .loop_detected_exception => |e| e.request_id,
                .not_acceptable_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .request_timeout_exception => |e| e.request_id,
                .unsupported_media_type_exception => |e| e.request_id,
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

pub const BadGatewayException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DependencyFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LoopDetectedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotAcceptableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedMediaTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
