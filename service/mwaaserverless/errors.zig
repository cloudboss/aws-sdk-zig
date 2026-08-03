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
        operation_timeout_exception: OperationTimeoutException,
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
                .operation_timeout_exception => "OperationTimeoutException",
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
                .operation_timeout_exception => |e| e.message,
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
                .operation_timeout_exception => 504,
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
                .operation_timeout_exception => |e| e.request_id,
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

/// You do not have sufficient permission to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You cannot create a resource that already exists, or the resource is in a
/// state that prevents the requested operation.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The unique identifier of the resource.
    resource_id: []const u8,

    /// The type of the resource.
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

/// An unexpected server-side error occurred during request processing.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The number of seconds to wait before retrying the operation.
    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "Message",
        .retry_after_seconds = "RetryAfterSeconds",
    };
};

/// The operation timed out.
pub const OperationTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource was not found. You can only access or modify a
/// resource that already exists.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The unique identifier of the resource.
    resource_id: []const u8,

    /// The type of the resource.
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

/// The request exceeds the service quota for Amazon Managed Workflows for
/// Apache Airflow Serverless resources. This can occur when you attempt to
/// create more workflows than allowed, exceed concurrent workflow run limits,
/// or surpass task execution limits. Amazon Managed Workflows for Apache
/// Airflow Serverless implements admission control using DynamoDB-based
/// counters to manage resource utilization across the multi-tenant environment.
/// Contact Amazon Web Services Support to request quota increases if you need
/// higher limits for your use case.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The code of the quota.
    quota_code: []const u8,

    /// The unique identifier of the resource.
    resource_id: []const u8,

    /// The type of resource affected.
    resource_type: []const u8,

    /// The code for the service.
    service_code: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .quota_code = "QuotaCode",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .service_code = "ServiceCode",
    };
};

/// The request was denied because too many requests were made in a short
/// period, exceeding the service rate limits. Amazon Managed Workflows for
/// Apache Airflow Serverless implements throttling controls to ensure fair
/// resource allocation across all customers in the multi-tenant environment.
/// This helps maintain service stability and performance. If you encounter
/// throttling, implement exponential backoff and retry logic in your
/// applications, or consider distributing your API calls over a longer time
/// period.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The code of the quota.
    quota_code: []const u8,

    /// The number of seconds to wait before retrying the operation.
    retry_after_seconds: ?i32 = null,

    /// The code for the service.
    service_code: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .quota_code = "QuotaCode",
        .retry_after_seconds = "RetryAfterSeconds",
        .service_code = "ServiceCode",
    };
};

/// The specified request parameters are invalid, missing, or inconsistent with
/// Amazon Managed Workflows for Apache Airflow Serverless service requirements.
/// This can occur when workflow definitions contain unsupported operators, when
/// required IAM permissions are missing, when S3 locations are inaccessible, or
/// when network configurations are invalid. The service validates workflow
/// definitions, execution roles, and resource configurations to ensure
/// compatibility with the managed Airflow environment and security
/// requirements.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The fields that failed validation.
    field_list: ?[]const ValidationExceptionField = null,

    /// The reason the request failed validation.
    reason: ValidationExceptionReason,

    pub const json_field_names = .{
        .field_list = "FieldList",
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
