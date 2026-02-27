/// Contains the counts of open tasks, child workflow executions and timers for
/// a workflow execution.
pub const WorkflowExecutionOpenCounts = struct {
    /// The count of activity tasks whose status is `OPEN`.
    open_activity_tasks: i32 = 0,

    /// The count of child workflow executions whose status is `OPEN`.
    open_child_workflow_executions: i32 = 0,

    /// The count of decision tasks whose status is OPEN. A workflow execution can
    /// have at most one open decision task.
    open_decision_tasks: i32 = 0,

    /// The count of Lambda tasks whose status is `OPEN`.
    open_lambda_functions: i32 = 0,

    /// The count of timers started by this workflow execution that have not fired
    /// yet.
    open_timers: i32 = 0,

    pub const json_field_names = .{
        .open_activity_tasks = "openActivityTasks",
        .open_child_workflow_executions = "openChildWorkflowExecutions",
        .open_decision_tasks = "openDecisionTasks",
        .open_lambda_functions = "openLambdaFunctions",
        .open_timers = "openTimers",
    };
};
