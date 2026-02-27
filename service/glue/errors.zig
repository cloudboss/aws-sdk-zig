const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        already_exists_exception: AlreadyExistsException,
        column_statistics_task_not_running_exception: ColumnStatisticsTaskNotRunningException,
        column_statistics_task_running_exception: ColumnStatisticsTaskRunningException,
        column_statistics_task_stopping_exception: ColumnStatisticsTaskStoppingException,
        concurrent_modification_exception: ConcurrentModificationException,
        concurrent_runs_exceeded_exception: ConcurrentRunsExceededException,
        condition_check_failure_exception: ConditionCheckFailureException,
        conflict_exception: ConflictException,
        crawler_not_running_exception: CrawlerNotRunningException,
        crawler_running_exception: CrawlerRunningException,
        crawler_stopping_exception: CrawlerStoppingException,
        entity_not_found_exception: EntityNotFoundException,
        federated_resource_already_exists_exception: FederatedResourceAlreadyExistsException,
        federation_source_exception: FederationSourceException,
        federation_source_retryable_exception: FederationSourceRetryableException,
        glue_encryption_exception: GlueEncryptionException,
        idempotent_parameter_mismatch_exception: IdempotentParameterMismatchException,
        illegal_blueprint_state_exception: IllegalBlueprintStateException,
        illegal_session_state_exception: IllegalSessionStateException,
        illegal_workflow_state_exception: IllegalWorkflowStateException,
        integration_conflict_operation_fault: IntegrationConflictOperationFault,
        integration_not_found_fault: IntegrationNotFoundFault,
        integration_quota_exceeded_fault: IntegrationQuotaExceededFault,
        internal_server_exception: InternalServerException,
        internal_service_exception: InternalServiceException,
        invalid_input_exception: InvalidInputException,
        invalid_integration_state_fault: InvalidIntegrationStateFault,
        invalid_state_exception: InvalidStateException,
        kms_key_not_accessible_fault: KMSKeyNotAccessibleFault,
        materialized_view_refresh_task_not_running_exception: MaterializedViewRefreshTaskNotRunningException,
        materialized_view_refresh_task_running_exception: MaterializedViewRefreshTaskRunningException,
        materialized_view_refresh_task_stopping_exception: MaterializedViewRefreshTaskStoppingException,
        ml_transform_not_ready_exception: MLTransformNotReadyException,
        no_schedule_exception: NoScheduleException,
        operation_not_supported_exception: OperationNotSupportedException,
        operation_timeout_exception: OperationTimeoutException,
        permission_type_mismatch_exception: PermissionTypeMismatchException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_not_ready_exception: ResourceNotReadyException,
        resource_number_limit_exceeded_exception: ResourceNumberLimitExceededException,
        scheduler_not_running_exception: SchedulerNotRunningException,
        scheduler_running_exception: SchedulerRunningException,
        scheduler_transitioning_exception: SchedulerTransitioningException,
        target_resource_not_found: TargetResourceNotFound,
        throttling_exception: ThrottlingException,
        validation_exception: ValidationException,
        version_mismatch_exception: VersionMismatchException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .already_exists_exception => "AlreadyExistsException",
                .column_statistics_task_not_running_exception => "ColumnStatisticsTaskNotRunningException",
                .column_statistics_task_running_exception => "ColumnStatisticsTaskRunningException",
                .column_statistics_task_stopping_exception => "ColumnStatisticsTaskStoppingException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .concurrent_runs_exceeded_exception => "ConcurrentRunsExceededException",
                .condition_check_failure_exception => "ConditionCheckFailureException",
                .conflict_exception => "ConflictException",
                .crawler_not_running_exception => "CrawlerNotRunningException",
                .crawler_running_exception => "CrawlerRunningException",
                .crawler_stopping_exception => "CrawlerStoppingException",
                .entity_not_found_exception => "EntityNotFoundException",
                .federated_resource_already_exists_exception => "FederatedResourceAlreadyExistsException",
                .federation_source_exception => "FederationSourceException",
                .federation_source_retryable_exception => "FederationSourceRetryableException",
                .glue_encryption_exception => "GlueEncryptionException",
                .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
                .illegal_blueprint_state_exception => "IllegalBlueprintStateException",
                .illegal_session_state_exception => "IllegalSessionStateException",
                .illegal_workflow_state_exception => "IllegalWorkflowStateException",
                .integration_conflict_operation_fault => "IntegrationConflictOperationFault",
                .integration_not_found_fault => "IntegrationNotFoundFault",
                .integration_quota_exceeded_fault => "IntegrationQuotaExceededFault",
                .internal_server_exception => "InternalServerException",
                .internal_service_exception => "InternalServiceException",
                .invalid_input_exception => "InvalidInputException",
                .invalid_integration_state_fault => "InvalidIntegrationStateFault",
                .invalid_state_exception => "InvalidStateException",
                .kms_key_not_accessible_fault => "KMSKeyNotAccessibleFault",
                .materialized_view_refresh_task_not_running_exception => "MaterializedViewRefreshTaskNotRunningException",
                .materialized_view_refresh_task_running_exception => "MaterializedViewRefreshTaskRunningException",
                .materialized_view_refresh_task_stopping_exception => "MaterializedViewRefreshTaskStoppingException",
                .ml_transform_not_ready_exception => "MLTransformNotReadyException",
                .no_schedule_exception => "NoScheduleException",
                .operation_not_supported_exception => "OperationNotSupportedException",
                .operation_timeout_exception => "OperationTimeoutException",
                .permission_type_mismatch_exception => "PermissionTypeMismatchException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_not_ready_exception => "ResourceNotReadyException",
                .resource_number_limit_exceeded_exception => "ResourceNumberLimitExceededException",
                .scheduler_not_running_exception => "SchedulerNotRunningException",
                .scheduler_running_exception => "SchedulerRunningException",
                .scheduler_transitioning_exception => "SchedulerTransitioningException",
                .target_resource_not_found => "TargetResourceNotFound",
                .throttling_exception => "ThrottlingException",
                .validation_exception => "ValidationException",
                .version_mismatch_exception => "VersionMismatchException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .already_exists_exception => |e| e.message,
                .column_statistics_task_not_running_exception => |e| e.message,
                .column_statistics_task_running_exception => |e| e.message,
                .column_statistics_task_stopping_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .concurrent_runs_exceeded_exception => |e| e.message,
                .condition_check_failure_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .crawler_not_running_exception => |e| e.message,
                .crawler_running_exception => |e| e.message,
                .crawler_stopping_exception => |e| e.message,
                .entity_not_found_exception => |e| e.message,
                .federated_resource_already_exists_exception => |e| e.message,
                .federation_source_exception => |e| e.message,
                .federation_source_retryable_exception => |e| e.message,
                .glue_encryption_exception => |e| e.message,
                .idempotent_parameter_mismatch_exception => |e| e.message,
                .illegal_blueprint_state_exception => |e| e.message,
                .illegal_session_state_exception => |e| e.message,
                .illegal_workflow_state_exception => |e| e.message,
                .integration_conflict_operation_fault => |e| e.message,
                .integration_not_found_fault => |e| e.message,
                .integration_quota_exceeded_fault => |e| e.message,
                .internal_server_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .invalid_integration_state_fault => |e| e.message,
                .invalid_state_exception => |e| e.message,
                .kms_key_not_accessible_fault => |e| e.message,
                .materialized_view_refresh_task_not_running_exception => |e| e.message,
                .materialized_view_refresh_task_running_exception => |e| e.message,
                .materialized_view_refresh_task_stopping_exception => |e| e.message,
                .ml_transform_not_ready_exception => |e| e.message,
                .no_schedule_exception => |e| e.message,
                .operation_not_supported_exception => |e| e.message,
                .operation_timeout_exception => |e| e.message,
                .permission_type_mismatch_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_not_ready_exception => |e| e.message,
                .resource_number_limit_exceeded_exception => |e| e.message,
                .scheduler_not_running_exception => |e| e.message,
                .scheduler_running_exception => |e| e.message,
                .scheduler_transitioning_exception => |e| e.message,
                .target_resource_not_found => |e| e.message,
                .throttling_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .version_mismatch_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .already_exists_exception => 400,
                .column_statistics_task_not_running_exception => 400,
                .column_statistics_task_running_exception => 400,
                .column_statistics_task_stopping_exception => 400,
                .concurrent_modification_exception => 400,
                .concurrent_runs_exceeded_exception => 400,
                .condition_check_failure_exception => 400,
                .conflict_exception => 400,
                .crawler_not_running_exception => 400,
                .crawler_running_exception => 400,
                .crawler_stopping_exception => 400,
                .entity_not_found_exception => 400,
                .federated_resource_already_exists_exception => 400,
                .federation_source_exception => 400,
                .federation_source_retryable_exception => 400,
                .glue_encryption_exception => 400,
                .idempotent_parameter_mismatch_exception => 400,
                .illegal_blueprint_state_exception => 400,
                .illegal_session_state_exception => 400,
                .illegal_workflow_state_exception => 400,
                .integration_conflict_operation_fault => 409,
                .integration_not_found_fault => 404,
                .integration_quota_exceeded_fault => 402,
                .internal_server_exception => 500,
                .internal_service_exception => 500,
                .invalid_input_exception => 400,
                .invalid_integration_state_fault => 400,
                .invalid_state_exception => 400,
                .kms_key_not_accessible_fault => 400,
                .materialized_view_refresh_task_not_running_exception => 400,
                .materialized_view_refresh_task_running_exception => 400,
                .materialized_view_refresh_task_stopping_exception => 400,
                .ml_transform_not_ready_exception => 400,
                .no_schedule_exception => 400,
                .operation_not_supported_exception => 400,
                .operation_timeout_exception => 400,
                .permission_type_mismatch_exception => 400,
                .resource_not_found_exception => 404,
                .resource_not_ready_exception => 400,
                .resource_number_limit_exceeded_exception => 400,
                .scheduler_not_running_exception => 400,
                .scheduler_running_exception => 400,
                .scheduler_transitioning_exception => 400,
                .target_resource_not_found => 404,
                .throttling_exception => 400,
                .validation_exception => 400,
                .version_mismatch_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .already_exists_exception => |e| e.request_id,
                .column_statistics_task_not_running_exception => |e| e.request_id,
                .column_statistics_task_running_exception => |e| e.request_id,
                .column_statistics_task_stopping_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .concurrent_runs_exceeded_exception => |e| e.request_id,
                .condition_check_failure_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .crawler_not_running_exception => |e| e.request_id,
                .crawler_running_exception => |e| e.request_id,
                .crawler_stopping_exception => |e| e.request_id,
                .entity_not_found_exception => |e| e.request_id,
                .federated_resource_already_exists_exception => |e| e.request_id,
                .federation_source_exception => |e| e.request_id,
                .federation_source_retryable_exception => |e| e.request_id,
                .glue_encryption_exception => |e| e.request_id,
                .idempotent_parameter_mismatch_exception => |e| e.request_id,
                .illegal_blueprint_state_exception => |e| e.request_id,
                .illegal_session_state_exception => |e| e.request_id,
                .illegal_workflow_state_exception => |e| e.request_id,
                .integration_conflict_operation_fault => |e| e.request_id,
                .integration_not_found_fault => |e| e.request_id,
                .integration_quota_exceeded_fault => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .invalid_integration_state_fault => |e| e.request_id,
                .invalid_state_exception => |e| e.request_id,
                .kms_key_not_accessible_fault => |e| e.request_id,
                .materialized_view_refresh_task_not_running_exception => |e| e.request_id,
                .materialized_view_refresh_task_running_exception => |e| e.request_id,
                .materialized_view_refresh_task_stopping_exception => |e| e.request_id,
                .ml_transform_not_ready_exception => |e| e.request_id,
                .no_schedule_exception => |e| e.request_id,
                .operation_not_supported_exception => |e| e.request_id,
                .operation_timeout_exception => |e| e.request_id,
                .permission_type_mismatch_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_not_ready_exception => |e| e.request_id,
                .resource_number_limit_exceeded_exception => |e| e.request_id,
                .scheduler_not_running_exception => |e| e.request_id,
                .scheduler_running_exception => |e| e.request_id,
                .scheduler_transitioning_exception => |e| e.request_id,
                .target_resource_not_found => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
                .version_mismatch_exception => |e| e.request_id,
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

pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ColumnStatisticsTaskNotRunningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ColumnStatisticsTaskRunningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ColumnStatisticsTaskStoppingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentRunsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConditionCheckFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CrawlerNotRunningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CrawlerRunningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CrawlerStoppingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FederatedResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FederationSourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FederationSourceRetryableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlueEncryptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IllegalBlueprintStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IllegalSessionStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IllegalWorkflowStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationConflictOperationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidIntegrationStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSKeyNotAccessibleFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaterializedViewRefreshTaskNotRunningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaterializedViewRefreshTaskRunningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaterializedViewRefreshTaskStoppingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MLTransformNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoScheduleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PermissionTypeMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNumberLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SchedulerNotRunningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SchedulerRunningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SchedulerTransitioningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TargetResourceNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const VersionMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
