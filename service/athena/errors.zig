const std = @import("std");

const ThrottleReason = @import("throttle_reason.zig").ThrottleReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        internal_server_exception: InternalServerException,
        invalid_request_exception: InvalidRequestException,
        metadata_exception: MetadataException,
        resource_not_found_exception: ResourceNotFoundException,
        session_already_exists_exception: SessionAlreadyExistsException,
        too_many_requests_exception: TooManyRequestsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_exception => "InternalServerException",
                .invalid_request_exception => "InvalidRequestException",
                .metadata_exception => "MetadataException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .session_already_exists_exception => "SessionAlreadyExistsException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .metadata_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .session_already_exists_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .internal_server_exception => 500,
                .invalid_request_exception => 400,
                .metadata_exception => 400,
                .resource_not_found_exception => 400,
                .session_already_exists_exception => 400,
                .too_many_requests_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .metadata_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .session_already_exists_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
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

/// Indicates a platform issue, which may be due to a transient condition or
/// outage.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Indicates that something is wrong with the input to the request. For
/// example, a
/// required parameter may be missing or out of range.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    athena_error_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .athena_error_code = "AthenaErrorCode",
        .message = "Message",
    };
};

/// An exception that Athena received when it called a custom metastore.
/// Occurs if the error is not caused by user input (`InvalidRequestException`)
/// or from the Athena platform (`InternalServerException`). For
/// example, if a user-created Lambda function is missing permissions, the
/// Lambda
/// `4XX` exception is returned in a `MetadataException`.
pub const MetadataException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A resource, such as a workgroup, was not found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The name of the Amazon resource.
    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_name = "ResourceName",
    };
};

/// The specified session already exists.
pub const SessionAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Indicates that the request was throttled.
pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    reason: ?ThrottleReason = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
