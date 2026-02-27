const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        api_key_limit_exceeded_exception: ApiKeyLimitExceededException,
        api_key_validity_out_of_bounds_exception: ApiKeyValidityOutOfBoundsException,
        api_limit_exceeded_exception: ApiLimitExceededException,
        bad_request_exception: BadRequestException,
        concurrent_modification_exception: ConcurrentModificationException,
        conflict_exception: ConflictException,
        graph_ql_schema_exception: GraphQLSchemaException,
        internal_failure_exception: InternalFailureException,
        limit_exceeded_exception: LimitExceededException,
        not_found_exception: NotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        unauthorized_exception: UnauthorizedException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .api_key_limit_exceeded_exception => "ApiKeyLimitExceededException",
                .api_key_validity_out_of_bounds_exception => "ApiKeyValidityOutOfBoundsException",
                .api_limit_exceeded_exception => "ApiLimitExceededException",
                .bad_request_exception => "BadRequestException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .conflict_exception => "ConflictException",
                .graph_ql_schema_exception => "GraphQLSchemaException",
                .internal_failure_exception => "InternalFailureException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_found_exception => "NotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .unauthorized_exception => "UnauthorizedException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .api_key_limit_exceeded_exception => |e| e.message,
                .api_key_validity_out_of_bounds_exception => |e| e.message,
                .api_limit_exceeded_exception => |e| e.message,
                .bad_request_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .graph_ql_schema_exception => |e| e.message,
                .internal_failure_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .api_key_limit_exceeded_exception => 400,
                .api_key_validity_out_of_bounds_exception => 400,
                .api_limit_exceeded_exception => 400,
                .bad_request_exception => 400,
                .concurrent_modification_exception => 409,
                .conflict_exception => 409,
                .graph_ql_schema_exception => 400,
                .internal_failure_exception => 500,
                .limit_exceeded_exception => 429,
                .not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .unauthorized_exception => 401,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .api_key_limit_exceeded_exception => |e| e.request_id,
                .api_key_validity_out_of_bounds_exception => |e| e.request_id,
                .api_limit_exceeded_exception => |e| e.request_id,
                .bad_request_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .graph_ql_schema_exception => |e| e.request_id,
                .internal_failure_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApiKeyLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApiKeyValidityOutOfBoundsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApiLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BadRequestException = struct {
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

pub const GraphQLSchemaException = struct {
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

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
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
