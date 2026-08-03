const std = @import("std");

const ValidationExceptionField = @import("validation_exception_field.zig").ValidationExceptionField;
const ValidationExceptionReason = @import("validation_exception_reason.zig").ValidationExceptionReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        internal_server_exception: InternalServerException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        tag_policy_exception: TagPolicyException,
        throttling_exception: ThrottlingException,
        too_many_tags_exception: TooManyTagsException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_exception => "InternalServerException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .tag_policy_exception => "TagPolicyException",
                .throttling_exception => "ThrottlingException",
                .too_many_tags_exception => "TooManyTagsException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .tag_policy_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .internal_server_exception => 500,
                .resource_not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .tag_policy_exception => 400,
                .throttling_exception => 429,
                .too_many_tags_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .tag_policy_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
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

/// An internal server error occurred. Retry your request.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A service resource associated with the request could not be found. The
/// resource might not be specified correctly, or it may have a `state` of
/// `DELETED`.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The ID of the resource that could not be found.
    resource_id: []const u8,

    /// The type of the resource that is associated with the error.
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// The number of one or more Amazon EVS resources exceeds the maximum allowed.
/// For a list of Amazon EVS quotas, see [Amazon EVS endpoints and
/// quotas](https://docs.aws.amazon.com/evs/latest/userguide/service-quotas-evs.html) in the *Amazon EVS User Guide*. Delete some resources or request an increase in your service quota. To request an increase, see [Amazon Web Services Service Quotas](https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html) in the *Amazon Web Services General Reference Guide*.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// `TagPolicyException` is deprecated. See [ `ValidationException`
/// ](https://docs.aws.amazon.com/evs/latest/APIReference/API_ValidationException.html) instead.
///
/// The request doesn't comply with IAM tag policy. Correct your request and
/// then retry it.
pub const TagPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation could not be performed because the service is throttling
/// requests. This exception is thrown when the service endpoint receives too
/// many concurrent requests.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The seconds to wait to retry.
    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "message",
        .retry_after_seconds = "retryAfterSeconds",
    };
};

/// `TooManyTagsException` is deprecated. See [ `ServiceQuotaExceededException`
/// ](https://docs.aws.amazon.com/evs/latest/APIReference/API_ServiceQuotaExceededException.html) instead.
///
/// A service resource associated with the request has more than 200 tags.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The input fails to satisfy the specified constraints. You will see this
/// exception if invalid inputs are provided for any of the Amazon EVS
/// environment operations, or if a list operation is performed on an
/// environment resource that is still initializing.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A list of fields that didn't validate.
    field_list: ?[]const ValidationExceptionField = null,

    /// The reason for the exception.
    reason: ValidationExceptionReason,

    pub const json_field_names = .{
        .field_list = "fieldList",
        .message = "message",
        .reason = "reason",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
