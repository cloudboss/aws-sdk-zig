const std = @import("std");

pub const ContinueAsNewWorkflowExecutionFailedCause = enum {
    unhandled_decision,
    workflow_type_deprecated,
    workflow_type_does_not_exist,
    default_execution_start_to_close_timeout_undefined,
    default_task_start_to_close_timeout_undefined,
    default_task_list_undefined,
    default_child_policy_undefined,
    continue_as_new_workflow_execution_rate_exceeded,
    operation_not_permitted,

    pub const json_field_names = .{
        .unhandled_decision = "UNHANDLED_DECISION",
        .workflow_type_deprecated = "WORKFLOW_TYPE_DEPRECATED",
        .workflow_type_does_not_exist = "WORKFLOW_TYPE_DOES_NOT_EXIST",
        .default_execution_start_to_close_timeout_undefined = "DEFAULT_EXECUTION_START_TO_CLOSE_TIMEOUT_UNDEFINED",
        .default_task_start_to_close_timeout_undefined = "DEFAULT_TASK_START_TO_CLOSE_TIMEOUT_UNDEFINED",
        .default_task_list_undefined = "DEFAULT_TASK_LIST_UNDEFINED",
        .default_child_policy_undefined = "DEFAULT_CHILD_POLICY_UNDEFINED",
        .continue_as_new_workflow_execution_rate_exceeded = "CONTINUE_AS_NEW_WORKFLOW_EXECUTION_RATE_EXCEEDED",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unhandled_decision => "UNHANDLED_DECISION",
            .workflow_type_deprecated => "WORKFLOW_TYPE_DEPRECATED",
            .workflow_type_does_not_exist => "WORKFLOW_TYPE_DOES_NOT_EXIST",
            .default_execution_start_to_close_timeout_undefined => "DEFAULT_EXECUTION_START_TO_CLOSE_TIMEOUT_UNDEFINED",
            .default_task_start_to_close_timeout_undefined => "DEFAULT_TASK_START_TO_CLOSE_TIMEOUT_UNDEFINED",
            .default_task_list_undefined => "DEFAULT_TASK_LIST_UNDEFINED",
            .default_child_policy_undefined => "DEFAULT_CHILD_POLICY_UNDEFINED",
            .continue_as_new_workflow_execution_rate_exceeded => "CONTINUE_AS_NEW_WORKFLOW_EXECUTION_RATE_EXCEEDED",
            .operation_not_permitted => "OPERATION_NOT_PERMITTED",
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
