const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        conflict_exception: ConflictException,
        forbidden_exception: ForbiddenException,
        internal_failure_exception: InternalFailureException,
        invalid_request_exception: InvalidRequestException,
        method_not_allowed_exception: MethodNotAllowedException,
        request_entity_too_large_exception: RequestEntityTooLargeException,
        resource_not_found_exception: ResourceNotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        throttling_exception: ThrottlingException,
        unauthorized_exception: UnauthorizedException,
        unsupported_document_encoding_exception: UnsupportedDocumentEncodingException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => "ConflictException",
                .forbidden_exception => "ForbiddenException",
                .internal_failure_exception => "InternalFailureException",
                .invalid_request_exception => "InvalidRequestException",
                .method_not_allowed_exception => "MethodNotAllowedException",
                .request_entity_too_large_exception => "RequestEntityTooLargeException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .throttling_exception => "ThrottlingException",
                .unauthorized_exception => "UnauthorizedException",
                .unsupported_document_encoding_exception => "UnsupportedDocumentEncodingException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .internal_failure_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .method_not_allowed_exception => |e| e.message,
                .request_entity_too_large_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .unsupported_document_encoding_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .conflict_exception => 409,
                .forbidden_exception => 403,
                .internal_failure_exception => 500,
                .invalid_request_exception => 400,
                .method_not_allowed_exception => 405,
                .request_entity_too_large_exception => 413,
                .resource_not_found_exception => 404,
                .service_unavailable_exception => 503,
                .throttling_exception => 429,
                .unauthorized_exception => 401,
                .unsupported_document_encoding_exception => 415,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .internal_failure_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .method_not_allowed_exception => |e| e.request_id,
                .request_entity_too_large_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
                .unsupported_document_encoding_exception => |e| e.request_id,
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

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MethodNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestEntityTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
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

pub const UnauthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedDocumentEncodingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
