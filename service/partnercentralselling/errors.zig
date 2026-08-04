const std = @import("std");

const AccessDeniedExceptionErrorCode = @import("access_denied_exception_error_code.zig").AccessDeniedExceptionErrorCode;
const ValidationExceptionError = @import("validation_exception_error.zig").ValidationExceptionError;
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

/// This error occurs when you don't have permission to perform the requested
/// action.
///
/// You don’t have access to this action or resource. Review IAM policies or
/// contact your AWS administrator for assistance.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The reason why access was denied for the requested operation.
    reason: ?AccessDeniedExceptionErrorCode = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// This error occurs when the request can’t be processed due to a conflict with
/// the target resource's current state, which could result from updating or
/// deleting the resource.
///
/// Suggested action: Fetch the latest state of the resource, verify the state,
/// and retry the request.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This error occurs when the specified resource can’t be found or doesn't
/// exist. Resource ID and type might be incorrect.
///
/// Suggested action: This is usually a transient error. Retry after the
/// provided retry delay or a short interval. If the problem persists, contact
/// AWS support.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This error occurs when the specified resource can't be found. The resource
/// might not exist, or isn't visible with the current credentials.
///
/// Suggested action: Verify that the resource ID is correct and the resource is
/// in the expected AWS region. Check IAM permissions for accessing the
/// resource.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This error occurs when the request would cause a service quota to be
/// exceeded. Service quotas represent the maximum allowed use of a specific
/// resource, and this error indicates that the request would surpass that
/// limit.
///
/// Suggested action: Review the
/// [Quotas](https://docs.aws.amazon.com/partner-central/latest/selling-api/quotas.html) for the resource, and either reduce usage or request a quota increase.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This error occurs when there are too many requests sent. Review the provided
/// quotas and adapt your usage to avoid throttling.
///
/// This error occurs when there are too many requests sent. Review the provided
/// [Quotas](https://docs.aws.amazon.com/partner-central/latest/selling-api/quotas.html) and retry after the provided delay.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The input fails to satisfy the constraints specified by the service or
/// business validation rules.
///
/// Suggested action: Review the error message, including the failed fields and
/// reasons, to correct the request payload.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A list of issues that were discovered in the submitted request or the
    /// resource state.
    error_list: ?[]const ValidationExceptionError = null,

    /// The primary reason for this validation exception to occur.
    ///
    /// * *REQUEST_VALIDATION_FAILED:* The request format is not valid.
    ///
    /// Fix: Verify your request payload includes all required fields, uses correct
    /// data types and string formats.
    /// * *BUSINESS_VALIDATION_FAILED:* The requested change doesn't pass the
    ///   business validation rules.
    ///
    /// Fix: Check that your change aligns with the business rules defined by AWS
    /// Partner Central.
    reason: ValidationExceptionReason,

    pub const json_field_names = .{
        .error_list = "ErrorList",
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
