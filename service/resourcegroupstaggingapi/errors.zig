const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_modification_exception: ConcurrentModificationException,
        constraint_violation_exception: ConstraintViolationException,
        internal_service_exception: InternalServiceException,
        invalid_parameter_exception: InvalidParameterException,
        pagination_token_expired_exception: PaginationTokenExpiredException,
        throttled_exception: ThrottledException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => "ConcurrentModificationException",
                .constraint_violation_exception => "ConstraintViolationException",
                .internal_service_exception => "InternalServiceException",
                .invalid_parameter_exception => "InvalidParameterException",
                .pagination_token_expired_exception => "PaginationTokenExpiredException",
                .throttled_exception => "ThrottledException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.message,
                .constraint_violation_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .pagination_token_expired_exception => |e| e.message,
                .throttled_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_modification_exception => 400,
                .constraint_violation_exception => 400,
                .internal_service_exception => 500,
                .invalid_parameter_exception => 400,
                .pagination_token_expired_exception => 400,
                .throttled_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.request_id,
                .constraint_violation_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .pagination_token_expired_exception => |e| e.request_id,
                .throttled_exception => |e| e.request_id,
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

/// The request failed because the target of the operation is currently being
/// modified by
/// a different request. Try again later.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed because performing the operation would violate a
/// constraint.
///
/// Some of the reasons in the following list might not apply to this specific
/// operation.
///
/// * You must meet the prerequisites for using tag policies. For information,
///   see
/// [Prerequisites and
/// permissions](https://docs.aws.amazon.com/tag-editor/latest/userguide/tag-policies-orgs.html#tag-policies-prereqs) in the *Tagging Amazon Web Services resources and Tag Editor* user guide.
///
/// * You must enable the tag policies service principal
/// (`tagpolicies.tag.amazonaws.com`) to integrate with Organizations For
/// information, see
/// [EnableAWSServiceAccess](https://docs.aws.amazon.com/organizations/latest/APIReference/API_EnableAWSServiceAccess.html).
///
/// * You must have a tag policy attached to the organization root, an OU, or an
/// account.
pub const ConstraintViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request processing failed because of an unknown error, exception, or
/// failure. You
/// can retry the request.
pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed because of one of the following reasons:
///
/// * A required parameter is missing.
///
/// * A provided string parameter is malformed.
///
/// * An provided parameter value is out of range.
///
/// * The target ID is invalid, unsupported, or doesn't exist.
///
/// * You can't access the Amazon S3 bucket for report storage. For more
///   information, see
/// [Amazon S3 bucket policy for report
/// storage](https://docs.aws.amazon.com/tag-editor/latest/userguide/tag-policies-orgs.html#bucket-policy) in the *Tagging Amazon Web Services resources and Tag Editor* user guide.
///
/// * The partition specified in an ARN parameter in the request doesn't match
///   the
/// partition where you invoked the operation. The partition is specified by the
/// second field of the ARN.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed because the specified `PaginationToken` has expired. A
/// `PaginationToken` is valid for a maximum of 15 minutes.
pub const PaginationTokenExpiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed because it exceeded the allowed frequency of submitted
/// requests.
pub const ThrottledException = struct {
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
