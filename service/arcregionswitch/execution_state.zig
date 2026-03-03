const std = @import("std");

pub const ExecutionState = enum {
    in_progress,
    paused_by_failed_step,
    paused_by_operator,
    completed,
    completed_with_exceptions,
    cancelled,
    plan_execution_timed_out,
    pending_manual_approval,
    failed,
    pending,
    completed_monitoring_application_health,

    pub const json_field_names = .{
        .in_progress = "inProgress",
        .paused_by_failed_step = "pausedByFailedStep",
        .paused_by_operator = "pausedByOperator",
        .completed = "completed",
        .completed_with_exceptions = "completedWithExceptions",
        .cancelled = "canceled",
        .plan_execution_timed_out = "planExecutionTimedOut",
        .pending_manual_approval = "pendingManualApproval",
        .failed = "failed",
        .pending = "pending",
        .completed_monitoring_application_health = "completedMonitoringApplicationHealth",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "inProgress",
            .paused_by_failed_step => "pausedByFailedStep",
            .paused_by_operator => "pausedByOperator",
            .completed => "completed",
            .completed_with_exceptions => "completedWithExceptions",
            .cancelled => "canceled",
            .plan_execution_timed_out => "planExecutionTimedOut",
            .pending_manual_approval => "pendingManualApproval",
            .failed => "failed",
            .pending => "pending",
            .completed_monitoring_application_health => "completedMonitoringApplicationHealth",
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
