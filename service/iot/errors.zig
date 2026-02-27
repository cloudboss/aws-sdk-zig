const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        certificate_conflict_exception: CertificateConflictException,
        certificate_state_exception: CertificateStateException,
        certificate_validation_exception: CertificateValidationException,
        conflict_exception: ConflictException,
        conflicting_resource_update_exception: ConflictingResourceUpdateException,
        delete_conflict_exception: DeleteConflictException,
        index_not_ready_exception: IndexNotReadyException,
        internal_exception: InternalException,
        internal_failure_exception: InternalFailureException,
        internal_server_exception: InternalServerException,
        invalid_aggregation_exception: InvalidAggregationException,
        invalid_query_exception: InvalidQueryException,
        invalid_request_exception: InvalidRequestException,
        invalid_response_exception: InvalidResponseException,
        invalid_state_transition_exception: InvalidStateTransitionException,
        limit_exceeded_exception: LimitExceededException,
        malformed_policy_exception: MalformedPolicyException,
        not_configured_exception: NotConfiguredException,
        registration_code_validation_exception: RegistrationCodeValidationException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_registration_failure_exception: ResourceRegistrationFailureException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        service_unavailable_exception: ServiceUnavailableException,
        sql_parse_exception: SqlParseException,
        task_already_exists_exception: TaskAlreadyExistsException,
        throttling_exception: ThrottlingException,
        transfer_already_completed_exception: TransferAlreadyCompletedException,
        transfer_conflict_exception: TransferConflictException,
        unauthorized_exception: UnauthorizedException,
        validation_exception: ValidationException,
        version_conflict_exception: VersionConflictException,
        versions_limit_exceeded_exception: VersionsLimitExceededException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .certificate_conflict_exception => "CertificateConflictException",
                .certificate_state_exception => "CertificateStateException",
                .certificate_validation_exception => "CertificateValidationException",
                .conflict_exception => "ConflictException",
                .conflicting_resource_update_exception => "ConflictingResourceUpdateException",
                .delete_conflict_exception => "DeleteConflictException",
                .index_not_ready_exception => "IndexNotReadyException",
                .internal_exception => "InternalException",
                .internal_failure_exception => "InternalFailureException",
                .internal_server_exception => "InternalServerException",
                .invalid_aggregation_exception => "InvalidAggregationException",
                .invalid_query_exception => "InvalidQueryException",
                .invalid_request_exception => "InvalidRequestException",
                .invalid_response_exception => "InvalidResponseException",
                .invalid_state_transition_exception => "InvalidStateTransitionException",
                .limit_exceeded_exception => "LimitExceededException",
                .malformed_policy_exception => "MalformedPolicyException",
                .not_configured_exception => "NotConfiguredException",
                .registration_code_validation_exception => "RegistrationCodeValidationException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_registration_failure_exception => "ResourceRegistrationFailureException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .sql_parse_exception => "SqlParseException",
                .task_already_exists_exception => "TaskAlreadyExistsException",
                .throttling_exception => "ThrottlingException",
                .transfer_already_completed_exception => "TransferAlreadyCompletedException",
                .transfer_conflict_exception => "TransferConflictException",
                .unauthorized_exception => "UnauthorizedException",
                .validation_exception => "ValidationException",
                .version_conflict_exception => "VersionConflictException",
                .versions_limit_exceeded_exception => "VersionsLimitExceededException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .certificate_conflict_exception => |e| e.message,
                .certificate_state_exception => |e| e.message,
                .certificate_validation_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .conflicting_resource_update_exception => |e| e.message,
                .delete_conflict_exception => |e| e.message,
                .index_not_ready_exception => |e| e.message,
                .internal_exception => |e| e.message,
                .internal_failure_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_aggregation_exception => |e| e.message,
                .invalid_query_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .invalid_response_exception => |e| e.message,
                .invalid_state_transition_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .malformed_policy_exception => |e| e.message,
                .not_configured_exception => |e| e.message,
                .registration_code_validation_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_registration_failure_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .sql_parse_exception => |e| e.message,
                .task_already_exists_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .transfer_already_completed_exception => |e| e.message,
                .transfer_conflict_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .version_conflict_exception => |e| e.message,
                .versions_limit_exceeded_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .certificate_conflict_exception => 409,
                .certificate_state_exception => 406,
                .certificate_validation_exception => 400,
                .conflict_exception => 409,
                .conflicting_resource_update_exception => 409,
                .delete_conflict_exception => 409,
                .index_not_ready_exception => 400,
                .internal_exception => 500,
                .internal_failure_exception => 500,
                .internal_server_exception => 500,
                .invalid_aggregation_exception => 400,
                .invalid_query_exception => 400,
                .invalid_request_exception => 400,
                .invalid_response_exception => 400,
                .invalid_state_transition_exception => 409,
                .limit_exceeded_exception => 410,
                .malformed_policy_exception => 400,
                .not_configured_exception => 404,
                .registration_code_validation_exception => 400,
                .resource_already_exists_exception => 409,
                .resource_not_found_exception => 404,
                .resource_registration_failure_exception => 400,
                .service_quota_exceeded_exception => 402,
                .service_unavailable_exception => 503,
                .sql_parse_exception => 400,
                .task_already_exists_exception => 400,
                .throttling_exception => 400,
                .transfer_already_completed_exception => 410,
                .transfer_conflict_exception => 409,
                .unauthorized_exception => 401,
                .validation_exception => 400,
                .version_conflict_exception => 409,
                .versions_limit_exceeded_exception => 409,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .certificate_conflict_exception => |e| e.request_id,
                .certificate_state_exception => |e| e.request_id,
                .certificate_validation_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .conflicting_resource_update_exception => |e| e.request_id,
                .delete_conflict_exception => |e| e.request_id,
                .index_not_ready_exception => |e| e.request_id,
                .internal_exception => |e| e.request_id,
                .internal_failure_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_aggregation_exception => |e| e.request_id,
                .invalid_query_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .invalid_response_exception => |e| e.request_id,
                .invalid_state_transition_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .malformed_policy_exception => |e| e.request_id,
                .not_configured_exception => |e| e.request_id,
                .registration_code_validation_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_registration_failure_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .sql_parse_exception => |e| e.request_id,
                .task_already_exists_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .transfer_already_completed_exception => |e| e.request_id,
                .transfer_conflict_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
                .version_conflict_exception => |e| e.request_id,
                .versions_limit_exceeded_exception => |e| e.request_id,
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

pub const CertificateConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CertificateStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CertificateValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictingResourceUpdateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeleteConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IndexNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAggregationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidQueryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResponseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidStateTransitionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotConfiguredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RegistrationCodeValidationException = struct {
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

pub const ResourceRegistrationFailureException = struct {
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

pub const SqlParseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TaskAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TransferAlreadyCompletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TransferConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const VersionConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const VersionsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
