const std = @import("std");

const KmsKeyState = @import("kms_key_state.zig").KmsKeyState;
const ValidationExceptionReason = @import("validation_exception_reason.zig").ValidationExceptionReason;

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

/// Activity already exists. `EncryptionConfiguration` may not be updated.
pub const ActivityAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified activity does not exist.
pub const ActivityDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of activities has been reached. Existing activities must
/// be deleted
/// before a new activity can be created.
pub const ActivityLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of workers concurrently polling for activity tasks has
/// been
/// reached.
pub const ActivityWorkerLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Updating or deleting a resource can cause an inconsistent state. This error
/// occurs when there're concurrent requests for DeleteStateMachineVersion,
/// PublishStateMachineVersion, or UpdateStateMachine with the `publish`
/// parameter set to `true`.
///
/// HTTP Status Code: 409
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The execution has the same `name` as another execution (but a different
/// `input`).
///
/// Executions with the same `name` and `input` are considered
/// idempotent.
pub const ExecutionAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified execution does not exist.
pub const ExecutionDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of running executions has been reached. Running
/// executions must end or
/// be stopped before a new execution can be started.
pub const ExecutionLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The execution Amazon Resource Name (ARN) that you specified for
/// `executionArn` cannot be redriven.
pub const ExecutionNotRedrivable = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The provided Amazon Resource Name (ARN) is not valid.
pub const InvalidArn = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The provided Amazon States Language definition is not valid.
pub const InvalidDefinition = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Received when `encryptionConfiguration` is specified but various conditions
/// exist which make the configuration invalid. For example, if `type` is set to
/// `CUSTOMER_MANAGED_KMS_KEY`, but `kmsKeyId` is null, or
/// `kmsDataKeyReusePeriodSeconds` is not between 60 and 900, or the KMS key is
/// not symmetric or inactive.
pub const InvalidEncryptionConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The provided JSON input data is not valid.
pub const InvalidExecutionInput = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Configuration is not valid.
pub const InvalidLoggingConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The provided name is not valid.
pub const InvalidName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The provided JSON output data is not valid.
pub const InvalidOutput = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The provided token is not valid.
pub const InvalidToken = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Your `tracingConfiguration` key does not match, or `enabled` has not
/// been set to `true` or `false`.
pub const InvalidTracingConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Either your KMS key policy or API caller does not have the required
/// permissions.
pub const KmsAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The KMS key is not in valid state, for example: Disabled or Deleted.
pub const KmsInvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Current status of the KMS; key. For example: `DISABLED`, `PENDING_DELETION`,
    /// `PENDING_IMPORT`, `UNAVAILABLE`, `CREATING`.
    kms_key_state: ?KmsKeyState = null,

    pub const json_field_names = .{
        .kms_key_state = "kmsKeyState",
        .message = "message",
    };
};

/// Received when KMS returns `ThrottlingException` for a KMS call that Step
/// Functions makes on behalf of the caller.
pub const KmsThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Request is missing a required parameter. This error occurs if both
/// `definition`
/// and `roleArn` are not specified.
pub const MissingRequiredParameter = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Could not find the referenced resource.
pub const ResourceNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_name = "resourceName",
    };
};

/// The request would cause a service quota to be exceeded.
///
/// HTTP Status Code: 402
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A state machine with the same name but a different definition or role ARN
/// already
/// exists.
pub const StateMachineAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified state machine is being deleted.
pub const StateMachineDeleting = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified state machine does not exist.
pub const StateMachineDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of state machines has been reached. Existing state
/// machines must be
/// deleted before a new state machine can be created.
pub const StateMachineLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// State machine type is not supported.
pub const StateMachineTypeNotSupported = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The activity does not exist.
pub const TaskDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The task token has either expired or the task associated with the token has
/// already been closed.
pub const TaskTimedOut = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You've exceeded the number of tags allowed for a resource. See the [ Limits
/// Topic](https://docs.aws.amazon.com/step-functions/latest/dg/limits.html) in
/// the
/// Step Functions Developer Guide.
pub const TooManyTags = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_name = "resourceName",
    };
};

/// The input does not satisfy the constraints specified by an Amazon Web
/// Services service.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The input does not satisfy the constraints specified by an Amazon Web
    /// Services service.
    reason: ?ValidationExceptionReason = null,

    pub const json_field_names = .{
        .message = "message",
        .reason = "reason",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
