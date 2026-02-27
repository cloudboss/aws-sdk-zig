const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        action_execution_not_found_exception: ActionExecutionNotFoundException,
        action_not_found_exception: ActionNotFoundException,
        action_type_not_found_exception: ActionTypeNotFoundException,
        approval_already_completed_exception: ApprovalAlreadyCompletedException,
        concurrent_modification_exception: ConcurrentModificationException,
        concurrent_pipeline_executions_limit_exceeded_exception: ConcurrentPipelineExecutionsLimitExceededException,
        condition_not_overridable_exception: ConditionNotOverridableException,
        conflict_exception: ConflictException,
        duplicated_stop_request_exception: DuplicatedStopRequestException,
        invalid_action_declaration_exception: InvalidActionDeclarationException,
        invalid_approval_token_exception: InvalidApprovalTokenException,
        invalid_arn_exception: InvalidArnException,
        invalid_blocker_declaration_exception: InvalidBlockerDeclarationException,
        invalid_client_token_exception: InvalidClientTokenException,
        invalid_job_exception: InvalidJobException,
        invalid_job_state_exception: InvalidJobStateException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_nonce_exception: InvalidNonceException,
        invalid_stage_declaration_exception: InvalidStageDeclarationException,
        invalid_structure_exception: InvalidStructureException,
        invalid_tags_exception: InvalidTagsException,
        invalid_webhook_authentication_parameters_exception: InvalidWebhookAuthenticationParametersException,
        invalid_webhook_filter_pattern_exception: InvalidWebhookFilterPatternException,
        job_not_found_exception: JobNotFoundException,
        limit_exceeded_exception: LimitExceededException,
        not_latest_pipeline_execution_exception: NotLatestPipelineExecutionException,
        output_variables_size_exceeded_exception: OutputVariablesSizeExceededException,
        pipeline_execution_not_found_exception: PipelineExecutionNotFoundException,
        pipeline_execution_not_stoppable_exception: PipelineExecutionNotStoppableException,
        pipeline_execution_outdated_exception: PipelineExecutionOutdatedException,
        pipeline_name_in_use_exception: PipelineNameInUseException,
        pipeline_not_found_exception: PipelineNotFoundException,
        pipeline_version_not_found_exception: PipelineVersionNotFoundException,
        request_failed_exception: RequestFailedException,
        resource_not_found_exception: ResourceNotFoundException,
        stage_not_found_exception: StageNotFoundException,
        stage_not_retryable_exception: StageNotRetryableException,
        too_many_tags_exception: TooManyTagsException,
        unable_to_rollback_stage_exception: UnableToRollbackStageException,
        validation_exception: ValidationException,
        webhook_not_found_exception: WebhookNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .action_execution_not_found_exception => "ActionExecutionNotFoundException",
                .action_not_found_exception => "ActionNotFoundException",
                .action_type_not_found_exception => "ActionTypeNotFoundException",
                .approval_already_completed_exception => "ApprovalAlreadyCompletedException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .concurrent_pipeline_executions_limit_exceeded_exception => "ConcurrentPipelineExecutionsLimitExceededException",
                .condition_not_overridable_exception => "ConditionNotOverridableException",
                .conflict_exception => "ConflictException",
                .duplicated_stop_request_exception => "DuplicatedStopRequestException",
                .invalid_action_declaration_exception => "InvalidActionDeclarationException",
                .invalid_approval_token_exception => "InvalidApprovalTokenException",
                .invalid_arn_exception => "InvalidArnException",
                .invalid_blocker_declaration_exception => "InvalidBlockerDeclarationException",
                .invalid_client_token_exception => "InvalidClientTokenException",
                .invalid_job_exception => "InvalidJobException",
                .invalid_job_state_exception => "InvalidJobStateException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_nonce_exception => "InvalidNonceException",
                .invalid_stage_declaration_exception => "InvalidStageDeclarationException",
                .invalid_structure_exception => "InvalidStructureException",
                .invalid_tags_exception => "InvalidTagsException",
                .invalid_webhook_authentication_parameters_exception => "InvalidWebhookAuthenticationParametersException",
                .invalid_webhook_filter_pattern_exception => "InvalidWebhookFilterPatternException",
                .job_not_found_exception => "JobNotFoundException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_latest_pipeline_execution_exception => "NotLatestPipelineExecutionException",
                .output_variables_size_exceeded_exception => "OutputVariablesSizeExceededException",
                .pipeline_execution_not_found_exception => "PipelineExecutionNotFoundException",
                .pipeline_execution_not_stoppable_exception => "PipelineExecutionNotStoppableException",
                .pipeline_execution_outdated_exception => "PipelineExecutionOutdatedException",
                .pipeline_name_in_use_exception => "PipelineNameInUseException",
                .pipeline_not_found_exception => "PipelineNotFoundException",
                .pipeline_version_not_found_exception => "PipelineVersionNotFoundException",
                .request_failed_exception => "RequestFailedException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .stage_not_found_exception => "StageNotFoundException",
                .stage_not_retryable_exception => "StageNotRetryableException",
                .too_many_tags_exception => "TooManyTagsException",
                .unable_to_rollback_stage_exception => "UnableToRollbackStageException",
                .validation_exception => "ValidationException",
                .webhook_not_found_exception => "WebhookNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .action_execution_not_found_exception => |e| e.message,
                .action_not_found_exception => |e| e.message,
                .action_type_not_found_exception => |e| e.message,
                .approval_already_completed_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .concurrent_pipeline_executions_limit_exceeded_exception => |e| e.message,
                .condition_not_overridable_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .duplicated_stop_request_exception => |e| e.message,
                .invalid_action_declaration_exception => |e| e.message,
                .invalid_approval_token_exception => |e| e.message,
                .invalid_arn_exception => |e| e.message,
                .invalid_blocker_declaration_exception => |e| e.message,
                .invalid_client_token_exception => |e| e.message,
                .invalid_job_exception => |e| e.message,
                .invalid_job_state_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_nonce_exception => |e| e.message,
                .invalid_stage_declaration_exception => |e| e.message,
                .invalid_structure_exception => |e| e.message,
                .invalid_tags_exception => |e| e.message,
                .invalid_webhook_authentication_parameters_exception => |e| e.message,
                .invalid_webhook_filter_pattern_exception => |e| e.message,
                .job_not_found_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_latest_pipeline_execution_exception => |e| e.message,
                .output_variables_size_exceeded_exception => |e| e.message,
                .pipeline_execution_not_found_exception => |e| e.message,
                .pipeline_execution_not_stoppable_exception => |e| e.message,
                .pipeline_execution_outdated_exception => |e| e.message,
                .pipeline_name_in_use_exception => |e| e.message,
                .pipeline_not_found_exception => |e| e.message,
                .pipeline_version_not_found_exception => |e| e.message,
                .request_failed_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .stage_not_found_exception => |e| e.message,
                .stage_not_retryable_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unable_to_rollback_stage_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .webhook_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .action_execution_not_found_exception => 400,
                .action_not_found_exception => 400,
                .action_type_not_found_exception => 400,
                .approval_already_completed_exception => 400,
                .concurrent_modification_exception => 400,
                .concurrent_pipeline_executions_limit_exceeded_exception => 400,
                .condition_not_overridable_exception => 400,
                .conflict_exception => 409,
                .duplicated_stop_request_exception => 400,
                .invalid_action_declaration_exception => 400,
                .invalid_approval_token_exception => 400,
                .invalid_arn_exception => 400,
                .invalid_blocker_declaration_exception => 400,
                .invalid_client_token_exception => 400,
                .invalid_job_exception => 400,
                .invalid_job_state_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_nonce_exception => 400,
                .invalid_stage_declaration_exception => 400,
                .invalid_structure_exception => 400,
                .invalid_tags_exception => 400,
                .invalid_webhook_authentication_parameters_exception => 400,
                .invalid_webhook_filter_pattern_exception => 400,
                .job_not_found_exception => 400,
                .limit_exceeded_exception => 400,
                .not_latest_pipeline_execution_exception => 400,
                .output_variables_size_exceeded_exception => 400,
                .pipeline_execution_not_found_exception => 400,
                .pipeline_execution_not_stoppable_exception => 400,
                .pipeline_execution_outdated_exception => 400,
                .pipeline_name_in_use_exception => 400,
                .pipeline_not_found_exception => 400,
                .pipeline_version_not_found_exception => 400,
                .request_failed_exception => 400,
                .resource_not_found_exception => 400,
                .stage_not_found_exception => 400,
                .stage_not_retryable_exception => 400,
                .too_many_tags_exception => 400,
                .unable_to_rollback_stage_exception => 400,
                .validation_exception => 400,
                .webhook_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .action_execution_not_found_exception => |e| e.request_id,
                .action_not_found_exception => |e| e.request_id,
                .action_type_not_found_exception => |e| e.request_id,
                .approval_already_completed_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .concurrent_pipeline_executions_limit_exceeded_exception => |e| e.request_id,
                .condition_not_overridable_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .duplicated_stop_request_exception => |e| e.request_id,
                .invalid_action_declaration_exception => |e| e.request_id,
                .invalid_approval_token_exception => |e| e.request_id,
                .invalid_arn_exception => |e| e.request_id,
                .invalid_blocker_declaration_exception => |e| e.request_id,
                .invalid_client_token_exception => |e| e.request_id,
                .invalid_job_exception => |e| e.request_id,
                .invalid_job_state_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_nonce_exception => |e| e.request_id,
                .invalid_stage_declaration_exception => |e| e.request_id,
                .invalid_structure_exception => |e| e.request_id,
                .invalid_tags_exception => |e| e.request_id,
                .invalid_webhook_authentication_parameters_exception => |e| e.request_id,
                .invalid_webhook_filter_pattern_exception => |e| e.request_id,
                .job_not_found_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_latest_pipeline_execution_exception => |e| e.request_id,
                .output_variables_size_exceeded_exception => |e| e.request_id,
                .pipeline_execution_not_found_exception => |e| e.request_id,
                .pipeline_execution_not_stoppable_exception => |e| e.request_id,
                .pipeline_execution_outdated_exception => |e| e.request_id,
                .pipeline_name_in_use_exception => |e| e.request_id,
                .pipeline_not_found_exception => |e| e.request_id,
                .pipeline_version_not_found_exception => |e| e.request_id,
                .request_failed_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .stage_not_found_exception => |e| e.request_id,
                .stage_not_retryable_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unable_to_rollback_stage_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
                .webhook_not_found_exception => |e| e.request_id,
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

pub const ActionExecutionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ActionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ActionTypeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalAlreadyCompletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentPipelineExecutionsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConditionNotOverridableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicatedStopRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidActionDeclarationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidApprovalTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidBlockerDeclarationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClientTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidJobException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidJobStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNonceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidStageDeclarationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidStructureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidWebhookAuthenticationParametersException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidWebhookFilterPatternException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const JobNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotLatestPipelineExecutionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OutputVariablesSizeExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PipelineExecutionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PipelineExecutionNotStoppableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PipelineExecutionOutdatedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PipelineNameInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PipelineNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PipelineVersionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StageNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StageNotRetryableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnableToRollbackStageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WebhookNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
