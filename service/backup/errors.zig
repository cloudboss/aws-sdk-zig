const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        already_exists_exception: AlreadyExistsException,
        conflict_exception: ConflictException,
        dependency_failure_exception: DependencyFailureException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_request_exception: InvalidRequestException,
        invalid_resource_state_exception: InvalidResourceStateException,
        limit_exceeded_exception: LimitExceededException,
        missing_parameter_value_exception: MissingParameterValueException,
        resource_not_found_exception: ResourceNotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => "AlreadyExistsException",
                .conflict_exception => "ConflictException",
                .dependency_failure_exception => "DependencyFailureException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_request_exception => "InvalidRequestException",
                .invalid_resource_state_exception => "InvalidResourceStateException",
                .limit_exceeded_exception => "LimitExceededException",
                .missing_parameter_value_exception => "MissingParameterValueException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .dependency_failure_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .invalid_resource_state_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .missing_parameter_value_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .already_exists_exception => 400,
                .conflict_exception => 409,
                .dependency_failure_exception => 500,
                .invalid_parameter_value_exception => 400,
                .invalid_request_exception => 400,
                .invalid_resource_state_exception => 400,
                .limit_exceeded_exception => 400,
                .missing_parameter_value_exception => 400,
                .resource_not_found_exception => 400,
                .service_unavailable_exception => 500,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .dependency_failure_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .invalid_resource_state_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .missing_parameter_value_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
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

pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DependencyFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingParameterValueException = struct {
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

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
