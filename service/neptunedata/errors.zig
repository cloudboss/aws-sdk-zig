const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        bad_request_exception: BadRequestException,
        bulk_load_id_not_found_exception: BulkLoadIdNotFoundException,
        cancelled_by_user_exception: CancelledByUserException,
        client_timeout_exception: ClientTimeoutException,
        concurrent_modification_exception: ConcurrentModificationException,
        constraint_violation_exception: ConstraintViolationException,
        expired_stream_exception: ExpiredStreamException,
        failure_by_query_exception: FailureByQueryException,
        illegal_argument_exception: IllegalArgumentException,
        internal_failure_exception: InternalFailureException,
        invalid_argument_exception: InvalidArgumentException,
        invalid_numeric_data_exception: InvalidNumericDataException,
        invalid_parameter_exception: InvalidParameterException,
        load_url_access_denied_exception: LoadUrlAccessDeniedException,
        malformed_query_exception: MalformedQueryException,
        memory_limit_exceeded_exception: MemoryLimitExceededException,
        method_not_allowed_exception: MethodNotAllowedException,
        missing_parameter_exception: MissingParameterException,
        ml_resource_not_found_exception: MLResourceNotFoundException,
        parsing_exception: ParsingException,
        preconditions_failed_exception: PreconditionsFailedException,
        query_limit_exceeded_exception: QueryLimitExceededException,
        query_limit_exception: QueryLimitException,
        query_too_large_exception: QueryTooLargeException,
        read_only_violation_exception: ReadOnlyViolationException,
        s3_exception: S3Exception,
        server_shutdown_exception: ServerShutdownException,
        statistics_not_available_exception: StatisticsNotAvailableException,
        stream_records_not_found_exception: StreamRecordsNotFoundException,
        throttling_exception: ThrottlingException,
        time_limit_exceeded_exception: TimeLimitExceededException,
        too_many_requests_exception: TooManyRequestsException,
        unsupported_operation_exception: UnsupportedOperationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .bad_request_exception => "BadRequestException",
                .bulk_load_id_not_found_exception => "BulkLoadIdNotFoundException",
                .cancelled_by_user_exception => "CancelledByUserException",
                .client_timeout_exception => "ClientTimeoutException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .constraint_violation_exception => "ConstraintViolationException",
                .expired_stream_exception => "ExpiredStreamException",
                .failure_by_query_exception => "FailureByQueryException",
                .illegal_argument_exception => "IllegalArgumentException",
                .internal_failure_exception => "InternalFailureException",
                .invalid_argument_exception => "InvalidArgumentException",
                .invalid_numeric_data_exception => "InvalidNumericDataException",
                .invalid_parameter_exception => "InvalidParameterException",
                .load_url_access_denied_exception => "LoadUrlAccessDeniedException",
                .malformed_query_exception => "MalformedQueryException",
                .memory_limit_exceeded_exception => "MemoryLimitExceededException",
                .method_not_allowed_exception => "MethodNotAllowedException",
                .missing_parameter_exception => "MissingParameterException",
                .ml_resource_not_found_exception => "MLResourceNotFoundException",
                .parsing_exception => "ParsingException",
                .preconditions_failed_exception => "PreconditionsFailedException",
                .query_limit_exceeded_exception => "QueryLimitExceededException",
                .query_limit_exception => "QueryLimitException",
                .query_too_large_exception => "QueryTooLargeException",
                .read_only_violation_exception => "ReadOnlyViolationException",
                .s3_exception => "S3Exception",
                .server_shutdown_exception => "ServerShutdownException",
                .statistics_not_available_exception => "StatisticsNotAvailableException",
                .stream_records_not_found_exception => "StreamRecordsNotFoundException",
                .throttling_exception => "ThrottlingException",
                .time_limit_exceeded_exception => "TimeLimitExceededException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .bad_request_exception => |e| e.message,
                .bulk_load_id_not_found_exception => |e| e.message,
                .cancelled_by_user_exception => |e| e.message,
                .client_timeout_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .constraint_violation_exception => |e| e.message,
                .expired_stream_exception => |e| e.message,
                .failure_by_query_exception => |e| e.message,
                .illegal_argument_exception => |e| e.message,
                .internal_failure_exception => |e| e.message,
                .invalid_argument_exception => |e| e.message,
                .invalid_numeric_data_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .load_url_access_denied_exception => |e| e.message,
                .malformed_query_exception => |e| e.message,
                .memory_limit_exceeded_exception => |e| e.message,
                .method_not_allowed_exception => |e| e.message,
                .missing_parameter_exception => |e| e.message,
                .ml_resource_not_found_exception => |e| e.message,
                .parsing_exception => |e| e.message,
                .preconditions_failed_exception => |e| e.message,
                .query_limit_exceeded_exception => |e| e.message,
                .query_limit_exception => |e| e.message,
                .query_too_large_exception => |e| e.message,
                .read_only_violation_exception => |e| e.message,
                .s3_exception => |e| e.message,
                .server_shutdown_exception => |e| e.message,
                .statistics_not_available_exception => |e| e.message,
                .stream_records_not_found_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .time_limit_exceeded_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .bad_request_exception => 400,
                .bulk_load_id_not_found_exception => 404,
                .cancelled_by_user_exception => 500,
                .client_timeout_exception => 408,
                .concurrent_modification_exception => 500,
                .constraint_violation_exception => 400,
                .expired_stream_exception => 400,
                .failure_by_query_exception => 500,
                .illegal_argument_exception => 400,
                .internal_failure_exception => 500,
                .invalid_argument_exception => 400,
                .invalid_numeric_data_exception => 400,
                .invalid_parameter_exception => 400,
                .load_url_access_denied_exception => 400,
                .malformed_query_exception => 400,
                .memory_limit_exceeded_exception => 500,
                .method_not_allowed_exception => 405,
                .missing_parameter_exception => 400,
                .ml_resource_not_found_exception => 404,
                .parsing_exception => 400,
                .preconditions_failed_exception => 400,
                .query_limit_exceeded_exception => 500,
                .query_limit_exception => 400,
                .query_too_large_exception => 400,
                .read_only_violation_exception => 400,
                .s3_exception => 400,
                .server_shutdown_exception => 500,
                .statistics_not_available_exception => 400,
                .stream_records_not_found_exception => 404,
                .throttling_exception => 500,
                .time_limit_exceeded_exception => 500,
                .too_many_requests_exception => 429,
                .unsupported_operation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .bad_request_exception => |e| e.request_id,
                .bulk_load_id_not_found_exception => |e| e.request_id,
                .cancelled_by_user_exception => |e| e.request_id,
                .client_timeout_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .constraint_violation_exception => |e| e.request_id,
                .expired_stream_exception => |e| e.request_id,
                .failure_by_query_exception => |e| e.request_id,
                .illegal_argument_exception => |e| e.request_id,
                .internal_failure_exception => |e| e.request_id,
                .invalid_argument_exception => |e| e.request_id,
                .invalid_numeric_data_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .load_url_access_denied_exception => |e| e.request_id,
                .malformed_query_exception => |e| e.request_id,
                .memory_limit_exceeded_exception => |e| e.request_id,
                .method_not_allowed_exception => |e| e.request_id,
                .missing_parameter_exception => |e| e.request_id,
                .ml_resource_not_found_exception => |e| e.request_id,
                .parsing_exception => |e| e.request_id,
                .preconditions_failed_exception => |e| e.request_id,
                .query_limit_exceeded_exception => |e| e.request_id,
                .query_limit_exception => |e| e.request_id,
                .query_too_large_exception => |e| e.request_id,
                .read_only_violation_exception => |e| e.request_id,
                .s3_exception => |e| e.request_id,
                .server_shutdown_exception => |e| e.request_id,
                .statistics_not_available_exception => |e| e.request_id,
                .stream_records_not_found_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .time_limit_exceeded_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BulkLoadIdNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CancelledByUserException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClientTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConstraintViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExpiredStreamException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FailureByQueryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IllegalArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNumericDataException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LoadUrlAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedQueryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MemoryLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MethodNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MLResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParsingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PreconditionsFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const QueryLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const QueryLimitException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const QueryTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReadOnlyViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const S3Exception = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerShutdownException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StatisticsNotAvailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StreamRecordsNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TimeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
