const aws = @import("aws");
const std = @import("std");

const count_closed_workflow_executions = @import("count_closed_workflow_executions.zig");
const count_open_workflow_executions = @import("count_open_workflow_executions.zig");
const count_pending_activity_tasks = @import("count_pending_activity_tasks.zig");
const count_pending_decision_tasks = @import("count_pending_decision_tasks.zig");
const delete_activity_type = @import("delete_activity_type.zig");
const delete_workflow_type = @import("delete_workflow_type.zig");
const deprecate_activity_type = @import("deprecate_activity_type.zig");
const deprecate_domain = @import("deprecate_domain.zig");
const deprecate_workflow_type = @import("deprecate_workflow_type.zig");
const describe_activity_type = @import("describe_activity_type.zig");
const describe_domain = @import("describe_domain.zig");
const describe_workflow_execution = @import("describe_workflow_execution.zig");
const describe_workflow_type = @import("describe_workflow_type.zig");
const get_workflow_execution_history = @import("get_workflow_execution_history.zig");
const list_activity_types = @import("list_activity_types.zig");
const list_closed_workflow_executions = @import("list_closed_workflow_executions.zig");
const list_domains = @import("list_domains.zig");
const list_open_workflow_executions = @import("list_open_workflow_executions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_workflow_types = @import("list_workflow_types.zig");
const poll_for_activity_task = @import("poll_for_activity_task.zig");
const poll_for_decision_task = @import("poll_for_decision_task.zig");
const record_activity_task_heartbeat = @import("record_activity_task_heartbeat.zig");
const register_activity_type = @import("register_activity_type.zig");
const register_domain = @import("register_domain.zig");
const register_workflow_type = @import("register_workflow_type.zig");
const request_cancel_workflow_execution = @import("request_cancel_workflow_execution.zig");
const respond_activity_task_canceled = @import("respond_activity_task_canceled.zig");
const respond_activity_task_completed = @import("respond_activity_task_completed.zig");
const respond_activity_task_failed = @import("respond_activity_task_failed.zig");
const respond_decision_task_completed = @import("respond_decision_task_completed.zig");
const signal_workflow_execution = @import("signal_workflow_execution.zig");
const start_workflow_execution = @import("start_workflow_execution.zig");
const tag_resource = @import("tag_resource.zig");
const terminate_workflow_execution = @import("terminate_workflow_execution.zig");
const undeprecate_activity_type = @import("undeprecate_activity_type.zig");
const undeprecate_domain = @import("undeprecate_domain.zig");
const undeprecate_workflow_type = @import("undeprecate_workflow_type.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SWF";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Returns the number of closed workflow executions within the given domain
    /// that meet the
    /// specified filtering criteria.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `tagFilter.tag`: String constraint. The key is
    /// `swf:tagFilter.tag`.
    ///
    /// * `typeFilter.name`: String constraint. The key is
    /// `swf:typeFilter.name`.
    ///
    /// * `typeFilter.version`: String constraint. The key is
    /// `swf:typeFilter.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn countClosedWorkflowExecutions(self: *Self, allocator: std.mem.Allocator, input: count_closed_workflow_executions.CountClosedWorkflowExecutionsInput, options: count_closed_workflow_executions.Options) !count_closed_workflow_executions.CountClosedWorkflowExecutionsOutput {
        return count_closed_workflow_executions.execute(self, allocator, input, options);
    }

    /// Returns the number of open workflow executions within the given domain that
    /// meet the
    /// specified filtering criteria.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `tagFilter.tag`: String constraint. The key is
    /// `swf:tagFilter.tag`.
    ///
    /// * `typeFilter.name`: String constraint. The key is
    /// `swf:typeFilter.name`.
    ///
    /// * `typeFilter.version`: String constraint. The key is
    /// `swf:typeFilter.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn countOpenWorkflowExecutions(self: *Self, allocator: std.mem.Allocator, input: count_open_workflow_executions.CountOpenWorkflowExecutionsInput, options: count_open_workflow_executions.Options) !count_open_workflow_executions.CountOpenWorkflowExecutionsOutput {
        return count_open_workflow_executions.execute(self, allocator, input, options);
    }

    /// Returns the estimated number of activity tasks in the specified task list.
    /// The count
    /// returned is an approximation and isn't guaranteed to be exact. If you
    /// specify a task list that
    /// no activity task was ever scheduled in then `0` is returned.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the `taskList.name` parameter by using a
    /// `Condition` element with the `swf:taskList.name` key to allow the
    /// action to access only certain task lists.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn countPendingActivityTasks(self: *Self, allocator: std.mem.Allocator, input: count_pending_activity_tasks.CountPendingActivityTasksInput, options: count_pending_activity_tasks.Options) !count_pending_activity_tasks.CountPendingActivityTasksOutput {
        return count_pending_activity_tasks.execute(self, allocator, input, options);
    }

    /// Returns the estimated number of decision tasks in the specified task list.
    /// The count
    /// returned is an approximation and isn't guaranteed to be exact. If you
    /// specify a task list that
    /// no decision task was ever scheduled in then `0` is returned.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the `taskList.name` parameter by using a
    /// `Condition` element with the `swf:taskList.name` key to allow the
    /// action to access only certain task lists.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn countPendingDecisionTasks(self: *Self, allocator: std.mem.Allocator, input: count_pending_decision_tasks.CountPendingDecisionTasksInput, options: count_pending_decision_tasks.Options) !count_pending_decision_tasks.CountPendingDecisionTasksOutput {
        return count_pending_decision_tasks.execute(self, allocator, input, options);
    }

    /// Deletes the specified *activity type*.
    ///
    /// Note: Prior to deletion, activity types must first be **deprecated**.
    ///
    /// After an activity type has been deleted, you cannot schedule new activities
    /// of that type. Activities that started before the type was deleted will
    /// continue to run.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `activityType.name`: String constraint. The key is
    /// `swf:activityType.name`.
    ///
    /// * `activityType.version`: String constraint. The key is
    /// `swf:activityType.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn deleteActivityType(self: *Self, allocator: std.mem.Allocator, input: delete_activity_type.DeleteActivityTypeInput, options: delete_activity_type.Options) !delete_activity_type.DeleteActivityTypeOutput {
        return delete_activity_type.execute(self, allocator, input, options);
    }

    /// Deletes the specified *workflow type*.
    ///
    /// Note: Prior to deletion, workflow types must first be **deprecated**.
    ///
    /// After a workflow type has been deleted, you cannot create new executions of
    /// that type. Executions that
    /// started before the type was deleted will continue to run.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `workflowType.name`: String constraint. The key is
    /// `swf:workflowType.name`.
    ///
    /// * `workflowType.version`: String constraint. The key is
    /// `swf:workflowType.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn deleteWorkflowType(self: *Self, allocator: std.mem.Allocator, input: delete_workflow_type.DeleteWorkflowTypeInput, options: delete_workflow_type.Options) !delete_workflow_type.DeleteWorkflowTypeOutput {
        return delete_workflow_type.execute(self, allocator, input, options);
    }

    /// Deprecates the specified *activity type*. After an activity type has
    /// been deprecated, you cannot create new tasks of that activity type. Tasks of
    /// this type that
    /// were scheduled before the type was deprecated continue to run.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `activityType.name`: String constraint. The key is
    /// `swf:activityType.name`.
    ///
    /// * `activityType.version`: String constraint. The key is
    /// `swf:activityType.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn deprecateActivityType(self: *Self, allocator: std.mem.Allocator, input: deprecate_activity_type.DeprecateActivityTypeInput, options: deprecate_activity_type.Options) !deprecate_activity_type.DeprecateActivityTypeOutput {
        return deprecate_activity_type.execute(self, allocator, input, options);
    }

    /// Deprecates the specified domain. After a domain has been deprecated it
    /// cannot be used
    /// to create new workflow executions or register new types. However, you can
    /// still use visibility
    /// actions on this domain. Deprecating a domain also deprecates all activity
    /// and workflow types
    /// registered in the domain. Executions that were started before the domain was
    /// deprecated
    /// continues to run.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn deprecateDomain(self: *Self, allocator: std.mem.Allocator, input: deprecate_domain.DeprecateDomainInput, options: deprecate_domain.Options) !deprecate_domain.DeprecateDomainOutput {
        return deprecate_domain.execute(self, allocator, input, options);
    }

    /// Deprecates the specified *workflow type*. After a workflow type has
    /// been deprecated, you cannot create new executions of that type. Executions
    /// that were started
    /// before the type was deprecated continues to run. A deprecated workflow type
    /// may still be used
    /// when calling visibility actions.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `workflowType.name`: String constraint. The key is
    /// `swf:workflowType.name`.
    ///
    /// * `workflowType.version`: String constraint. The key is
    /// `swf:workflowType.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn deprecateWorkflowType(self: *Self, allocator: std.mem.Allocator, input: deprecate_workflow_type.DeprecateWorkflowTypeInput, options: deprecate_workflow_type.Options) !deprecate_workflow_type.DeprecateWorkflowTypeOutput {
        return deprecate_workflow_type.execute(self, allocator, input, options);
    }

    /// Returns information about the specified activity type. This includes
    /// configuration
    /// settings provided when the type was registered and other general information
    /// about the
    /// type.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `activityType.name`: String constraint. The key is
    /// `swf:activityType.name`.
    ///
    /// * `activityType.version`: String constraint. The key is
    /// `swf:activityType.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn describeActivityType(self: *Self, allocator: std.mem.Allocator, input: describe_activity_type.DescribeActivityTypeInput, options: describe_activity_type.Options) !describe_activity_type.DescribeActivityTypeOutput {
        return describe_activity_type.execute(self, allocator, input, options);
    }

    /// Returns information about the specified domain, including description and
    /// status.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn describeDomain(self: *Self, allocator: std.mem.Allocator, input: describe_domain.DescribeDomainInput, options: describe_domain.Options) !describe_domain.DescribeDomainOutput {
        return describe_domain.execute(self, allocator, input, options);
    }

    /// Returns information about the specified workflow execution including its
    /// type and some
    /// statistics.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn describeWorkflowExecution(self: *Self, allocator: std.mem.Allocator, input: describe_workflow_execution.DescribeWorkflowExecutionInput, options: describe_workflow_execution.Options) !describe_workflow_execution.DescribeWorkflowExecutionOutput {
        return describe_workflow_execution.execute(self, allocator, input, options);
    }

    /// Returns information about the specified *workflow type*. This
    /// includes configuration settings specified when the type was registered and
    /// other information
    /// such as creation date, current status, etc.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `workflowType.name`: String constraint. The key is
    /// `swf:workflowType.name`.
    ///
    /// * `workflowType.version`: String constraint. The key is
    /// `swf:workflowType.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn describeWorkflowType(self: *Self, allocator: std.mem.Allocator, input: describe_workflow_type.DescribeWorkflowTypeInput, options: describe_workflow_type.Options) !describe_workflow_type.DescribeWorkflowTypeOutput {
        return describe_workflow_type.execute(self, allocator, input, options);
    }

    /// Returns the history of the specified workflow execution. The results may be
    /// split into
    /// multiple pages. To retrieve subsequent pages, make the call again using the
    /// `nextPageToken` returned by the initial call.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn getWorkflowExecutionHistory(self: *Self, allocator: std.mem.Allocator, input: get_workflow_execution_history.GetWorkflowExecutionHistoryInput, options: get_workflow_execution_history.Options) !get_workflow_execution_history.GetWorkflowExecutionHistoryOutput {
        return get_workflow_execution_history.execute(self, allocator, input, options);
    }

    /// Returns information about all activities registered in the specified domain
    /// that match
    /// the specified name and registration status. The result includes information
    /// like creation
    /// date, current status of the activity, etc. The results may be split into
    /// multiple pages. To
    /// retrieve subsequent pages, make the call again using the `nextPageToken`
    /// returned
    /// by the initial call.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn listActivityTypes(self: *Self, allocator: std.mem.Allocator, input: list_activity_types.ListActivityTypesInput, options: list_activity_types.Options) !list_activity_types.ListActivityTypesOutput {
        return list_activity_types.execute(self, allocator, input, options);
    }

    /// Returns a list of closed workflow executions in the specified domain that
    /// meet the
    /// filtering criteria. The results may be split into multiple pages. To
    /// retrieve subsequent
    /// pages, make the call again using the nextPageToken returned by the initial
    /// call.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `tagFilter.tag`: String constraint. The key is
    /// `swf:tagFilter.tag`.
    ///
    /// * `typeFilter.name`: String constraint. The key is
    /// `swf:typeFilter.name`.
    ///
    /// * `typeFilter.version`: String constraint. The key is
    /// `swf:typeFilter.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn listClosedWorkflowExecutions(self: *Self, allocator: std.mem.Allocator, input: list_closed_workflow_executions.ListClosedWorkflowExecutionsInput, options: list_closed_workflow_executions.Options) !list_closed_workflow_executions.ListClosedWorkflowExecutionsOutput {
        return list_closed_workflow_executions.execute(self, allocator, input, options);
    }

    /// Returns the list of domains registered in the account. The results may be
    /// split into
    /// multiple pages. To retrieve subsequent pages, make the call again using the
    /// nextPageToken
    /// returned by the initial call.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains. The element must be set to
    /// `arn:aws:swf::AccountID:domain/*`, where *AccountID* is
    /// the account ID, with no dashes.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn listDomains(self: *Self, allocator: std.mem.Allocator, input: list_domains.ListDomainsInput, options: list_domains.Options) !list_domains.ListDomainsOutput {
        return list_domains.execute(self, allocator, input, options);
    }

    /// Returns a list of open workflow executions in the specified domain that meet
    /// the
    /// filtering criteria. The results may be split into multiple pages. To
    /// retrieve subsequent
    /// pages, make the call again using the nextPageToken returned by the initial
    /// call.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `tagFilter.tag`: String constraint. The key is
    /// `swf:tagFilter.tag`.
    ///
    /// * `typeFilter.name`: String constraint. The key is
    /// `swf:typeFilter.name`.
    ///
    /// * `typeFilter.version`: String constraint. The key is
    /// `swf:typeFilter.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn listOpenWorkflowExecutions(self: *Self, allocator: std.mem.Allocator, input: list_open_workflow_executions.ListOpenWorkflowExecutionsInput, options: list_open_workflow_executions.Options) !list_open_workflow_executions.ListOpenWorkflowExecutionsOutput {
        return list_open_workflow_executions.execute(self, allocator, input, options);
    }

    /// List tags for a given domain.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns information about workflow types in the specified domain. The
    /// results may be
    /// split into multiple pages that can be retrieved by making the call
    /// repeatedly.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn listWorkflowTypes(self: *Self, allocator: std.mem.Allocator, input: list_workflow_types.ListWorkflowTypesInput, options: list_workflow_types.Options) !list_workflow_types.ListWorkflowTypesOutput {
        return list_workflow_types.execute(self, allocator, input, options);
    }

    /// Used by workers to get an ActivityTask from the specified activity
    /// `taskList`. This initiates a long poll, where the service holds the HTTP
    /// connection open and responds as soon as a task becomes available. The
    /// maximum time the service
    /// holds on to the request before responding is 60 seconds. If no task is
    /// available within 60
    /// seconds, the poll returns an empty result. An empty result, in this context,
    /// means that an
    /// ActivityTask is returned, but that the value of taskToken is an empty
    /// string. If a task is
    /// returned, the worker should use its type to identify and process it
    /// correctly.
    ///
    /// Workers should set their client side socket timeout to at least 70 seconds
    /// (10
    /// seconds higher than the maximum time service may hold the poll request).
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the `taskList.name` parameter by using a
    /// `Condition` element with the `swf:taskList.name` key to allow the
    /// action to access only certain task lists.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn pollForActivityTask(self: *Self, allocator: std.mem.Allocator, input: poll_for_activity_task.PollForActivityTaskInput, options: poll_for_activity_task.Options) !poll_for_activity_task.PollForActivityTaskOutput {
        return poll_for_activity_task.execute(self, allocator, input, options);
    }

    /// Used by deciders to get a DecisionTask from the specified decision
    /// `taskList`. A decision task may be returned for any open workflow execution
    /// that
    /// is using the specified task list. The task includes a paginated view of the
    /// history of the
    /// workflow execution. The decider should use the workflow type and the history
    /// to determine how
    /// to properly handle the task.
    ///
    /// This action initiates a long poll, where the service holds the HTTP
    /// connection open and
    /// responds as soon a task becomes available. If no decision task is available
    /// in the specified
    /// task list before the timeout of 60 seconds expires, an empty result is
    /// returned. An empty
    /// result, in this context, means that a DecisionTask is returned, but that the
    /// value of
    /// taskToken is an empty string.
    ///
    /// Deciders should set their client side socket timeout to at least 70 seconds
    /// (10
    /// seconds higher than the timeout).
    ///
    /// Because the number of workflow history events for a single workflow
    /// execution might
    /// be very large, the result returned might be split up across a number of
    /// pages. To retrieve
    /// subsequent pages, make additional calls to `PollForDecisionTask` using the
    /// `nextPageToken` returned by the initial call. Note that you do
    /// *not* call `GetWorkflowExecutionHistory` with this
    /// `nextPageToken`. Instead, call `PollForDecisionTask`
    /// again.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the `taskList.name` parameter by using a
    /// `Condition` element with the `swf:taskList.name` key to allow the
    /// action to access only certain task lists.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn pollForDecisionTask(self: *Self, allocator: std.mem.Allocator, input: poll_for_decision_task.PollForDecisionTaskInput, options: poll_for_decision_task.Options) !poll_for_decision_task.PollForDecisionTaskOutput {
        return poll_for_decision_task.execute(self, allocator, input, options);
    }

    /// Used by activity workers to report to the service that the ActivityTask
    /// represented by the specified `taskToken` is still making progress. The
    /// worker
    /// can also specify details of the progress, for example percent complete,
    /// using the
    /// `details` parameter. This action can also be used by the worker as a
    /// mechanism to
    /// check if cancellation is being requested for the activity task. If a
    /// cancellation is being
    /// attempted for the specified task, then the boolean `cancelRequested` flag
    /// returned
    /// by the service is set to `true`.
    ///
    /// This action resets the `taskHeartbeatTimeout` clock. The
    /// `taskHeartbeatTimeout` is specified in RegisterActivityType.
    ///
    /// This action doesn't in itself create an event in the workflow execution
    /// history.
    /// However, if the task times out, the workflow execution history contains a
    /// `ActivityTaskTimedOut` event that contains the information from the last
    /// heartbeat generated by the activity worker.
    ///
    /// The `taskStartToCloseTimeout` of an activity type is the maximum duration
    /// of an activity task, regardless of the number of RecordActivityTaskHeartbeat
    /// requests received. The `taskStartToCloseTimeout` is also specified in
    /// RegisterActivityType.
    ///
    /// This operation is only useful for long-lived activities to report liveliness
    /// of the
    /// task and to determine if a cancellation is being attempted.
    ///
    /// If the `cancelRequested` flag returns `true`, a cancellation is
    /// being attempted. If the worker can cancel the activity, it should respond
    /// with RespondActivityTaskCanceled. Otherwise, it should ignore the
    /// cancellation
    /// request.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn recordActivityTaskHeartbeat(self: *Self, allocator: std.mem.Allocator, input: record_activity_task_heartbeat.RecordActivityTaskHeartbeatInput, options: record_activity_task_heartbeat.Options) !record_activity_task_heartbeat.RecordActivityTaskHeartbeatOutput {
        return record_activity_task_heartbeat.execute(self, allocator, input, options);
    }

    /// Registers a new *activity type* along with its configuration
    /// settings in the specified domain.
    ///
    /// A `TypeAlreadyExists` fault is returned if the type already exists in the
    /// domain. You cannot change any configuration settings of the type after its
    /// registration, and
    /// it must be registered as a new version.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `defaultTaskList.name`: String constraint. The key is
    /// `swf:defaultTaskList.name`.
    ///
    /// * `name`: String constraint. The key is `swf:name`.
    ///
    /// * `version`: String constraint. The key is
    /// `swf:version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn registerActivityType(self: *Self, allocator: std.mem.Allocator, input: register_activity_type.RegisterActivityTypeInput, options: register_activity_type.Options) !register_activity_type.RegisterActivityTypeOutput {
        return register_activity_type.execute(self, allocator, input, options);
    }

    /// Registers a new domain.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * You cannot use an IAM policy to control domain access for this action. The
    ///   name of
    /// the domain being registered is available as the resource of this action.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn registerDomain(self: *Self, allocator: std.mem.Allocator, input: register_domain.RegisterDomainInput, options: register_domain.Options) !register_domain.RegisterDomainOutput {
        return register_domain.execute(self, allocator, input, options);
    }

    /// Registers a new *workflow type* and its configuration settings in
    /// the specified domain.
    ///
    /// The retention period for the workflow history is set by the RegisterDomain
    /// action.
    ///
    /// If the type already exists, then a `TypeAlreadyExists` fault is returned.
    /// You cannot change the configuration settings of a workflow type once it is
    /// registered and it
    /// must be registered as a new version.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `defaultTaskList.name`: String constraint. The key is
    /// `swf:defaultTaskList.name`.
    ///
    /// * `name`: String constraint. The key is `swf:name`.
    ///
    /// * `version`: String constraint. The key is
    /// `swf:version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn registerWorkflowType(self: *Self, allocator: std.mem.Allocator, input: register_workflow_type.RegisterWorkflowTypeInput, options: register_workflow_type.Options) !register_workflow_type.RegisterWorkflowTypeOutput {
        return register_workflow_type.execute(self, allocator, input, options);
    }

    /// Records a `WorkflowExecutionCancelRequested` event in the currently running
    /// workflow execution identified by the given domain, workflowId, and runId.
    /// This logically
    /// requests the cancellation of the workflow execution as a whole. It is up to
    /// the decider to
    /// take appropriate actions when it receives an execution history with this
    /// event.
    ///
    /// If the runId isn't specified, the `WorkflowExecutionCancelRequested` event
    /// is recorded in the history of the current open workflow execution with the
    /// specified
    /// workflowId in the domain.
    ///
    /// Because this action allows the workflow to properly clean up and gracefully
    /// close, it
    /// should be used instead of TerminateWorkflowExecution when
    /// possible.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn requestCancelWorkflowExecution(self: *Self, allocator: std.mem.Allocator, input: request_cancel_workflow_execution.RequestCancelWorkflowExecutionInput, options: request_cancel_workflow_execution.Options) !request_cancel_workflow_execution.RequestCancelWorkflowExecutionOutput {
        return request_cancel_workflow_execution.execute(self, allocator, input, options);
    }

    /// Used by workers to tell the service that the ActivityTask identified
    /// by the `taskToken` was successfully canceled. Additional `details` can
    /// be provided using the `details` argument.
    ///
    /// These `details` (if provided) appear in the
    /// `ActivityTaskCanceled` event added to the workflow history.
    ///
    /// Only use this operation if the `canceled` flag of a
    /// RecordActivityTaskHeartbeat request returns `true` and if the
    /// activity can be safely undone or abandoned.
    ///
    /// A task is considered open from the time that it is scheduled until it is
    /// closed.
    /// Therefore a task is reported as open while a worker is processing it. A task
    /// is closed after
    /// it has been specified in a call to RespondActivityTaskCompleted,
    /// RespondActivityTaskCanceled, RespondActivityTaskFailed, or the task has
    /// [timed
    /// out](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dg-basic.html#swf-dev-timeout-types).
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn respondActivityTaskCanceled(self: *Self, allocator: std.mem.Allocator, input: respond_activity_task_canceled.RespondActivityTaskCanceledInput, options: respond_activity_task_canceled.Options) !respond_activity_task_canceled.RespondActivityTaskCanceledOutput {
        return respond_activity_task_canceled.execute(self, allocator, input, options);
    }

    /// Used by workers to tell the service that the ActivityTask identified
    /// by the `taskToken` completed successfully with a `result` (if provided).
    /// The `result` appears in the `ActivityTaskCompleted` event in the
    /// workflow history.
    ///
    /// If the requested task doesn't complete successfully, use
    /// RespondActivityTaskFailed instead. If the worker finds that the task is
    /// canceled through the `canceled` flag returned by
    /// RecordActivityTaskHeartbeat, it should cancel the task, clean up and then
    /// call
    /// RespondActivityTaskCanceled.
    ///
    /// A task is considered open from the time that it is scheduled until it is
    /// closed.
    /// Therefore a task is reported as open while a worker is processing it. A task
    /// is closed after
    /// it has been specified in a call to RespondActivityTaskCompleted,
    /// RespondActivityTaskCanceled, RespondActivityTaskFailed, or the
    /// task has [timed
    /// out](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dg-basic.html#swf-dev-timeout-types).
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn respondActivityTaskCompleted(self: *Self, allocator: std.mem.Allocator, input: respond_activity_task_completed.RespondActivityTaskCompletedInput, options: respond_activity_task_completed.Options) !respond_activity_task_completed.RespondActivityTaskCompletedOutput {
        return respond_activity_task_completed.execute(self, allocator, input, options);
    }

    /// Used by workers to tell the service that the ActivityTask identified
    /// by the `taskToken` has failed with `reason` (if specified). The
    /// `reason` and `details` appear in the `ActivityTaskFailed`
    /// event added to the workflow history.
    ///
    /// A task is considered open from the time that it is scheduled until it is
    /// closed.
    /// Therefore a task is reported as open while a worker is processing it. A task
    /// is closed after
    /// it has been specified in a call to RespondActivityTaskCompleted,
    /// RespondActivityTaskCanceled, RespondActivityTaskFailed, or the task has
    /// [timed
    /// out](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dg-basic.html#swf-dev-timeout-types).
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn respondActivityTaskFailed(self: *Self, allocator: std.mem.Allocator, input: respond_activity_task_failed.RespondActivityTaskFailedInput, options: respond_activity_task_failed.Options) !respond_activity_task_failed.RespondActivityTaskFailedOutput {
        return respond_activity_task_failed.execute(self, allocator, input, options);
    }

    /// Used by deciders to tell the service that the DecisionTask identified
    /// by the `taskToken` has successfully completed. The `decisions` argument
    /// specifies the list of decisions made while processing the task.
    ///
    /// A `DecisionTaskCompleted` event is added to the workflow history. The
    /// `executionContext` specified is attached to the event in the workflow
    /// execution
    /// history.
    ///
    /// **Access Control**
    ///
    /// If an IAM policy grants permission to use `RespondDecisionTaskCompleted`, it
    /// can express permissions for the list of decisions in the `decisions`
    /// parameter.
    /// Each of the decisions has one or more parameters, much like a regular API
    /// call. To allow for
    /// policies to be as readable as possible, you can express permissions on
    /// decisions as if they
    /// were actual API calls, including applying conditions to some parameters. For
    /// more information,
    /// see [Using
    /// IAM to Manage Access to Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the
    /// *Amazon SWF Developer Guide*.
    pub fn respondDecisionTaskCompleted(self: *Self, allocator: std.mem.Allocator, input: respond_decision_task_completed.RespondDecisionTaskCompletedInput, options: respond_decision_task_completed.Options) !respond_decision_task_completed.RespondDecisionTaskCompletedOutput {
        return respond_decision_task_completed.execute(self, allocator, input, options);
    }

    /// Records a `WorkflowExecutionSignaled` event in the workflow execution
    /// history and creates a decision task for the workflow execution identified by
    /// the given domain,
    /// workflowId and runId. The event is recorded with the specified user defined
    /// signalName and
    /// input (if provided).
    ///
    /// If a runId isn't specified, then the `WorkflowExecutionSignaled` event is
    /// recorded in the history of the current open workflow with the matching
    /// workflowId in the
    /// domain.
    ///
    /// If the specified workflow execution isn't open, this method fails with
    /// `UnknownResource`.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn signalWorkflowExecution(self: *Self, allocator: std.mem.Allocator, input: signal_workflow_execution.SignalWorkflowExecutionInput, options: signal_workflow_execution.Options) !signal_workflow_execution.SignalWorkflowExecutionOutput {
        return signal_workflow_execution.execute(self, allocator, input, options);
    }

    /// Starts an execution of the workflow type in the specified domain using the
    /// provided
    /// `workflowId` and input data.
    ///
    /// This action returns the newly started workflow execution.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `tagList.member.0`: The key is `swf:tagList.member.0`.
    ///
    /// * `tagList.member.1`: The key is `swf:tagList.member.1`.
    ///
    /// * `tagList.member.2`: The key is `swf:tagList.member.2`.
    ///
    /// * `tagList.member.3`: The key is `swf:tagList.member.3`.
    ///
    /// * `tagList.member.4`: The key is `swf:tagList.member.4`.
    ///
    /// * `taskList`: String constraint. The key is
    /// `swf:taskList.name`.
    ///
    /// * `workflowType.name`: String constraint. The key is
    /// `swf:workflowType.name`.
    ///
    /// * `workflowType.version`: String constraint. The key is
    /// `swf:workflowType.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn startWorkflowExecution(self: *Self, allocator: std.mem.Allocator, input: start_workflow_execution.StartWorkflowExecutionInput, options: start_workflow_execution.Options) !start_workflow_execution.StartWorkflowExecutionOutput {
        return start_workflow_execution.execute(self, allocator, input, options);
    }

    /// Add a tag to a Amazon SWF domain.
    ///
    /// Amazon SWF supports a maximum of 50 tags per resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Records a `WorkflowExecutionTerminated` event and forces closure of the
    /// workflow execution identified by the given domain, runId, and workflowId.
    /// The child policy,
    /// registered with the workflow type or specified when starting this execution,
    /// is applied to any
    /// open child workflow executions of this workflow execution.
    ///
    /// If the identified workflow execution was in progress, it is terminated
    /// immediately.
    ///
    /// If a runId isn't specified, then the `WorkflowExecutionTerminated` event
    /// is recorded in the history of the current open workflow with the matching
    /// workflowId in the
    /// domain.
    ///
    /// You should consider using RequestCancelWorkflowExecution action
    /// instead because it allows the workflow to gracefully close while
    /// TerminateWorkflowExecution doesn't.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn terminateWorkflowExecution(self: *Self, allocator: std.mem.Allocator, input: terminate_workflow_execution.TerminateWorkflowExecutionInput, options: terminate_workflow_execution.Options) !terminate_workflow_execution.TerminateWorkflowExecutionOutput {
        return terminate_workflow_execution.execute(self, allocator, input, options);
    }

    /// Undeprecates a previously deprecated *activity type*. After an activity type
    /// has
    /// been undeprecated, you can create new tasks of that activity type.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `activityType.name`: String constraint. The key is
    /// `swf:activityType.name`.
    ///
    /// * `activityType.version`: String constraint. The key is
    /// `swf:activityType.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn undeprecateActivityType(self: *Self, allocator: std.mem.Allocator, input: undeprecate_activity_type.UndeprecateActivityTypeInput, options: undeprecate_activity_type.Options) !undeprecate_activity_type.UndeprecateActivityTypeOutput {
        return undeprecate_activity_type.execute(self, allocator, input, options);
    }

    /// Undeprecates a previously deprecated domain. After a domain has been
    /// undeprecated it can be used
    /// to create new workflow executions or register new types.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * You cannot use an IAM policy to constrain this action's parameters.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn undeprecateDomain(self: *Self, allocator: std.mem.Allocator, input: undeprecate_domain.UndeprecateDomainInput, options: undeprecate_domain.Options) !undeprecate_domain.UndeprecateDomainOutput {
        return undeprecate_domain.execute(self, allocator, input, options);
    }

    /// Undeprecates a previously deprecated *workflow type*. After a workflow type
    /// has
    /// been undeprecated, you can create new executions of that type.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// exactly reflect recent updates and changes.
    ///
    /// **Access Control**
    ///
    /// You can use IAM policies to control this action's access to Amazon SWF
    /// resources as
    /// follows:
    ///
    /// * Use a `Resource` element with the domain name to limit the action to
    /// only specified domains.
    ///
    /// * Use an `Action` element to allow or deny permission to call this
    /// action.
    ///
    /// * Constrain the following parameters by using a `Condition` element with
    /// the appropriate keys.
    ///
    /// * `workflowType.name`: String constraint. The key is
    /// `swf:workflowType.name`.
    ///
    /// * `workflowType.version`: String constraint. The key is
    /// `swf:workflowType.version`.
    ///
    /// If the caller doesn't have sufficient permissions to invoke the action, or
    /// the
    /// parameter values fall outside the specified constraints, the action fails.
    /// The associated
    /// event attribute's `cause` parameter is set to `OPERATION_NOT_PERMITTED`.
    /// For details and example IAM policies, see [Using IAM to Manage Access to
    /// Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
    pub fn undeprecateWorkflowType(self: *Self, allocator: std.mem.Allocator, input: undeprecate_workflow_type.UndeprecateWorkflowTypeInput, options: undeprecate_workflow_type.Options) !undeprecate_workflow_type.UndeprecateWorkflowTypeOutput {
        return undeprecate_workflow_type.execute(self, allocator, input, options);
    }

    /// Remove a tag from a Amazon SWF domain.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn getWorkflowExecutionHistoryPaginator(self: *Self, params: get_workflow_execution_history.GetWorkflowExecutionHistoryInput) paginator.GetWorkflowExecutionHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listActivityTypesPaginator(self: *Self, params: list_activity_types.ListActivityTypesInput) paginator.ListActivityTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClosedWorkflowExecutionsPaginator(self: *Self, params: list_closed_workflow_executions.ListClosedWorkflowExecutionsInput) paginator.ListClosedWorkflowExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainsPaginator(self: *Self, params: list_domains.ListDomainsInput) paginator.ListDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOpenWorkflowExecutionsPaginator(self: *Self, params: list_open_workflow_executions.ListOpenWorkflowExecutionsInput) paginator.ListOpenWorkflowExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowTypesPaginator(self: *Self, params: list_workflow_types.ListWorkflowTypesInput) paginator.ListWorkflowTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn pollForDecisionTaskPaginator(self: *Self, params: poll_for_decision_task.PollForDecisionTaskInput) paginator.PollForDecisionTaskPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
