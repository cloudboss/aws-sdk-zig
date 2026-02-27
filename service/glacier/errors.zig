const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        insufficient_capacity_exception: InsufficientCapacityException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        limit_exceeded_exception: LimitExceededException,
        missing_parameter_value_exception: MissingParameterValueException,
        no_longer_supported_exception: NoLongerSupportedException,
        policy_enforced_exception: PolicyEnforcedException,
        request_timeout_exception: RequestTimeoutException,
        resource_not_found_exception: ResourceNotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .insufficient_capacity_exception => "InsufficientCapacityException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .limit_exceeded_exception => "LimitExceededException",
                .missing_parameter_value_exception => "MissingParameterValueException",
                .no_longer_supported_exception => "NoLongerSupportedException",
                .policy_enforced_exception => "PolicyEnforcedException",
                .request_timeout_exception => "RequestTimeoutException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .insufficient_capacity_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .missing_parameter_value_exception => |e| e.message,
                .no_longer_supported_exception => |e| e.message,
                .policy_enforced_exception => |e| e.message,
                .request_timeout_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .insufficient_capacity_exception => 400,
                .invalid_parameter_value_exception => 400,
                .limit_exceeded_exception => 400,
                .missing_parameter_value_exception => 400,
                .no_longer_supported_exception => 400,
                .policy_enforced_exception => 400,
                .request_timeout_exception => 408,
                .resource_not_found_exception => 404,
                .service_unavailable_exception => 500,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .insufficient_capacity_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .missing_parameter_value_exception => |e| e.request_id,
                .no_longer_supported_exception => |e| e.request_id,
                .policy_enforced_exception => |e| e.request_id,
                .request_timeout_exception => |e| e.request_id,
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

pub const InsufficientCapacityException = struct {
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

pub const MissingParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoLongerSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyEnforcedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestTimeoutException = struct {
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
