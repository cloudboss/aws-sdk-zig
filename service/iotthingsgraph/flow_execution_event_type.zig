const std = @import("std");

pub const FlowExecutionEventType = enum {
    execution_started,
    execution_failed,
    execution_aborted,
    execution_succeeded,
    step_started,
    step_failed,
    step_succeeded,
    activity_scheduled,
    activity_started,
    activity_failed,
    activity_succeeded,
    start_flow_execution_task,
    schedule_next_ready_steps_task,
    thing_action_task,
    thing_action_task_failed,
    thing_action_task_succeeded,
    acknowledge_task_message,

    pub const json_field_names = .{
        .execution_started = "EXECUTION_STARTED",
        .execution_failed = "EXECUTION_FAILED",
        .execution_aborted = "EXECUTION_ABORTED",
        .execution_succeeded = "EXECUTION_SUCCEEDED",
        .step_started = "STEP_STARTED",
        .step_failed = "STEP_FAILED",
        .step_succeeded = "STEP_SUCCEEDED",
        .activity_scheduled = "ACTIVITY_SCHEDULED",
        .activity_started = "ACTIVITY_STARTED",
        .activity_failed = "ACTIVITY_FAILED",
        .activity_succeeded = "ACTIVITY_SUCCEEDED",
        .start_flow_execution_task = "START_FLOW_EXECUTION_TASK",
        .schedule_next_ready_steps_task = "SCHEDULE_NEXT_READY_STEPS_TASK",
        .thing_action_task = "THING_ACTION_TASK",
        .thing_action_task_failed = "THING_ACTION_TASK_FAILED",
        .thing_action_task_succeeded = "THING_ACTION_TASK_SUCCEEDED",
        .acknowledge_task_message = "ACKNOWLEDGE_TASK_MESSAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .execution_started => "EXECUTION_STARTED",
            .execution_failed => "EXECUTION_FAILED",
            .execution_aborted => "EXECUTION_ABORTED",
            .execution_succeeded => "EXECUTION_SUCCEEDED",
            .step_started => "STEP_STARTED",
            .step_failed => "STEP_FAILED",
            .step_succeeded => "STEP_SUCCEEDED",
            .activity_scheduled => "ACTIVITY_SCHEDULED",
            .activity_started => "ACTIVITY_STARTED",
            .activity_failed => "ACTIVITY_FAILED",
            .activity_succeeded => "ACTIVITY_SUCCEEDED",
            .start_flow_execution_task => "START_FLOW_EXECUTION_TASK",
            .schedule_next_ready_steps_task => "SCHEDULE_NEXT_READY_STEPS_TASK",
            .thing_action_task => "THING_ACTION_TASK",
            .thing_action_task_failed => "THING_ACTION_TASK_FAILED",
            .thing_action_task_succeeded => "THING_ACTION_TASK_SUCCEEDED",
            .acknowledge_task_message => "ACKNOWLEDGE_TASK_MESSAGE",
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
