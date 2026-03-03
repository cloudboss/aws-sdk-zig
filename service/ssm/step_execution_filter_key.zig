const std = @import("std");

pub const StepExecutionFilterKey = enum {
    start_time_before,
    start_time_after,
    step_execution_status,
    step_execution_id,
    step_name,
    action,
    parent_step_execution_id,
    parent_step_iteration,
    parent_step_iterator_value,

    pub const json_field_names = .{
        .start_time_before = "StartTimeBefore",
        .start_time_after = "StartTimeAfter",
        .step_execution_status = "StepExecutionStatus",
        .step_execution_id = "StepExecutionId",
        .step_name = "StepName",
        .action = "Action",
        .parent_step_execution_id = "ParentStepExecutionId",
        .parent_step_iteration = "ParentStepIteration",
        .parent_step_iterator_value = "ParentStepIteratorValue",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_time_before => "StartTimeBefore",
            .start_time_after => "StartTimeAfter",
            .step_execution_status => "StepExecutionStatus",
            .step_execution_id => "StepExecutionId",
            .step_name => "StepName",
            .action => "Action",
            .parent_step_execution_id => "ParentStepExecutionId",
            .parent_step_iteration => "ParentStepIteration",
            .parent_step_iterator_value => "ParentStepIteratorValue",
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
