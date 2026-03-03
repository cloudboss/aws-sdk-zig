const std = @import("std");

pub const ExecutionEventType = enum {
    unknown,
    execution_pending,
    execution_started,
    execution_succeeded,
    execution_failed,
    execution_pausing,
    execution_paused,
    execution_canceling,
    execution_canceled,
    execution_pending_approval,
    execution_behavior_changed_to_ungraceful,
    execution_behavior_changed_to_graceful,
    execution_pending_child_plan_manual_approval,
    execution_success_monitoring_application_health,
    step_started,
    step_update,
    step_succeeded,
    step_failed,
    step_skipped,
    step_paused_by_error,
    step_paused_by_operator,
    step_canceled,
    step_pending_approval,
    step_execution_behavior_changed_to_ungraceful,
    step_pending_application_health_monitor,
    plan_evaluation_warning,

    pub const json_field_names = .{
        .unknown = "unknown",
        .execution_pending = "executionPending",
        .execution_started = "executionStarted",
        .execution_succeeded = "executionSucceeded",
        .execution_failed = "executionFailed",
        .execution_pausing = "executionPausing",
        .execution_paused = "executionPaused",
        .execution_canceling = "executionCanceling",
        .execution_canceled = "executionCanceled",
        .execution_pending_approval = "executionPendingApproval",
        .execution_behavior_changed_to_ungraceful = "executionBehaviorChangedToUngraceful",
        .execution_behavior_changed_to_graceful = "executionBehaviorChangedToGraceful",
        .execution_pending_child_plan_manual_approval = "executionPendingChildPlanManualApproval",
        .execution_success_monitoring_application_health = "executionSuccessMonitoringApplicationHealth",
        .step_started = "stepStarted",
        .step_update = "stepUpdate",
        .step_succeeded = "stepSucceeded",
        .step_failed = "stepFailed",
        .step_skipped = "stepSkipped",
        .step_paused_by_error = "stepPausedByError",
        .step_paused_by_operator = "stepPausedByOperator",
        .step_canceled = "stepCanceled",
        .step_pending_approval = "stepPendingApproval",
        .step_execution_behavior_changed_to_ungraceful = "stepExecutionBehaviorChangedToUngraceful",
        .step_pending_application_health_monitor = "stepPendingApplicationHealthMonitor",
        .plan_evaluation_warning = "planEvaluationWarning",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown => "unknown",
            .execution_pending => "executionPending",
            .execution_started => "executionStarted",
            .execution_succeeded => "executionSucceeded",
            .execution_failed => "executionFailed",
            .execution_pausing => "executionPausing",
            .execution_paused => "executionPaused",
            .execution_canceling => "executionCanceling",
            .execution_canceled => "executionCanceled",
            .execution_pending_approval => "executionPendingApproval",
            .execution_behavior_changed_to_ungraceful => "executionBehaviorChangedToUngraceful",
            .execution_behavior_changed_to_graceful => "executionBehaviorChangedToGraceful",
            .execution_pending_child_plan_manual_approval => "executionPendingChildPlanManualApproval",
            .execution_success_monitoring_application_health => "executionSuccessMonitoringApplicationHealth",
            .step_started => "stepStarted",
            .step_update => "stepUpdate",
            .step_succeeded => "stepSucceeded",
            .step_failed => "stepFailed",
            .step_skipped => "stepSkipped",
            .step_paused_by_error => "stepPausedByError",
            .step_paused_by_operator => "stepPausedByOperator",
            .step_canceled => "stepCanceled",
            .step_pending_approval => "stepPendingApproval",
            .step_execution_behavior_changed_to_ungraceful => "stepExecutionBehaviorChangedToUngraceful",
            .step_pending_application_health_monitor => "stepPendingApplicationHealthMonitor",
            .plan_evaluation_warning => "planEvaluationWarning",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
