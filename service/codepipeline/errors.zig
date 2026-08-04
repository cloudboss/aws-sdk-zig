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

/// The action execution was not found.
pub const ActionExecutionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified action cannot be found.
pub const ActionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified action type cannot be found.
pub const ActionTypeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The approval action has already been approved or rejected.
pub const ApprovalAlreadyCompletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Unable to modify the tag due to a simultaneous update request.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pipeline has reached the limit for concurrent pipeline executions.
pub const ConcurrentPipelineExecutionsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Unable to override because the condition does not allow overrides.
pub const ConditionNotOverridableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Your request cannot be handled because the pipeline is busy handling ongoing
/// activities. Try again later.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pipeline execution is already in a `Stopping` state. If you already
/// chose to stop and wait, you cannot make that request again. You can choose
/// to stop and
/// abandon now, but be aware that this option can lead to failed tasks or out
/// of sequence
/// tasks. If you already chose to stop and abandon, you cannot make that
/// request
/// again.
pub const DuplicatedStopRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The action declaration was specified in an invalid format.
pub const InvalidActionDeclarationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The approval request already received a response or has expired.
pub const InvalidApprovalTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified resource ARN is invalid.
pub const InvalidArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Reserved for future use.
pub const InvalidBlockerDeclarationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The client token was specified in an invalid format
pub const InvalidClientTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The job was specified in an invalid format or cannot be found.
pub const InvalidJobException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The job state was specified in an invalid format.
pub const InvalidJobStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The next token was specified in an invalid format. Make sure that the next
/// token
/// you provide is the token returned by a previous call.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The nonce was specified in an invalid format.
pub const InvalidNonceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The stage declaration was specified in an invalid format.
pub const InvalidStageDeclarationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The structure was specified in an invalid format.
pub const InvalidStructureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified resource tags are invalid.
pub const InvalidTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified authentication type is in an invalid format.
pub const InvalidWebhookAuthenticationParametersException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified event filter rule is in an invalid format.
pub const InvalidWebhookFilterPatternException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The job was specified in an invalid format or cannot be found.
pub const JobNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of pipelines associated with the Amazon Web Services account has
/// exceeded
/// the limit allowed for the account.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The stage has failed in a later run of the pipeline and the
/// `pipelineExecutionId` associated with the request is out of
/// date.
pub const NotLatestPipelineExecutionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exceeded the total size limit for all variables in the pipeline.
pub const OutputVariablesSizeExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pipeline execution was specified in an invalid format or cannot be
/// found, or an
/// execution ID does not belong to the specified pipeline.
pub const PipelineExecutionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Unable to stop the pipeline execution. The execution might already be in a
/// `Stopped` state, or it might no longer be in progress.
pub const PipelineExecutionNotStoppableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified pipeline execution is outdated and cannot be used as a target
/// pipeline
/// execution for rollback.
pub const PipelineExecutionOutdatedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified pipeline name is already in use.
pub const PipelineNameInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pipeline was specified in an invalid format or cannot be found.
pub const PipelineNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pipeline version was specified in an invalid format or cannot be
/// found.
pub const PipelineVersionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request failed because of an unknown error, exception, or failure.
pub const RequestFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The resource was specified in an invalid format.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The stage was specified in an invalid format or cannot be found.
pub const StageNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Unable to retry. The pipeline structure or stage state might have changed
/// while
/// actions awaited retry, or the stage contains no failed
/// actions.
pub const StageNotRetryableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The tags limit for a resource has been exceeded.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Unable to roll back the stage. The cause might be if the pipeline version
/// has changed
/// since the target pipeline execution was deployed, the stage is currently
/// running, or an
/// incorrect target pipeline execution ID was provided.
pub const UnableToRollbackStageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The validation was specified in an invalid format.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified webhook was entered in an invalid format or cannot be
/// found.
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
