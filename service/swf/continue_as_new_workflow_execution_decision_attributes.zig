const ChildPolicy = @import("child_policy.zig").ChildPolicy;
const TaskList = @import("task_list.zig").TaskList;

/// Provides the details of the `ContinueAsNewWorkflowExecution` decision.
///
/// **Access Control**
///
/// You can use IAM policies to control this decision's access to Amazon SWF
/// resources as follows:
///
/// * Use a `Resource` element with the domain name to limit the action to only
/// specified domains.
///
/// * Use an `Action` element to allow or deny permission to call this action.
///
/// * Constrain the following parameters by using a `Condition` element with the
/// appropriate keys.
///
/// * `tag` – A tag used to identify the workflow execution
///
/// * `taskList` – String constraint. The key is `swf:taskList.name`.
///
/// * `workflowType.version` – String constraint. The key is
///   `swf:workflowType.version`.
///
/// If the caller doesn't have sufficient permissions to invoke the action, or
/// the
/// parameter values fall outside the specified constraints, the action fails.
/// The associated event attribute's
/// `cause` parameter is set to `OPERATION_NOT_PERMITTED`. For details and
/// example IAM policies, see
/// [Using IAM to Manage Access to Amazon SWF
/// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
pub const ContinueAsNewWorkflowExecutionDecisionAttributes = struct {
    /// If set, specifies the policy to use for the child workflow executions of the
    /// new execution if it is terminated
    /// by calling the TerminateWorkflowExecution action explicitly or due to an
    /// expired timeout. This policy
    /// overrides the default child policy specified when registering the workflow
    /// type using
    /// RegisterWorkflowType.
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
    ///
    /// A child policy for this workflow execution must be specified either as a
    /// default for the workflow type or through this parameter. If neither this
    /// parameter is set nor a default child policy was specified at registration
    /// time then a fault is returned.
    child_policy: ?ChildPolicy = null,

    /// If set, specifies the total duration for this workflow execution. This
    /// overrides the
    /// `defaultExecutionStartToCloseTimeout` specified when registering the
    /// workflow type.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    ///
    /// An execution start-to-close timeout for this workflow execution must be
    /// specified either as a default for the workflow type or through this field.
    /// If neither this field is set nor a default execution start-to-close timeout
    /// was specified at registration time then a fault is returned.
    execution_start_to_close_timeout: ?[]const u8 = null,

    /// The input provided to the new workflow execution.
    input: ?[]const u8 = null,

    /// The IAM role to attach to the new (continued) execution.
    lambda_role: ?[]const u8 = null,

    /// The list of tags to associate with the new workflow execution. A maximum of
    /// 5 tags can be specified. You can
    /// list workflow executions with a specific tag by calling
    /// ListOpenWorkflowExecutions or
    /// ListClosedWorkflowExecutions and specifying a TagFilter.
    tag_list: ?[]const []const u8 = null,

    /// The task list to use for the decisions of the new (continued) workflow
    /// execution.
    task_list: ?TaskList = null,

    /// The task priority that, if set, specifies the priority for the decision
    /// tasks for this workflow
    /// execution. This overrides the defaultTaskPriority specified when registering
    /// the workflow type.
    /// Valid values are integers that range from Java's `Integer.MIN_VALUE`
    /// (-2147483648) to `Integer.MAX_VALUE` (2147483647). Higher numbers indicate
    /// higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *Amazon SWF Developer Guide*.
    task_priority: ?[]const u8 = null,

    /// Specifies the maximum duration of decision tasks for the new workflow
    /// execution. This parameter overrides the
    /// `defaultTaskStartToCloseTimout` specified when registering the workflow type
    /// using
    /// RegisterWorkflowType.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    ///
    /// A task start-to-close timeout for the new workflow execution must be
    /// specified either as a default for the workflow type or through this
    /// parameter. If neither this parameter is set nor a default task
    /// start-to-close timeout was specified at registration time then a fault is
    /// returned.
    task_start_to_close_timeout: ?[]const u8 = null,

    /// The version of the workflow to start.
    workflow_type_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .child_policy = "childPolicy",
        .execution_start_to_close_timeout = "executionStartToCloseTimeout",
        .input = "input",
        .lambda_role = "lambdaRole",
        .tag_list = "tagList",
        .task_list = "taskList",
        .task_priority = "taskPriority",
        .task_start_to_close_timeout = "taskStartToCloseTimeout",
        .workflow_type_version = "workflowTypeVersion",
    };
};
