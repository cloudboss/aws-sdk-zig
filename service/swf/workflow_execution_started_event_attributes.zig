const ChildPolicy = @import("child_policy.zig").ChildPolicy;
const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;
const TaskList = @import("task_list.zig").TaskList;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Provides details of `WorkflowExecutionStarted` event.
pub const WorkflowExecutionStartedEventAttributes = struct {
    /// The policy to use for the child workflow executions if this workflow
    /// execution is terminated, by calling the
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

    /// If this workflow execution was started due to a
    /// `ContinueAsNewWorkflowExecution` decision, then it
    /// contains the `runId` of the previous workflow execution that was closed and
    /// continued as this
    /// execution.
    continued_execution_run_id: ?[]const u8,

    /// The maximum duration for this workflow execution.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    execution_start_to_close_timeout: ?[]const u8,

    /// The input provided to the workflow execution.
    input: ?[]const u8,

    /// The IAM role attached to the workflow execution.
    lambda_role: ?[]const u8,

    /// The ID of the `StartChildWorkflowExecutionInitiated` event corresponding to
    /// the
    /// `StartChildWorkflowExecution`
    /// Decision to start this workflow execution. The source event with
    /// this ID can be found in the history of the source workflow execution. This
    /// information can be useful for diagnosing problems by tracing back the chain
    /// of
    /// events leading up to this event.
    parent_initiated_event_id: i64 = 0,

    /// The source workflow execution that started this workflow execution. The
    /// member isn't set if the workflow execution was not started by a workflow.
    parent_workflow_execution: ?WorkflowExecution,

    /// The list of tags associated with this workflow execution. An execution can
    /// have up to 5 tags.
    tag_list: ?[]const []const u8,

    /// The name of the task list for scheduling the decision tasks for this
    /// workflow execution.
    task_list: TaskList,

    /// The priority of the decision tasks in the workflow execution.
    task_priority: ?[]const u8,

    /// The maximum duration of decision tasks for this workflow type.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    task_start_to_close_timeout: ?[]const u8,

    /// The workflow type of this execution.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .child_policy = "childPolicy",
        .continued_execution_run_id = "continuedExecutionRunId",
        .execution_start_to_close_timeout = "executionStartToCloseTimeout",
        .input = "input",
        .lambda_role = "lambdaRole",
        .parent_initiated_event_id = "parentInitiatedEventId",
        .parent_workflow_execution = "parentWorkflowExecution",
        .tag_list = "tagList",
        .task_list = "taskList",
        .task_priority = "taskPriority",
        .task_start_to_close_timeout = "taskStartToCloseTimeout",
        .workflow_type = "workflowType",
    };
};
