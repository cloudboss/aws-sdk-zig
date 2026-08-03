const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        billing_view_health_status_exception: BillingViewHealthStatusException,
        creation_limit_exceeded_exception: CreationLimitExceededException,
        duplicate_record_exception: DuplicateRecordException,
        expired_next_token_exception: ExpiredNextTokenException,
        internal_error_exception: InternalErrorException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_parameter_exception: InvalidParameterException,
        not_found_exception: NotFoundException,
        resource_locked_exception: ResourceLockedException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttling_exception: ThrottlingException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .billing_view_health_status_exception => "BillingViewHealthStatusException",
                .creation_limit_exceeded_exception => "CreationLimitExceededException",
                .duplicate_record_exception => "DuplicateRecordException",
                .expired_next_token_exception => "ExpiredNextTokenException",
                .internal_error_exception => "InternalErrorException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .not_found_exception => "NotFoundException",
                .resource_locked_exception => "ResourceLockedException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .billing_view_health_status_exception => |e| e.message,
                .creation_limit_exceeded_exception => |e| e.message,
                .duplicate_record_exception => |e| e.message,
                .expired_next_token_exception => |e| e.message,
                .internal_error_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .resource_locked_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .billing_view_health_status_exception => 400,
                .creation_limit_exceeded_exception => 405,
                .duplicate_record_exception => 409,
                .expired_next_token_exception => 400,
                .internal_error_exception => 500,
                .invalid_next_token_exception => 400,
                .invalid_parameter_exception => 400,
                .not_found_exception => 404,
                .resource_locked_exception => 423,
                .service_quota_exceeded_exception => 402,
                .throttling_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .billing_view_health_status_exception => |e| e.request_id,
                .creation_limit_exceeded_exception => |e| e.request_id,
                .duplicate_record_exception => |e| e.request_id,
                .expired_next_token_exception => |e| e.request_id,
                .internal_error_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .resource_locked_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
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

/// You are not authorized to use this operation with the given parameters.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The billing view status must be HEALTHY to perform this action. Try again
/// when the status is HEALTHY.
pub const BillingViewHealthStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You've exceeded the notification or subscriber limit.
pub const CreationLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The budget name already exists. Budget names must be unique within an
/// account.
pub const DuplicateRecordException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The pagination token expired.
pub const ExpiredNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An error on the server occurred during the processing of your request. Try
/// again later.
pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The pagination token is invalid.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An error on the client occurred. Typically, the cause is an invalid input
/// value.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can’t locate the resource that you specified.
pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was received and recognized by the server, but the server
/// rejected that
/// particular method for the requested resource.
pub const ResourceLockedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You've reached a Service Quota limit on this resource.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The number of API requests has exceeded the maximum allowed API request
/// throttling limit
/// for the account.
pub const ThrottlingException = struct {
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
