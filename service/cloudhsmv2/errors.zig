const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        cloud_hsm_access_denied_exception: CloudHsmAccessDeniedException,
        cloud_hsm_internal_failure_exception: CloudHsmInternalFailureException,
        cloud_hsm_invalid_request_exception: CloudHsmInvalidRequestException,
        cloud_hsm_resource_limit_exceeded_exception: CloudHsmResourceLimitExceededException,
        cloud_hsm_resource_not_found_exception: CloudHsmResourceNotFoundException,
        cloud_hsm_service_exception: CloudHsmServiceException,
        cloud_hsm_tag_exception: CloudHsmTagException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .cloud_hsm_access_denied_exception => "CloudHsmAccessDeniedException",
                .cloud_hsm_internal_failure_exception => "CloudHsmInternalFailureException",
                .cloud_hsm_invalid_request_exception => "CloudHsmInvalidRequestException",
                .cloud_hsm_resource_limit_exceeded_exception => "CloudHsmResourceLimitExceededException",
                .cloud_hsm_resource_not_found_exception => "CloudHsmResourceNotFoundException",
                .cloud_hsm_service_exception => "CloudHsmServiceException",
                .cloud_hsm_tag_exception => "CloudHsmTagException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .cloud_hsm_access_denied_exception => |e| e.message,
                .cloud_hsm_internal_failure_exception => |e| e.message,
                .cloud_hsm_invalid_request_exception => |e| e.message,
                .cloud_hsm_resource_limit_exceeded_exception => |e| e.message,
                .cloud_hsm_resource_not_found_exception => |e| e.message,
                .cloud_hsm_service_exception => |e| e.message,
                .cloud_hsm_tag_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .cloud_hsm_access_denied_exception => 400,
                .cloud_hsm_internal_failure_exception => 500,
                .cloud_hsm_invalid_request_exception => 400,
                .cloud_hsm_resource_limit_exceeded_exception => 400,
                .cloud_hsm_resource_not_found_exception => 400,
                .cloud_hsm_service_exception => 400,
                .cloud_hsm_tag_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .cloud_hsm_access_denied_exception => |e| e.request_id,
                .cloud_hsm_internal_failure_exception => |e| e.request_id,
                .cloud_hsm_invalid_request_exception => |e| e.request_id,
                .cloud_hsm_resource_limit_exceeded_exception => |e| e.request_id,
                .cloud_hsm_resource_not_found_exception => |e| e.request_id,
                .cloud_hsm_service_exception => |e| e.request_id,
                .cloud_hsm_tag_exception => |e| e.request_id,
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

/// The request was rejected because the requester does not have permission to
/// perform the
/// requested operation.
pub const CloudHsmAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because of an CloudHSM internal failure. The
/// request can
/// be retried.
pub const CloudHsmInternalFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because it is not a valid request.
pub const CloudHsmInvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because it exceeds an CloudHSM limit.
pub const CloudHsmResourceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because it refers to a resource that cannot be
/// found.
pub const CloudHsmResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because an error occurred.
pub const CloudHsmServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because of a tagging failure. Verify the tag
/// conditions in all applicable policies, and then retry the request.
pub const CloudHsmTagException = struct {
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
