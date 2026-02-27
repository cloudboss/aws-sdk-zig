const ResourceKey = @import("resource_key.zig").ResourceKey;
const RemediationExecutionState = @import("remediation_execution_state.zig").RemediationExecutionState;
const RemediationExecutionStep = @import("remediation_execution_step.zig").RemediationExecutionStep;

/// Provides details of the current status of the invoked remediation action for
/// that resource.
pub const RemediationExecutionStatus = struct {
    /// Start time when the remediation was executed.
    invocation_time: ?i64,

    /// The time when the remediation execution was last updated.
    last_updated_time: ?i64,

    resource_key: ?ResourceKey,

    /// ENUM of the values.
    state: ?RemediationExecutionState,

    /// Details of every step.
    step_details: ?[]const RemediationExecutionStep,

    pub const json_field_names = .{
        .invocation_time = "InvocationTime",
        .last_updated_time = "LastUpdatedTime",
        .resource_key = "ResourceKey",
        .state = "State",
        .step_details = "StepDetails",
    };
};
