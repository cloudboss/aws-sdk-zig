const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        auth_exception: AuthException,
        ec2_instance_not_found_exception: EC2InstanceNotFoundException,
        ec2_instance_state_invalid_exception: EC2InstanceStateInvalidException,
        ec2_instance_type_invalid_exception: EC2InstanceTypeInvalidException,
        ec2_instance_unavailable_exception: EC2InstanceUnavailableException,
        invalid_args_exception: InvalidArgsException,
        serial_console_access_disabled_exception: SerialConsoleAccessDisabledException,
        serial_console_session_limit_exceeded_exception: SerialConsoleSessionLimitExceededException,
        serial_console_session_unavailable_exception: SerialConsoleSessionUnavailableException,
        serial_console_session_unsupported_exception: SerialConsoleSessionUnsupportedException,
        service_exception: ServiceException,
        throttling_exception: ThrottlingException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .auth_exception => "AuthException",
                .ec2_instance_not_found_exception => "EC2InstanceNotFoundException",
                .ec2_instance_state_invalid_exception => "EC2InstanceStateInvalidException",
                .ec2_instance_type_invalid_exception => "EC2InstanceTypeInvalidException",
                .ec2_instance_unavailable_exception => "EC2InstanceUnavailableException",
                .invalid_args_exception => "InvalidArgsException",
                .serial_console_access_disabled_exception => "SerialConsoleAccessDisabledException",
                .serial_console_session_limit_exceeded_exception => "SerialConsoleSessionLimitExceededException",
                .serial_console_session_unavailable_exception => "SerialConsoleSessionUnavailableException",
                .serial_console_session_unsupported_exception => "SerialConsoleSessionUnsupportedException",
                .service_exception => "ServiceException",
                .throttling_exception => "ThrottlingException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .auth_exception => |e| e.message,
                .ec2_instance_not_found_exception => |e| e.message,
                .ec2_instance_state_invalid_exception => |e| e.message,
                .ec2_instance_type_invalid_exception => |e| e.message,
                .ec2_instance_unavailable_exception => |e| e.message,
                .invalid_args_exception => |e| e.message,
                .serial_console_access_disabled_exception => |e| e.message,
                .serial_console_session_limit_exceeded_exception => |e| e.message,
                .serial_console_session_unavailable_exception => |e| e.message,
                .serial_console_session_unsupported_exception => |e| e.message,
                .service_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .auth_exception => 403,
                .ec2_instance_not_found_exception => 404,
                .ec2_instance_state_invalid_exception => 400,
                .ec2_instance_type_invalid_exception => 400,
                .ec2_instance_unavailable_exception => 503,
                .invalid_args_exception => 400,
                .serial_console_access_disabled_exception => 403,
                .serial_console_session_limit_exceeded_exception => 400,
                .serial_console_session_unavailable_exception => 500,
                .serial_console_session_unsupported_exception => 400,
                .service_exception => 500,
                .throttling_exception => 429,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .auth_exception => |e| e.request_id,
                .ec2_instance_not_found_exception => |e| e.request_id,
                .ec2_instance_state_invalid_exception => |e| e.request_id,
                .ec2_instance_type_invalid_exception => |e| e.request_id,
                .ec2_instance_unavailable_exception => |e| e.request_id,
                .invalid_args_exception => |e| e.request_id,
                .serial_console_access_disabled_exception => |e| e.request_id,
                .serial_console_session_limit_exceeded_exception => |e| e.request_id,
                .serial_console_session_unavailable_exception => |e| e.request_id,
                .serial_console_session_unsupported_exception => |e| e.request_id,
                .service_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
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

pub const AuthException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EC2InstanceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EC2InstanceStateInvalidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EC2InstanceTypeInvalidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EC2InstanceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArgsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SerialConsoleAccessDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SerialConsoleSessionLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SerialConsoleSessionUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SerialConsoleSessionUnsupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
