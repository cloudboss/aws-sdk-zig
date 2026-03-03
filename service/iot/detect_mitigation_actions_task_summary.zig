const MitigationAction = @import("mitigation_action.zig").MitigationAction;
const DetectMitigationActionsTaskTarget = @import("detect_mitigation_actions_task_target.zig").DetectMitigationActionsTaskTarget;
const DetectMitigationActionsTaskStatistics = @import("detect_mitigation_actions_task_statistics.zig").DetectMitigationActionsTaskStatistics;
const DetectMitigationActionsTaskStatus = @import("detect_mitigation_actions_task_status.zig").DetectMitigationActionsTaskStatus;
const ViolationEventOccurrenceRange = @import("violation_event_occurrence_range.zig").ViolationEventOccurrenceRange;

/// The summary of the mitigation action tasks.
pub const DetectMitigationActionsTaskSummary = struct {
    /// The definition of the actions.
    actions_definition: ?[]const MitigationAction = null,

    /// Includes only active violations.
    only_active_violations_included: bool = false,

    /// Includes suppressed alerts.
    suppressed_alerts_included: bool = false,

    /// Specifies the ML Detect findings to which the mitigation actions are
    /// applied.
    target: ?DetectMitigationActionsTaskTarget = null,

    /// The date the task ended.
    task_end_time: ?i64 = null,

    /// The unique identifier of the task.
    task_id: ?[]const u8 = null,

    /// The date the task started.
    task_start_time: ?i64 = null,

    /// The statistics of a mitigation action task.
    task_statistics: ?DetectMitigationActionsTaskStatistics = null,

    /// The status of the task.
    task_status: ?DetectMitigationActionsTaskStatus = null,

    /// Specifies the time period of which violation events occurred between.
    violation_event_occurrence_range: ?ViolationEventOccurrenceRange = null,

    pub const json_field_names = .{
        .actions_definition = "actionsDefinition",
        .only_active_violations_included = "onlyActiveViolationsIncluded",
        .suppressed_alerts_included = "suppressedAlertsIncluded",
        .target = "target",
        .task_end_time = "taskEndTime",
        .task_id = "taskId",
        .task_start_time = "taskStartTime",
        .task_statistics = "taskStatistics",
        .task_status = "taskStatus",
        .violation_event_occurrence_range = "violationEventOccurrenceRange",
    };
};
