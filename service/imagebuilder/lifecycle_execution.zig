const LifecycleExecutionResourcesImpactedSummary = @import("lifecycle_execution_resources_impacted_summary.zig").LifecycleExecutionResourcesImpactedSummary;
const LifecycleExecutionState = @import("lifecycle_execution_state.zig").LifecycleExecutionState;

/// Contains metadata from a runtime instance of a lifecycle policy.
pub const LifecycleExecution = struct {
    /// The timestamp when the lifecycle runtime instance completed.
    end_time: ?i64 = null,

    /// Identifies the lifecycle policy runtime instance.
    lifecycle_execution_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the lifecycle policy that ran.
    lifecycle_policy_arn: ?[]const u8 = null,

    /// A summary flag that indicates whether the lifecycle execution identified any
    /// resources to take lifecycle actions on.
    resources_impacted_summary: ?LifecycleExecutionResourcesImpactedSummary = null,

    /// The timestamp when the lifecycle runtime instance started.
    start_time: ?i64 = null,

    /// Runtime state that reports whether the lifecycle execution is in progress,
    /// succeeded, or failed.
    state: ?LifecycleExecutionState = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .lifecycle_execution_id = "lifecycleExecutionId",
        .lifecycle_policy_arn = "lifecyclePolicyArn",
        .resources_impacted_summary = "resourcesImpactedSummary",
        .start_time = "startTime",
        .state = "state",
    };
};
