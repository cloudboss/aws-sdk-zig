const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        activity_already_exists: ActivityAlreadyExists,
        activity_does_not_exist: ActivityDoesNotExist,
        activity_limit_exceeded: ActivityLimitExceeded,
        activity_worker_limit_exceeded: ActivityWorkerLimitExceeded,
        conflict_exception: ConflictException,
        execution_already_exists: ExecutionAlreadyExists,
        execution_does_not_exist: ExecutionDoesNotExist,
        execution_limit_exceeded: ExecutionLimitExceeded,
        execution_not_redrivable: ExecutionNotRedrivable,
        invalid_arn: InvalidArn,
        invalid_definition: InvalidDefinition,
        invalid_encryption_configuration: InvalidEncryptionConfiguration,
        invalid_execution_input: InvalidExecutionInput,
        invalid_logging_configuration: InvalidLoggingConfiguration,
        invalid_name: InvalidName,
        invalid_output: InvalidOutput,
        invalid_token: InvalidToken,
        invalid_tracing_configuration: InvalidTracingConfiguration,
        kms_access_denied_exception: KmsAccessDeniedException,
        kms_invalid_state_exception: KmsInvalidStateException,
        kms_throttling_exception: KmsThrottlingException,
        missing_required_parameter: MissingRequiredParameter,
        resource_not_found: ResourceNotFound,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        state_machine_already_exists: StateMachineAlreadyExists,
        state_machine_deleting: StateMachineDeleting,
        state_machine_does_not_exist: StateMachineDoesNotExist,
        state_machine_limit_exceeded: StateMachineLimitExceeded,
        state_machine_type_not_supported: StateMachineTypeNotSupported,
        task_does_not_exist: TaskDoesNotExist,
        task_timed_out: TaskTimedOut,
        too_many_tags: TooManyTags,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .activity_already_exists => "ActivityAlreadyExists",
                .activity_does_not_exist => "ActivityDoesNotExist",
                .activity_limit_exceeded => "ActivityLimitExceeded",
                .activity_worker_limit_exceeded => "ActivityWorkerLimitExceeded",
                .conflict_exception => "ConflictException",
                .execution_already_exists => "ExecutionAlreadyExists",
                .execution_does_not_exist => "ExecutionDoesNotExist",
                .execution_limit_exceeded => "ExecutionLimitExceeded",
                .execution_not_redrivable => "ExecutionNotRedrivable",
                .invalid_arn => "InvalidArn",
                .invalid_definition => "InvalidDefinition",
                .invalid_encryption_configuration => "InvalidEncryptionConfiguration",
                .invalid_execution_input => "InvalidExecutionInput",
                .invalid_logging_configuration => "InvalidLoggingConfiguration",
                .invalid_name => "InvalidName",
                .invalid_output => "InvalidOutput",
                .invalid_token => "InvalidToken",
                .invalid_tracing_configuration => "InvalidTracingConfiguration",
                .kms_access_denied_exception => "KmsAccessDeniedException",
                .kms_invalid_state_exception => "KmsInvalidStateException",
                .kms_throttling_exception => "KmsThrottlingException",
                .missing_required_parameter => "MissingRequiredParameter",
                .resource_not_found => "ResourceNotFound",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .state_machine_already_exists => "StateMachineAlreadyExists",
                .state_machine_deleting => "StateMachineDeleting",
                .state_machine_does_not_exist => "StateMachineDoesNotExist",
                .state_machine_limit_exceeded => "StateMachineLimitExceeded",
                .state_machine_type_not_supported => "StateMachineTypeNotSupported",
                .task_does_not_exist => "TaskDoesNotExist",
                .task_timed_out => "TaskTimedOut",
                .too_many_tags => "TooManyTags",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .activity_already_exists => |e| e.message,
                .activity_does_not_exist => |e| e.message,
                .activity_limit_exceeded => |e| e.message,
                .activity_worker_limit_exceeded => |e| e.message,
                .conflict_exception => |e| e.message,
                .execution_already_exists => |e| e.message,
                .execution_does_not_exist => |e| e.message,
                .execution_limit_exceeded => |e| e.message,
                .execution_not_redrivable => |e| e.message,
                .invalid_arn => |e| e.message,
                .invalid_definition => |e| e.message,
                .invalid_encryption_configuration => |e| e.message,
                .invalid_execution_input => |e| e.message,
                .invalid_logging_configuration => |e| e.message,
                .invalid_name => |e| e.message,
                .invalid_output => |e| e.message,
                .invalid_token => |e| e.message,
                .invalid_tracing_configuration => |e| e.message,
                .kms_access_denied_exception => |e| e.message,
                .kms_invalid_state_exception => |e| e.message,
                .kms_throttling_exception => |e| e.message,
                .missing_required_parameter => |e| e.message,
                .resource_not_found => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .state_machine_already_exists => |e| e.message,
                .state_machine_deleting => |e| e.message,
                .state_machine_does_not_exist => |e| e.message,
                .state_machine_limit_exceeded => |e| e.message,
                .state_machine_type_not_supported => |e| e.message,
                .task_does_not_exist => |e| e.message,
                .task_timed_out => |e| e.message,
                .too_many_tags => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .activity_already_exists => 400,
                .activity_does_not_exist => 400,
                .activity_limit_exceeded => 400,
                .activity_worker_limit_exceeded => 400,
                .conflict_exception => 409,
                .execution_already_exists => 400,
                .execution_does_not_exist => 400,
                .execution_limit_exceeded => 400,
                .execution_not_redrivable => 400,
                .invalid_arn => 400,
                .invalid_definition => 400,
                .invalid_encryption_configuration => 400,
                .invalid_execution_input => 400,
                .invalid_logging_configuration => 400,
                .invalid_name => 400,
                .invalid_output => 400,
                .invalid_token => 400,
                .invalid_tracing_configuration => 400,
                .kms_access_denied_exception => 400,
                .kms_invalid_state_exception => 400,
                .kms_throttling_exception => 400,
                .missing_required_parameter => 400,
                .resource_not_found => 404,
                .service_quota_exceeded_exception => 402,
                .state_machine_already_exists => 400,
                .state_machine_deleting => 400,
                .state_machine_does_not_exist => 400,
                .state_machine_limit_exceeded => 400,
                .state_machine_type_not_supported => 400,
                .task_does_not_exist => 400,
                .task_timed_out => 400,
                .too_many_tags => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .activity_already_exists => |e| e.request_id,
                .activity_does_not_exist => |e| e.request_id,
                .activity_limit_exceeded => |e| e.request_id,
                .activity_worker_limit_exceeded => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .execution_already_exists => |e| e.request_id,
                .execution_does_not_exist => |e| e.request_id,
                .execution_limit_exceeded => |e| e.request_id,
                .execution_not_redrivable => |e| e.request_id,
                .invalid_arn => |e| e.request_id,
                .invalid_definition => |e| e.request_id,
                .invalid_encryption_configuration => |e| e.request_id,
                .invalid_execution_input => |e| e.request_id,
                .invalid_logging_configuration => |e| e.request_id,
                .invalid_name => |e| e.request_id,
                .invalid_output => |e| e.request_id,
                .invalid_token => |e| e.request_id,
                .invalid_tracing_configuration => |e| e.request_id,
                .kms_access_denied_exception => |e| e.request_id,
                .kms_invalid_state_exception => |e| e.request_id,
                .kms_throttling_exception => |e| e.request_id,
                .missing_required_parameter => |e| e.request_id,
                .resource_not_found => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .state_machine_already_exists => |e| e.request_id,
                .state_machine_deleting => |e| e.request_id,
                .state_machine_does_not_exist => |e| e.request_id,
                .state_machine_limit_exceeded => |e| e.request_id,
                .state_machine_type_not_supported => |e| e.request_id,
                .task_does_not_exist => |e| e.request_id,
                .task_timed_out => |e| e.request_id,
                .too_many_tags => |e| e.request_id,
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

pub const ActivityAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ActivityDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ActivityLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ActivityWorkerLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExecutionAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExecutionDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExecutionLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExecutionNotRedrivable = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArn = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDefinition = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEncryptionConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidExecutionInput = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLoggingConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOutput = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidToken = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTracingConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KmsAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KmsInvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KmsThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingRequiredParameter = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StateMachineAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StateMachineDeleting = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StateMachineDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StateMachineLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StateMachineTypeNotSupported = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TaskDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TaskTimedOut = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTags = struct {
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
