const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        dry_run_operation: DryRunOperation,
        home_region_not_set_exception: HomeRegionNotSetException,
        internal_server_error: InternalServerError,
        invalid_input_exception: InvalidInputException,
        policy_error_exception: PolicyErrorException,
        resource_not_found_exception: ResourceNotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        throttling_exception: ThrottlingException,
        unauthorized_operation: UnauthorizedOperation,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .dry_run_operation => "DryRunOperation",
                .home_region_not_set_exception => "HomeRegionNotSetException",
                .internal_server_error => "InternalServerError",
                .invalid_input_exception => "InvalidInputException",
                .policy_error_exception => "PolicyErrorException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .throttling_exception => "ThrottlingException",
                .unauthorized_operation => "UnauthorizedOperation",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .dry_run_operation => |e| e.message,
                .home_region_not_set_exception => |e| e.message,
                .internal_server_error => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .policy_error_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unauthorized_operation => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .dry_run_operation => 400,
                .home_region_not_set_exception => 400,
                .internal_server_error => 500,
                .invalid_input_exception => 400,
                .policy_error_exception => 400,
                .resource_not_found_exception => 400,
                .service_unavailable_exception => 500,
                .throttling_exception => 429,
                .unauthorized_operation => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .dry_run_operation => |e| e.request_id,
                .home_region_not_set_exception => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .policy_error_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unauthorized_operation => |e| e.request_id,
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

pub const DryRunOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HomeRegionNotSetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyErrorException = struct {
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

pub const UnauthorizedOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
