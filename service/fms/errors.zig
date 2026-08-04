const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        internal_error_exception: InternalErrorException,
        invalid_input_exception: InvalidInputException,
        invalid_operation_exception: InvalidOperationException,
        invalid_type_exception: InvalidTypeException,
        limit_exceeded_exception: LimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .internal_error_exception => "InternalErrorException",
                .invalid_input_exception => "InvalidInputException",
                .invalid_operation_exception => "InvalidOperationException",
                .invalid_type_exception => "InvalidTypeException",
                .limit_exceeded_exception => "LimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .internal_error_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .invalid_operation_exception => |e| e.message,
                .invalid_type_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .internal_error_exception => 400,
                .invalid_input_exception => 400,
                .invalid_operation_exception => 400,
                .invalid_type_exception => 400,
                .limit_exceeded_exception => 400,
                .resource_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .internal_error_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .invalid_operation_exception => |e| e.request_id,
                .invalid_type_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
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

/// The operation failed because of a system problem, even though the request
/// was valid. Retry
/// your request.
pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The parameters of the request were invalid.
pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operation failed because there was nothing to do or the operation wasn't
/// possible. For example, you might have
/// submitted an `AssociateAdminAccount` request for an account ID that
/// was already set as the Firewall Manager administrator. Or you might have
/// tried to access a Region
/// that's disabled by default, and that you need to enable for the Firewall
/// Manager
/// administrator account and for Organizations before you can access it.
pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The value of the `Type` parameter is invalid.
pub const InvalidTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operation exceeds a resource limit, for example, the maximum number of
/// `policy` objects that you can create for an Amazon Web Services account. For
/// more information,
/// see [Firewall
/// Manager
/// Limits](https://docs.aws.amazon.com/waf/latest/developerguide/fms-limits.html) in the *WAF Developer Guide*.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource was not found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
