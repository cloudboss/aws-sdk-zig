const ChildPolicy = @import("child_policy.zig").ChildPolicy;
const TaskList = @import("task_list.zig").TaskList;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Provides the details of the `WorkflowExecutionContinuedAsNew` event.
pub const WorkflowExecutionContinuedAsNewEventAttributes = struct {
    /// The policy to use for the child workflow executions of the new execution if
    /// it is terminated by calling the
    /// TerminateWorkflowExecution action explicitly or due to an expired timeout.
    ///
    /// The supported child policies are:
    ///
    /// * `TERMINATE` – The child executions are terminated.
    ///
    /// * `REQUEST_CANCEL` – A request to cancel is attempted for each child
    /// execution by recording a `WorkflowExecutionCancelRequested` event in its
    /// history. It is up to the decider
    /// to take appropriate actions when it receives an execution history with this
    /// event.
    ///
    /// * `ABANDON` – No action is taken. The child executions continue to run.
    child_policy: ChildPolicy,

    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `ContinueAsNewWorkflowExecution` decision that started this execution. This
    /// information can be useful for diagnosing problems by tracing back the chain
    /// of
    /// events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The total duration allowed for the new workflow execution.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    execution_start_to_close_timeout: ?[]const u8,

    /// The input provided to the new workflow execution.
    input: ?[]const u8,

    /// The IAM role to attach to the new (continued) workflow execution.
    lambda_role: ?[]const u8,

    /// The `runId` of the new workflow execution.
    new_execution_run_id: []const u8,

    /// The list of tags associated with the new workflow execution.
    tag_list: ?[]const []const u8,

    /// The task list to use for the decisions of the new (continued) workflow
    /// execution.
    task_list: TaskList,

    /// The priority of the task to use for the decisions of the new (continued)
    /// workflow
    /// execution.
    task_priority: ?[]const u8,

    /// The maximum duration of decision tasks for the new workflow execution.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    task_start_to_close_timeout: ?[]const u8,

    /// The workflow type of this execution.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .child_policy = "childPolicy",
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .execution_start_to_close_timeout = "executionStartToCloseTimeout",
        .input = "input",
        .lambda_role = "lambdaRole",
        .new_execution_run_id = "newExecutionRunId",
        .tag_list = "tagList",
        .task_list = "taskList",
        .task_priority = "taskPriority",
        .task_start_to_close_timeout = "taskStartToCloseTimeout",
        .workflow_type = "workflowType",
    };
};
