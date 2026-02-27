const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        concurrent_modification_exception: ConcurrentModificationException,
        conflict_exception: ConflictException,
        decryption_failure: DecryptionFailure,
        encryption_failure: EncryptionFailure,
        internal_server_exception: InternalServerException,
        resource_limit_exceeded_exception: ResourceLimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        service_exception: ServiceException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttled_exception: ThrottledException,
        throttling_exception: ThrottlingException,
        unauthorized_exception: UnauthorizedException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .conflict_exception => "ConflictException",
                .decryption_failure => "DecryptionFailure",
                .encryption_failure => "EncryptionFailure",
                .internal_server_exception => "InternalServerException",
                .resource_limit_exceeded_exception => "ResourceLimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_exception => "ServiceException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttled_exception => "ThrottledException",
                .throttling_exception => "ThrottlingException",
                .unauthorized_exception => "UnauthorizedException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .decryption_failure => |e| e.message,
                .encryption_failure => |e| e.message,
                .internal_server_exception => |e| e.message,
                .resource_limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttled_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .concurrent_modification_exception => 409,
                .conflict_exception => 409,
                .decryption_failure => 400,
                .encryption_failure => 400,
                .internal_server_exception => 500,
                .resource_limit_exceeded_exception => 400,
                .resource_not_found_exception => 404,
                .service_exception => 500,
                .service_quota_exceeded_exception => 402,
                .throttled_exception => 429,
                .throttling_exception => 429,
                .unauthorized_exception => 401,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .decryption_failure => |e| e.request_id,
                .encryption_failure => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .resource_limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .throttled_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DecryptionFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottledException = struct {
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

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
