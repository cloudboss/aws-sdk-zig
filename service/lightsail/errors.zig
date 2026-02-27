const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        account_setup_in_progress_exception: AccountSetupInProgressException,
        invalid_input_exception: InvalidInputException,
        not_found_exception: NotFoundException,
        operation_failure_exception: OperationFailureException,
        region_setup_in_progress_exception: RegionSetupInProgressException,
        service_exception: ServiceException,
        unauthenticated_exception: UnauthenticatedException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .account_setup_in_progress_exception => "AccountSetupInProgressException",
                .invalid_input_exception => "InvalidInputException",
                .not_found_exception => "NotFoundException",
                .operation_failure_exception => "OperationFailureException",
                .region_setup_in_progress_exception => "RegionSetupInProgressException",
                .service_exception => "ServiceException",
                .unauthenticated_exception => "UnauthenticatedException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .account_setup_in_progress_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .operation_failure_exception => |e| e.message,
                .region_setup_in_progress_exception => |e| e.message,
                .service_exception => |e| e.message,
                .unauthenticated_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .account_setup_in_progress_exception => 428,
                .invalid_input_exception => 400,
                .not_found_exception => 404,
                .operation_failure_exception => 400,
                .region_setup_in_progress_exception => 428,
                .service_exception => 500,
                .unauthenticated_exception => 401,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .account_setup_in_progress_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .operation_failure_exception => |e| e.request_id,
                .region_setup_in_progress_exception => |e| e.request_id,
                .service_exception => |e| e.request_id,
                .unauthenticated_exception => |e| e.request_id,
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

pub const AccountSetupInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RegionSetupInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthenticatedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
