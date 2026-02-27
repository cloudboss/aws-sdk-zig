const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        authorization_error_exception: AuthorizationErrorException,
        conflict_error_exception: ConflictErrorException,
        home_region_not_set_exception: HomeRegionNotSetException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        limit_exceeded_exception: LimitExceededException,
        operation_not_permitted_exception: OperationNotPermittedException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        server_internal_error_exception: ServerInternalErrorException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .authorization_error_exception => "AuthorizationErrorException",
                .conflict_error_exception => "ConflictErrorException",
                .home_region_not_set_exception => "HomeRegionNotSetException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .limit_exceeded_exception => "LimitExceededException",
                .operation_not_permitted_exception => "OperationNotPermittedException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .server_internal_error_exception => "ServerInternalErrorException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .authorization_error_exception => |e| e.message,
                .conflict_error_exception => |e| e.message,
                .home_region_not_set_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .operation_not_permitted_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .server_internal_error_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .authorization_error_exception => 403,
                .conflict_error_exception => 409,
                .home_region_not_set_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_parameter_value_exception => 400,
                .limit_exceeded_exception => 400,
                .operation_not_permitted_exception => 429,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .server_internal_error_exception => 500,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .authorization_error_exception => |e| e.request_id,
                .conflict_error_exception => |e| e.request_id,
                .home_region_not_set_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .operation_not_permitted_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .server_internal_error_exception => |e| e.request_id,
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

pub const AuthorizationErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HomeRegionNotSetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotPermittedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerInternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
