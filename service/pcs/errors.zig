const std = @import("std");

const ValidationExceptionField = @import("validation_exception_field.zig").ValidationExceptionField;
const ValidationExceptionReason = @import("validation_exception_reason.zig").ValidationExceptionReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        internal_server_exception: InternalServerException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttling_exception: ThrottlingException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .internal_server_exception => "InternalServerException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conflict_exception => 409,
                .internal_server_exception => 500,
                .resource_not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .throttling_exception => 429,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
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

/// You don't have permission to perform the action.
///
/// Examples
///
/// * The launch template instance profile doesn't pass `iam:PassRole`
///   verification.
/// * There is a mismatch between the account ID and cluster ID.
/// * The cluster ID doesn't exist.
/// * The EC2 instance isn't present.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Your request has conflicting operations. This can occur if you're trying to
/// perform more than 1 operation on the same resource at the same time.
///
/// Examples
///
/// * A cluster with the same name already exists.
/// * A cluster isn't in `ACTIVE` status.
/// * A cluster to delete is in an unstable state. For example, because it still
///   has `ACTIVE` node groups or queues.
/// * A queue already exists in a cluster.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The unique identifier of the resource that caused the conflict exception.
    resource_id: []const u8,

    /// The type or category of the resource that caused the conflict exception."
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// PCS can't process your request right now. Try again later.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested resource can't be found. The cluster, node group, or queue
/// you're attempting to get, update, list, or delete doesn't exist.
///
/// Examples
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The unique identifier of the resource that was not found.
    resource_id: []const u8,

    /// The type or category of the resource that was not found.
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// You exceeded your service quota. Service quotas, also referred to as limits,
/// are the maximum number of service resources or operations for your Amazon
/// Web Services account. To learn how to increase your service quota, see
/// [Requesting a quota
/// increase](https://docs.aws.amazon.com/servicequotas/latest/userguide/request-quota-increase.html) in the *Service Quotas User Guide*
///
/// Examples
///
/// * The max number of clusters or queues has been reached for the account.
/// * The max number of compute node groups has been reached for the associated
///   cluster.
/// * The total of `maxInstances` across all compute node groups has been
///   reached for associated cluster.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The **quota code** of the service quota that was exceeded.
    quota_code: ?[]const u8 = null,

    /// The unique identifier of the resource that caused the quota to be exceeded.
    resource_id: ?[]const u8 = null,

    /// The type or category of the resource that caused the quota to be exceeded.
    resource_type: ?[]const u8 = null,

    /// The service code associated with the quota that was exceeded.
    service_code: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .quota_code = "quotaCode",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .service_code = "serviceCode",
    };
};

/// Your request exceeded a request rate quota. Check the resource's request
/// rate quota and try again.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The number of seconds to wait before retrying the request.
    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "message",
        .retry_after_seconds = "retryAfterSeconds",
    };
};

/// The request isn't valid.
///
/// Examples
///
/// * Your request contains malformed JSON or unsupported characters.
/// * The scheduler version isn't supported.
/// * There are networking related errors, such as network validation failure.
/// * AMI type is `CUSTOM` and the launch template doesn't define the AMI ID, or
///   the AMI type is AL2 and the launch template defines the AMI.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A list of fields or properties that failed validation.
    field_list: ?[]const ValidationExceptionField = null,

    /// The specific reason or cause of the validation error.
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
