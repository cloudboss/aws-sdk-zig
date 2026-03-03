const ChildPolicy = @import("child_policy.zig").ChildPolicy;
const TaskList = @import("task_list.zig").TaskList;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Provides the details of the `StartChildWorkflowExecutionInitiated` event.
pub const StartChildWorkflowExecutionInitiatedEventAttributes = struct {
    /// The policy to use for the child workflow executions if this execution gets
    /// terminated by explicitly calling the
    /// TerminateWorkflowExecution action or due to an expired timeout.
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

    /// Data attached to the event that can be used by the decider in subsequent
    /// decision tasks. This data isn't sent to the activity.
    control: ?[]const u8 = null,

    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `StartChildWorkflowExecution`
    /// Decision to request this child workflow execution. This
    /// information can be useful for diagnosing problems by tracing back the cause
    /// of events.
    decision_task_completed_event_id: i64 = 0,

    /// The maximum duration for the child workflow execution. If the workflow
    /// execution isn't closed within this duration, it is timed out and
    /// force-terminated.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    execution_start_to_close_timeout: ?[]const u8 = null,

    /// The inputs provided to the child workflow execution.
    input: ?[]const u8 = null,

    /// The IAM role to attach to the child workflow execution.
    lambda_role: ?[]const u8 = null,

    /// The list of tags to associated with the child workflow execution.
    tag_list: ?[]const []const u8 = null,

    /// The name of the task list used for the decision tasks of the child workflow
    /// execution.
    task_list: TaskList,

    /// The priority assigned for the decision tasks for this workflow execution.
    /// Valid values are integers that range from Java's `Integer.MIN_VALUE`
    /// (-2147483648) to `Integer.MAX_VALUE` (2147483647). Higher numbers indicate
    /// higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *Amazon SWF Developer Guide*.
    task_priority: ?[]const u8 = null,

    /// The maximum duration allowed for the decision tasks for this workflow
    /// execution.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    task_start_to_close_timeout: ?[]const u8 = null,

    /// The `workflowId` of the child workflow execution.
    workflow_id: []const u8,

    /// The type of the child workflow execution.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .child_policy = "childPolicy",
        .control = "control",
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .execution_start_to_close_timeout = "executionStartToCloseTimeout",
        .input = "input",
        .lambda_role = "lambdaRole",
        .tag_list = "tagList",
        .task_list = "taskList",
        .task_priority = "taskPriority",
        .task_start_to_close_timeout = "taskStartToCloseTimeout",
        .workflow_id = "workflowId",
        .workflow_type = "workflowType",
    };
};
