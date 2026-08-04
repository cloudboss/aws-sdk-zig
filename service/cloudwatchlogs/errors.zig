const std = @import("std");

const QueryCompileError = @import("query_compile_error.zig").QueryCompileError;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        data_already_accepted_exception: DataAlreadyAcceptedException,
        internal_server_exception: InternalServerException,
        invalid_operation_exception: InvalidOperationException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_sequence_token_exception: InvalidSequenceTokenException,
        limit_exceeded_exception: LimitExceededException,
        malformed_query_exception: MalformedQueryException,
        operation_aborted_exception: OperationAbortedException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        service_unavailable_exception: ServiceUnavailableException,
        throttling_exception: ThrottlingException,
        too_many_tags_exception: TooManyTagsException,
        unrecognized_client_exception: UnrecognizedClientException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .data_already_accepted_exception => "DataAlreadyAcceptedException",
                .internal_server_exception => "InternalServerException",
                .invalid_operation_exception => "InvalidOperationException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_sequence_token_exception => "InvalidSequenceTokenException",
                .limit_exceeded_exception => "LimitExceededException",
                .malformed_query_exception => "MalformedQueryException",
                .operation_aborted_exception => "OperationAbortedException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .throttling_exception => "ThrottlingException",
                .too_many_tags_exception => "TooManyTagsException",
                .unrecognized_client_exception => "UnrecognizedClientException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .data_already_accepted_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_operation_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_sequence_token_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .malformed_query_exception => |e| e.message,
                .operation_aborted_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unrecognized_client_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .conflict_exception => 400,
                .data_already_accepted_exception => 400,
                .internal_server_exception => 500,
                .invalid_operation_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_sequence_token_exception => 400,
                .limit_exceeded_exception => 400,
                .malformed_query_exception => 400,
                .operation_aborted_exception => 400,
                .resource_already_exists_exception => 400,
                .resource_not_found_exception => 400,
                .service_quota_exceeded_exception => 400,
                .service_unavailable_exception => 500,
                .throttling_exception => 400,
                .too_many_tags_exception => 400,
                .unrecognized_client_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .data_already_accepted_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_operation_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_sequence_token_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .malformed_query_exception => |e| e.request_id,
                .operation_aborted_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unrecognized_client_exception => |e| e.request_id,
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

/// You don't have sufficient permissions to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This operation attempted to create a resource that already exists.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The event was already logged.
///
/// `PutLogEvents` actions are now always accepted and never return
/// `DataAlreadyAcceptedException` regardless of whether a given batch of log
/// events has already been accepted.
pub const DataAlreadyAcceptedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    expected_sequence_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .expected_sequence_token = "expectedSequenceToken",
        .message = "message",
    };
};

/// An internal server error occurred while processing the request. This
/// exception is returned
/// when the service encounters an unexpected condition that prevents it from
/// fulfilling the
/// request.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation is not valid on the specified resource.
pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A parameter is specified incorrectly.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The sequence token is not valid. You can get the correct sequence token in
/// the
/// `expectedSequenceToken` field in the `InvalidSequenceTokenException`
/// message.
///
/// `PutLogEvents` actions are now always accepted and never return
/// `InvalidSequenceTokenException` regardless of receiving an invalid sequence
/// token.
pub const InvalidSequenceTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    expected_sequence_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .expected_sequence_token = "expectedSequenceToken",
        .message = "message",
    };
};

/// You have reached the maximum number of resources that can be created.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The query string is not valid. Details about this error are displayed in a
/// `QueryCompileError` object. For more information, see
/// [QueryCompileError](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_QueryCompileError.html).
///
/// For more information about valid query syntax, see [CloudWatch Logs Insights
/// Query
/// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html).
pub const MalformedQueryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    query_compile_error: ?QueryCompileError = null,

    pub const json_field_names = .{
        .message = "message",
        .query_compile_error = "queryCompileError",
    };
};

/// Multiple concurrent requests to update the same resource were in conflict.
pub const OperationAbortedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified resource already exists.
pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified resource does not exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This request exceeds a service quota.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The service cannot complete the request.
pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was throttled because of quota limits.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A resource can have no more than 50 tags.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The name of the resource.
    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_name = "resourceName",
    };
};

/// The most likely cause is an Amazon Web Services access key ID or secret key
/// that's not
/// valid.
pub const UnrecognizedClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One of the parameters for the request is not valid.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
