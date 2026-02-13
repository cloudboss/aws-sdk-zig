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
        .start_time_before = "START_TIME_BEFORE",
        .start_time_after = "START_TIME_AFTER",
        .step_execution_status = "STEP_EXECUTION_STATUS",
        .step_execution_id = "STEP_EXECUTION_ID",
        .step_name = "STEP_NAME",
        .action = "ACTION",
        .parent_step_execution_id = "PARENT_STEP_EXECUTION_ID",
        .parent_step_iteration = "PARENT_STEP_ITERATION",
        .parent_step_iterator_value = "PARENT_STEP_ITERATOR_VALUE",
    };
};
