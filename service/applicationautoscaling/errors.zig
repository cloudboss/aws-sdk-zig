const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_update_exception: ConcurrentUpdateException,
        failed_resource_access_exception: FailedResourceAccessException,
        internal_service_exception: InternalServiceException,
        invalid_next_token_exception: InvalidNextTokenException,
        limit_exceeded_exception: LimitExceededException,
        object_not_found_exception: ObjectNotFoundException,
        resource_not_found_exception: ResourceNotFoundException,
        too_many_tags_exception: TooManyTagsException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_update_exception => "ConcurrentUpdateException",
                .failed_resource_access_exception => "FailedResourceAccessException",
                .internal_service_exception => "InternalServiceException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .limit_exceeded_exception => "LimitExceededException",
                .object_not_found_exception => "ObjectNotFoundException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .too_many_tags_exception => "TooManyTagsException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_update_exception => |e| e.message,
                .failed_resource_access_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .object_not_found_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_update_exception => 500,
                .failed_resource_access_exception => 400,
                .internal_service_exception => 500,
                .invalid_next_token_exception => 400,
                .limit_exceeded_exception => 400,
                .object_not_found_exception => 400,
                .resource_not_found_exception => 404,
                .too_many_tags_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_update_exception => |e| e.request_id,
                .failed_resource_access_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .object_not_found_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
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

pub const ConcurrentUpdateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FailedResourceAccessException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ObjectNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
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
