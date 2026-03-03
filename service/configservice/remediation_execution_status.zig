const ResourceKey = @import("resource_key.zig").ResourceKey;
const RemediationExecutionState = @import("remediation_execution_state.zig").RemediationExecutionState;
const RemediationExecutionStep = @import("remediation_execution_step.zig").RemediationExecutionStep;

/// Provides details of the current status of the invoked remediation action for
/// that resource.
pub const RemediationExecutionStatus = struct {
    /// Start time when the remediation was executed.
    invocation_time: ?i64 = null,

    /// The time when the remediation execution was last updated.
    last_updated_time: ?i64 = null,

    resource_key: ?ResourceKey = null,

    /// ENUM of the values.
    state: ?RemediationExecutionState = null,

    /// Details of every step.
    step_details: ?[]const RemediationExecutionStep = null,

    pub const json_field_names = .{
        .invocation_time = "InvocationTime",
        .last_updated_time = "LastUpdatedTime",
        .resource_key = "ResourceKey",
        .state = "State",
        .step_details = "StepDetails",
    };
};
