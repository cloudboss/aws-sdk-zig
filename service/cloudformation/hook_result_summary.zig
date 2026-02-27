const HookFailureMode = @import("hook_failure_mode.zig").HookFailureMode;
const HookInvocationPoint = @import("hook_invocation_point.zig").HookInvocationPoint;
const HookStatus = @import("hook_status.zig").HookStatus;
const ListHookResultsTargetType = @import("list_hook_results_target_type.zig").ListHookResultsTargetType;

/// A `ListHookResults` call returns a summary of a Hook invocation.
pub const HookResultSummary = struct {
    /// The failure mode of the invocation.
    failure_mode: ?HookFailureMode,

    /// The Amazon Resource Name (ARN) of the target stack or request token of the
    /// Cloud Control API
    /// operation.
    ///
    /// Only shown in responses when the request does not specify `TargetType` and
    /// `TargetId` filters.
    hook_execution_target: ?[]const u8,

    /// The unique identifier for this Hook invocation result.
    hook_result_id: ?[]const u8,

    /// A description of the Hook results status. For example, if the Hook result is
    /// in a failed
    /// state, this may contain additional information for the failed state.
    hook_status_reason: ?[]const u8,

    /// The specific point in the provisioning process where the Hook is invoked.
    invocation_point: ?HookInvocationPoint,

    /// The timestamp when the Hook was invoked.
    ///
    /// Only shown in responses when the request does not specify `TargetType` and
    /// `TargetId` filters.
    invoked_at: ?i64,

    /// The status of the Hook invocation. The following statuses are possible:
    ///
    /// * `HOOK_IN_PROGRESS`: The Hook is currently running.
    ///
    /// * `HOOK_COMPLETE_SUCCEEDED`: The Hook completed successfully.
    ///
    /// * `HOOK_COMPLETE_FAILED`: The Hook completed but failed validation.
    ///
    /// * `HOOK_FAILED`: The Hook encountered an error during execution.
    status: ?HookStatus,

    /// The unique identifier of the Hook invocation target.
    target_id: ?[]const u8,

    /// The target type that the Hook was invoked against.
    target_type: ?ListHookResultsTargetType,

    /// The ARN of the Hook that was invoked.
    type_arn: ?[]const u8,

    /// The version of the Hook configuration.
    type_configuration_version_id: ?[]const u8,

    /// The name of the Hook that was invoked.
    type_name: ?[]const u8,

    /// The version of the Hook that was invoked.
    type_version_id: ?[]const u8,
};
