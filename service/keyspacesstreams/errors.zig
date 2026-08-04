const std = @import("std");

const ValidationExceptionType = @import("validation_exception_type.zig").ValidationExceptionType;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        internal_server_exception: InternalServerException,
        resource_not_found_exception: ResourceNotFoundException,
        throttling_exception: ThrottlingException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .internal_server_exception => "InternalServerException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .throttling_exception => "ThrottlingException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .internal_server_exception => 500,
                .resource_not_found_exception => 404,
                .throttling_exception => 429,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
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

/// You don't have sufficient access permissions to perform this operation.
///
/// This exception occurs when your IAM user or role lacks the required
/// permissions to access the Amazon Keyspaces resource or perform the requested
/// action. Check your IAM policies and ensure they grant the necessary
/// permissions.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Amazon Keyspaces service encountered an unexpected error while
/// processing the request.
///
/// This internal server error is not related to your request parameters. Retry
/// your request after a brief delay. If the issue persists, contact Amazon Web
/// Services Support with details of your request to help identify and resolve
/// the problem.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested resource doesn't exist or could not be found.
///
/// This exception occurs when you attempt to access a keyspace, table, stream,
/// or other Amazon Keyspaces resource that doesn't exist or that has been
/// deleted. Verify that the resource identifier is correct and that the
/// resource exists in your account.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request rate is too high and exceeds the service's throughput limits.
///
/// This exception occurs when you send too many requests in a short period of
/// time. Implement exponential backoff in your retry strategy to handle this
/// exception. Reducing your request frequency or distributing requests more
/// evenly can help avoid throughput exceptions.
///
/// This exception can also occur when more than two processes are reading from
/// the same stream shard at the same time. Ensure that only one process reads
/// from a stream shard at the same time.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request validation failed because one or more input parameters failed
/// validation.
///
/// This exception occurs when there are syntax errors in the request, field
/// constraints are violated, or required parameters are missing. To help you
/// fix the issue, the exception message provides details about which parameter
/// failed and why.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// An error occurred validating your request. See the error message for
    /// details.
    error_code: ?ValidationExceptionType = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
