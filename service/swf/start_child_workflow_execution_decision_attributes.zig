const ChildPolicy = @import("child_policy.zig").ChildPolicy;
const TaskList = @import("task_list.zig").TaskList;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Provides the details of the `StartChildWorkflowExecution` decision.
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
/// * `tagList.member.N` – The key is "swf:tagList.N" where N is the tag number
///   from 0 to 4,
/// inclusive.
///
/// * `taskList` – String constraint. The key is `swf:taskList.name`.
///
/// * `workflowType.name` – String constraint. The key is
///   `swf:workflowType.name`.
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
pub const StartChildWorkflowExecutionDecisionAttributes = struct {
    /// If set, specifies the policy to use for the child workflow executions if the
    /// workflow execution
    /// being started is terminated by calling the TerminateWorkflowExecution action
    /// explicitly or due to an
    /// expired timeout. This policy overrides the default child policy specified
    /// when registering the workflow type using
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

    /// The data attached to the event that can be used by the decider in subsequent
    /// workflow tasks. This data isn't sent to the child workflow execution.
    control: ?[]const u8 = null,

    /// The total duration for this workflow execution. This overrides the
    /// defaultExecutionStartToCloseTimeout specified when registering the workflow
    /// type.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    ///
    /// An execution start-to-close timeout for this workflow execution must be
    /// specified either as a default for the workflow type or through this
    /// parameter. If neither this parameter is set nor a default execution
    /// start-to-close timeout was specified at registration time then a fault is
    /// returned.
    execution_start_to_close_timeout: ?[]const u8 = null,

    /// The input to be provided to the workflow execution.
    input: ?[]const u8 = null,

    /// The IAM role attached to the child workflow execution.
    lambda_role: ?[]const u8 = null,

    /// The list of tags to associate with the child workflow execution. A maximum
    /// of 5 tags can be specified. You can
    /// list workflow executions with a specific tag by calling
    /// ListOpenWorkflowExecutions or
    /// ListClosedWorkflowExecutions and specifying a TagFilter.
    tag_list: ?[]const []const u8 = null,

    /// The name of the task list to be used for decision tasks of the child
    /// workflow execution.
    ///
    /// A task list for this workflow execution must be specified either as a
    /// default for the workflow type or through this parameter. If neither this
    /// parameter is set nor a default task list was specified at registration time
    /// then a fault is returned.
    ///
    /// The specified string must not start or end with whitespace. It must not
    /// contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    task_list: ?TaskList = null,

    /// A task priority that, if set, specifies the priority for a decision task of
    /// this workflow
    /// execution. This overrides the defaultTaskPriority specified when registering
    /// the workflow type.
    /// Valid values are integers that range from Java's `Integer.MIN_VALUE`
    /// (-2147483648) to `Integer.MAX_VALUE` (2147483647). Higher numbers indicate
    /// higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *Amazon SWF Developer Guide*.
    task_priority: ?[]const u8 = null,

    /// Specifies the maximum duration of decision tasks for this workflow
    /// execution. This parameter overrides the
    /// `defaultTaskStartToCloseTimout` specified when registering the workflow type
    /// using
    /// RegisterWorkflowType.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    ///
    /// A task start-to-close timeout for this workflow execution must be specified
    /// either as a default for the workflow type or through this parameter. If
    /// neither this parameter is set nor a default task start-to-close timeout was
    /// specified at registration time then a fault is returned.
    task_start_to_close_timeout: ?[]const u8 = null,

    /// The `workflowId` of the workflow execution.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    workflow_id: []const u8,

    /// The type of the workflow execution to be started.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .child_policy = "childPolicy",
        .control = "control",
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
