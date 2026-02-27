const ChildPolicy = @import("child_policy.zig").ChildPolicy;
const TaskList = @import("task_list.zig").TaskList;

/// The configuration settings of a workflow type.
pub const WorkflowTypeConfiguration = struct {
    /// The default policy to use for the child workflow executions when a workflow
    /// execution of this
    /// type is terminated, by calling the TerminateWorkflowExecution action
    /// explicitly or due to an expired
    /// timeout. This default can be overridden when starting a workflow execution
    /// using the StartWorkflowExecution
    /// action or the `StartChildWorkflowExecution`
    /// Decision.
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
    default_child_policy: ?ChildPolicy,

    /// The default maximum duration, specified when registering the workflow type,
    /// for executions of
    /// this workflow type. This default can be overridden when starting a workflow
    /// execution using the
    /// StartWorkflowExecution action or the `StartChildWorkflowExecution`
    /// Decision.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_execution_start_to_close_timeout: ?[]const u8,

    /// The default IAM role attached to this workflow type.
    ///
    /// Executions of this workflow type need IAM roles to invoke Lambda functions.
    /// If you
    /// don't specify an IAM role when starting this workflow type, the default
    /// Lambda role is
    /// attached to the execution. For more information, see
    /// [https://docs.aws.amazon.com/amazonswf/latest/developerguide/lambda-task.html](https://docs.aws.amazon.com/amazonswf/latest/developerguide/lambda-task.html) in the
    /// *Amazon SWF Developer Guide*.
    default_lambda_role: ?[]const u8,

    /// The default task list, specified when registering the workflow type, for
    /// decisions tasks
    /// scheduled for workflow executions of this type. This default can be
    /// overridden when starting a workflow execution
    /// using the StartWorkflowExecution action or the `StartChildWorkflowExecution`
    /// Decision.
    default_task_list: ?TaskList,

    /// The default task priority, specified when registering the workflow type, for
    /// all decision tasks
    /// of this workflow type. This default can be overridden when starting a
    /// workflow execution using the
    /// StartWorkflowExecution action or the `StartChildWorkflowExecution` decision.
    ///
    /// Valid values are integers that range from Java's `Integer.MIN_VALUE`
    /// (-2147483648) to `Integer.MAX_VALUE` (2147483647). Higher numbers indicate
    /// higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *Amazon SWF Developer Guide*.
    default_task_priority: ?[]const u8,

    /// The default maximum duration, specified when registering the workflow type,
    /// that a decision task
    /// for executions of this workflow type might take before returning completion
    /// or failure. If the task doesn'tdo close
    /// in the specified time then the task is automatically timed out and
    /// rescheduled. If the decider eventually reports
    /// a completion or failure, it is ignored. This default can be overridden when
    /// starting a workflow execution using
    /// the StartWorkflowExecution action or the `StartChildWorkflowExecution`
    /// Decision.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_task_start_to_close_timeout: ?[]const u8,

    pub const json_field_names = .{
        .default_child_policy = "defaultChildPolicy",
        .default_execution_start_to_close_timeout = "defaultExecutionStartToCloseTimeout",
        .default_lambda_role = "defaultLambdaRole",
        .default_task_list = "defaultTaskList",
        .default_task_priority = "defaultTaskPriority",
        .default_task_start_to_close_timeout = "defaultTaskStartToCloseTimeout",
    };
};
