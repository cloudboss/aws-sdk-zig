const JobStateTimeLimitActionsAction = @import("job_state_time_limit_actions_action.zig").JobStateTimeLimitActionsAction;
const JobStateTimeLimitActionsState = @import("job_state_time_limit_actions_state.zig").JobStateTimeLimitActionsState;

/// Specifies an action that Batch will take after the job has remained at the
/// head of the queue in the specified state for longer than the specified time.
pub const JobStateTimeLimitAction = struct {
    /// The action to take when a job is at the head of the job queue in the
    /// specified state for the specified period of
    /// time. For job queues connected to a `ECS`, `FARGATE` or `EKS` compute
    /// environment, the only supported value is `CANCEL`, which will cancel the
    /// job.
    /// For job queues connected to a `SAGEMAKER_TRAINING` service environment, the
    /// only supported value is `TERMINATE`, which will terminate the job.
    action: JobStateTimeLimitActionsAction,

    /// The approximate amount of time, in seconds, that must pass with the job in
    /// the specified state before the action
    /// is taken. The minimum value is 600 (10 minutes) and the maximum value is
    /// 86,400 (24 hours).
    max_time_seconds: i32,

    /// The reason to log for the action being taken.
    reason: []const u8,

    /// The state of the job needed to trigger the action. The only supported value
    /// is `RUNNABLE`.
    state: JobStateTimeLimitActionsState,

    pub const json_field_names = .{
        .action = "action",
        .max_time_seconds = "maxTimeSeconds",
        .reason = "reason",
        .state = "state",
    };
};
