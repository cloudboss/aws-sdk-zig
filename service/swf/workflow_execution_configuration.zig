const ChildPolicy = @import("child_policy.zig").ChildPolicy;
const TaskList = @import("task_list.zig").TaskList;

/// The configuration settings for a workflow execution including timeout
/// values, tasklist etc. These configuration settings are determined from the
/// defaults specified when registering the workflow type and those specified
/// when starting the workflow execution.
pub const WorkflowExecutionConfiguration = struct {
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

    /// The total duration for this workflow execution.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    execution_start_to_close_timeout: []const u8,

    /// The IAM role attached to the child workflow execution.
    lambda_role: ?[]const u8 = null,

    /// The task list used for the decision tasks generated for this workflow
    /// execution.
    task_list: TaskList,

    /// The priority assigned to decision tasks for this workflow execution. Valid
    /// values are integers that range from Java's `Integer.MIN_VALUE`
    /// (-2147483648) to `Integer.MAX_VALUE` (2147483647). Higher numbers indicate
    /// higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *Amazon SWF Developer Guide*.
    task_priority: ?[]const u8 = null,

    /// The maximum duration allowed for decision tasks for this workflow execution.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    task_start_to_close_timeout: []const u8,

    pub const json_field_names = .{
        .child_policy = "childPolicy",
        .execution_start_to_close_timeout = "executionStartToCloseTimeout",
        .lambda_role = "lambdaRole",
        .task_list = "taskList",
        .task_priority = "taskPriority",
        .task_start_to_close_timeout = "taskStartToCloseTimeout",
    };
};
