const std = @import("std");

pub const StartChildWorkflowExecutionFailedCause = enum {
    workflow_type_does_not_exist,
    workflow_type_deprecated,
    open_children_limit_exceeded,
    open_workflows_limit_exceeded,
    child_creation_rate_exceeded,
    workflow_already_running,
    default_execution_start_to_close_timeout_undefined,
    default_task_list_undefined,
    default_task_start_to_close_timeout_undefined,
    default_child_policy_undefined,
    operation_not_permitted,

    pub const json_field_names = .{
        .workflow_type_does_not_exist = "WORKFLOW_TYPE_DOES_NOT_EXIST",
        .workflow_type_deprecated = "WORKFLOW_TYPE_DEPRECATED",
        .open_children_limit_exceeded = "OPEN_CHILDREN_LIMIT_EXCEEDED",
        .open_workflows_limit_exceeded = "OPEN_WORKFLOWS_LIMIT_EXCEEDED",
        .child_creation_rate_exceeded = "CHILD_CREATION_RATE_EXCEEDED",
        .workflow_already_running = "WORKFLOW_ALREADY_RUNNING",
        .default_execution_start_to_close_timeout_undefined = "DEFAULT_EXECUTION_START_TO_CLOSE_TIMEOUT_UNDEFINED",
        .default_task_list_undefined = "DEFAULT_TASK_LIST_UNDEFINED",
        .default_task_start_to_close_timeout_undefined = "DEFAULT_TASK_START_TO_CLOSE_TIMEOUT_UNDEFINED",
        .default_child_policy_undefined = "DEFAULT_CHILD_POLICY_UNDEFINED",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .workflow_type_does_not_exist => "WORKFLOW_TYPE_DOES_NOT_EXIST",
            .workflow_type_deprecated => "WORKFLOW_TYPE_DEPRECATED",
            .open_children_limit_exceeded => "OPEN_CHILDREN_LIMIT_EXCEEDED",
            .open_workflows_limit_exceeded => "OPEN_WORKFLOWS_LIMIT_EXCEEDED",
            .child_creation_rate_exceeded => "CHILD_CREATION_RATE_EXCEEDED",
            .workflow_already_running => "WORKFLOW_ALREADY_RUNNING",
            .default_execution_start_to_close_timeout_undefined => "DEFAULT_EXECUTION_START_TO_CLOSE_TIMEOUT_UNDEFINED",
            .default_task_list_undefined => "DEFAULT_TASK_LIST_UNDEFINED",
            .default_task_start_to_close_timeout_undefined => "DEFAULT_TASK_START_TO_CLOSE_TIMEOUT_UNDEFINED",
            .default_child_policy_undefined => "DEFAULT_CHILD_POLICY_UNDEFINED",
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
