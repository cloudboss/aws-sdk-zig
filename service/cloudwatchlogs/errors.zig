const std = @import("std");

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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DataAlreadyAcceptedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSequenceTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedQueryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationAbortedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnrecognizedClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
