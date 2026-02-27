const aws = @import("aws");
const std = @import("std");

const create_activity = @import("create_activity.zig");
const create_state_machine = @import("create_state_machine.zig");
const create_state_machine_alias = @import("create_state_machine_alias.zig");
const delete_activity = @import("delete_activity.zig");
const delete_state_machine = @import("delete_state_machine.zig");
const delete_state_machine_alias = @import("delete_state_machine_alias.zig");
const delete_state_machine_version = @import("delete_state_machine_version.zig");
const describe_activity = @import("describe_activity.zig");
const describe_execution = @import("describe_execution.zig");
const describe_map_run = @import("describe_map_run.zig");
const describe_state_machine = @import("describe_state_machine.zig");
const describe_state_machine_alias = @import("describe_state_machine_alias.zig");
const describe_state_machine_for_execution = @import("describe_state_machine_for_execution.zig");
const get_activity_task = @import("get_activity_task.zig");
const get_execution_history = @import("get_execution_history.zig");
const list_activities = @import("list_activities.zig");
const list_executions = @import("list_executions.zig");
const list_map_runs = @import("list_map_runs.zig");
const list_state_machine_aliases = @import("list_state_machine_aliases.zig");
const list_state_machine_versions = @import("list_state_machine_versions.zig");
const list_state_machines = @import("list_state_machines.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const publish_state_machine_version = @import("publish_state_machine_version.zig");
const redrive_execution = @import("redrive_execution.zig");
const send_task_failure = @import("send_task_failure.zig");
const send_task_heartbeat = @import("send_task_heartbeat.zig");
const send_task_success = @import("send_task_success.zig");
const start_execution = @import("start_execution.zig");
const start_sync_execution = @import("start_sync_execution.zig");
const stop_execution = @import("stop_execution.zig");
const tag_resource = @import("tag_resource.zig");
const test_state = @import("test_state.zig");
const untag_resource = @import("untag_resource.zig");
const update_map_run = @import("update_map_run.zig");
const update_state_machine = @import("update_state_machine.zig");
const update_state_machine_alias = @import("update_state_machine_alias.zig");
const validate_state_machine_definition = @import("validate_state_machine_definition.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SFN";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates an activity. An activity is a task that you write in any programming
    /// language and
    /// host on any machine that has access to Step Functions. Activities must poll
    /// Step Functions using the
    /// `GetActivityTask` API action and respond using `SendTask*` API
    /// actions. This function lets Step Functions know the existence of your
    /// activity and returns an
    /// identifier for use in a state machine and when polling from the activity.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not reflect very recent updates and changes.
    ///
    /// `CreateActivity` is an idempotent API. Subsequent requests won’t create a
    /// duplicate resource if it was already created. `CreateActivity`'s idempotency
    /// check is based on the activity `name`. If a following request has different
    /// `tags` values, Step Functions will ignore these differences and treat it as
    /// an
    /// idempotent request of the previous. In this case, `tags` will not be
    /// updated,
    /// even if they are different.
    pub fn createActivity(self: *Self, allocator: std.mem.Allocator, input: create_activity.CreateActivityInput, options: create_activity.Options) !create_activity.CreateActivityOutput {
        return create_activity.execute(self, allocator, input, options);
    }

    /// Creates a state machine. A state machine consists of a collection of states
    /// that can do
    /// work (`Task` states), determine to which states to transition next
    /// (`Choice` states), stop an execution with an error (`Fail` states),
    /// and so on. State machines are specified using a JSON-based, structured
    /// language. For more
    /// information, see [Amazon States
    /// Language](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html) in the Step Functions User Guide.
    ///
    /// If you set the `publish` parameter of this API action to `true`, it
    /// publishes version `1` as the first revision of the state machine.
    ///
    /// For additional control over security, you can encrypt your data using a
    /// **customer-managed key** for Step Functions state machines. You can
    /// configure a symmetric KMS key and data key reuse period when creating or
    /// updating a **State Machine**. The execution history and state machine
    /// definition will be encrypted with the key applied to the State Machine.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not reflect very recent updates and changes.
    ///
    /// `CreateStateMachine` is an idempotent API. Subsequent requests won’t create
    /// a
    /// duplicate resource if it was already created. `CreateStateMachine`'s
    /// idempotency
    /// check is based on the state machine `name`, `definition`,
    /// `type`, `LoggingConfiguration`,
    /// `TracingConfiguration`, and `EncryptionConfiguration` The check is also
    /// based on the `publish` and `versionDescription` parameters. If a following
    /// request has a different
    /// `roleArn` or `tags`, Step Functions will ignore these differences and treat
    /// it as an idempotent request of the previous. In this case, `roleArn` and
    /// `tags` will not be updated, even if they are different.
    pub fn createStateMachine(self: *Self, allocator: std.mem.Allocator, input: create_state_machine.CreateStateMachineInput, options: create_state_machine.Options) !create_state_machine.CreateStateMachineOutput {
        return create_state_machine.execute(self, allocator, input, options);
    }

    /// Creates an
    /// [alias](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html) for a state machine that points to one or two [versions](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html) of the same state machine. You can set your application to call StartExecution with an alias and update the version the alias uses without changing the client's code.
    ///
    /// You can also map an alias to split StartExecution requests between two
    /// versions of a state machine. To do this, add a second `RoutingConfig` object
    /// in the
    /// `routingConfiguration` parameter. You must also specify the percentage of
    /// execution run requests each version should receive in both `RoutingConfig`
    /// objects.
    /// Step Functions randomly chooses which version runs a given execution based
    /// on the
    /// percentage you specify.
    ///
    /// To create an alias that points to a single version, specify a single
    /// `RoutingConfig` object with a `weight` set to 100.
    ///
    /// You can create up to 100 aliases for each state machine. You must delete
    /// unused aliases using the DeleteStateMachineAlias API action.
    ///
    /// `CreateStateMachineAlias` is an idempotent API. Step Functions bases the
    /// idempotency check on the `stateMachineArn`, `description`,
    /// `name`, and `routingConfiguration` parameters. Requests that contain
    /// the same values for these parameters return a successful idempotent response
    /// without creating
    /// a duplicate resource.
    ///
    /// **Related operations:**
    ///
    /// * DescribeStateMachineAlias
    ///
    /// * ListStateMachineAliases
    ///
    /// * UpdateStateMachineAlias
    ///
    /// * DeleteStateMachineAlias
    pub fn createStateMachineAlias(self: *Self, allocator: std.mem.Allocator, input: create_state_machine_alias.CreateStateMachineAliasInput, options: create_state_machine_alias.Options) !create_state_machine_alias.CreateStateMachineAliasOutput {
        return create_state_machine_alias.execute(self, allocator, input, options);
    }

    /// Deletes an activity.
    pub fn deleteActivity(self: *Self, allocator: std.mem.Allocator, input: delete_activity.DeleteActivityInput, options: delete_activity.Options) !delete_activity.DeleteActivityOutput {
        return delete_activity.execute(self, allocator, input, options);
    }

    /// Deletes a state machine. This is an asynchronous operation. It sets the
    /// state machine's
    /// status to `DELETING` and begins the deletion process. A state machine is
    /// deleted only when all its executions are completed. On the next state
    /// transition, the state machine's executions are terminated.
    ///
    /// A qualified state machine ARN can either refer to a *Distributed Map state*
    /// defined within a state machine, a version ARN, or an alias ARN.
    ///
    /// The following are some examples of qualified and unqualified state machine
    /// ARNs:
    ///
    /// * The following qualified state machine ARN refers to a *Distributed Map
    ///   state* with a label `mapStateLabel` in a state machine named
    ///   `myStateMachine`.
    ///
    /// `arn:partition:states:region:account-id:stateMachine:myStateMachine/mapStateLabel`
    ///
    /// If you provide a qualified state machine ARN that refers to a *Distributed
    /// Map state*, the request fails with `ValidationException`.
    ///
    /// * The following unqualified state machine ARN refers to a state machine
    ///   named `myStateMachine`.
    ///
    /// `arn:partition:states:region:account-id:stateMachine:myStateMachine`
    ///
    /// This API action also deletes all
    /// [versions](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html) and [aliases](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html) associated with a state machine.
    ///
    /// For `EXPRESS` state machines, the deletion happens eventually (usually in
    /// less than a minute). Running executions may emit logs after
    /// `DeleteStateMachine`
    /// API is called.
    pub fn deleteStateMachine(self: *Self, allocator: std.mem.Allocator, input: delete_state_machine.DeleteStateMachineInput, options: delete_state_machine.Options) !delete_state_machine.DeleteStateMachineOutput {
        return delete_state_machine.execute(self, allocator, input, options);
    }

    /// Deletes a state machine
    /// [alias](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html).
    ///
    /// After you delete a state machine alias, you can't use it to start
    /// executions. When you
    /// delete a state machine alias, Step Functions doesn't delete the state
    /// machine versions
    /// that alias references.
    ///
    /// **Related operations:**
    ///
    /// * CreateStateMachineAlias
    ///
    /// * DescribeStateMachineAlias
    ///
    /// * ListStateMachineAliases
    ///
    /// * UpdateStateMachineAlias
    pub fn deleteStateMachineAlias(self: *Self, allocator: std.mem.Allocator, input: delete_state_machine_alias.DeleteStateMachineAliasInput, options: delete_state_machine_alias.Options) !delete_state_machine_alias.DeleteStateMachineAliasOutput {
        return delete_state_machine_alias.execute(self, allocator, input, options);
    }

    /// Deletes a state machine
    /// [version](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html). After
    /// you delete a version, you can't call StartExecution using that version's ARN
    /// or use the version with a state machine
    /// [alias](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html).
    ///
    /// Deleting a state machine version won't terminate its in-progress executions.
    ///
    /// You can't delete a state machine version currently referenced by one or more
    /// aliases. Before you delete a version, you must either delete the aliases or
    /// update them to point to another state machine version.
    ///
    /// **Related operations:**
    ///
    /// * PublishStateMachineVersion
    ///
    /// * ListStateMachineVersions
    pub fn deleteStateMachineVersion(self: *Self, allocator: std.mem.Allocator, input: delete_state_machine_version.DeleteStateMachineVersionInput, options: delete_state_machine_version.Options) !delete_state_machine_version.DeleteStateMachineVersionOutput {
        return delete_state_machine_version.execute(self, allocator, input, options);
    }

    /// Describes an activity.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not reflect very recent updates and changes.
    pub fn describeActivity(self: *Self, allocator: std.mem.Allocator, input: describe_activity.DescribeActivityInput, options: describe_activity.Options) !describe_activity.DescribeActivityOutput {
        return describe_activity.execute(self, allocator, input, options);
    }

    /// Provides information about a state machine execution, such as the state
    /// machine associated with the execution, the execution input and output, and
    /// relevant execution metadata. If you've
    /// [redriven](https://docs.aws.amazon.com/step-functions/latest/dg/redrive-executions.html) an execution, you can use this API action to return information about the redrives of that execution. In addition, you can use this API action to return the Map Run Amazon Resource Name (ARN) if the execution was dispatched by a Map Run.
    ///
    /// If you specify a version or alias ARN when you call the StartExecution
    /// API action, `DescribeExecution` returns that ARN.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not reflect very recent updates and changes.
    ///
    /// Executions of an `EXPRESS` state machine aren't supported by
    /// `DescribeExecution` unless a Map Run dispatched them.
    pub fn describeExecution(self: *Self, allocator: std.mem.Allocator, input: describe_execution.DescribeExecutionInput, options: describe_execution.Options) !describe_execution.DescribeExecutionOutput {
        return describe_execution.execute(self, allocator, input, options);
    }

    /// Provides information about a Map Run's configuration, progress, and results.
    /// If you've
    /// [redriven](https://docs.aws.amazon.com/step-functions/latest/dg/redrive-map-run.html) a Map Run, this API action also returns information about the redrives of that Map Run. For more information, see [Examining Map Run](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-examine-map-run.html) in the *Step Functions Developer Guide*.
    pub fn describeMapRun(self: *Self, allocator: std.mem.Allocator, input: describe_map_run.DescribeMapRunInput, options: describe_map_run.Options) !describe_map_run.DescribeMapRunOutput {
        return describe_map_run.execute(self, allocator, input, options);
    }

    /// Provides information about a state machine's definition, its IAM role Amazon
    /// Resource Name (ARN), and configuration.
    ///
    /// A qualified state machine ARN can either refer to a *Distributed Map state*
    /// defined within a state machine, a version ARN, or an alias ARN.
    ///
    /// The following are some examples of qualified and unqualified state machine
    /// ARNs:
    ///
    /// * The following qualified state machine ARN refers to a *Distributed Map
    ///   state* with a label `mapStateLabel` in a state machine named
    ///   `myStateMachine`.
    ///
    /// `arn:partition:states:region:account-id:stateMachine:myStateMachine/mapStateLabel`
    ///
    /// If you provide a qualified state machine ARN that refers to a *Distributed
    /// Map state*, the request fails with `ValidationException`.
    ///
    /// * The following qualified state machine ARN refers to an alias named `PROD`.
    ///
    /// `arn::states:::stateMachine:`
    ///
    /// If you provide a qualified state machine ARN that refers to a version ARN or
    /// an alias ARN, the request starts execution for that version or alias.
    ///
    /// * The following unqualified state machine ARN refers to a state machine
    ///   named `myStateMachine`.
    ///
    /// `arn::states:::stateMachine:`
    ///
    /// This API action returns the details for a state machine version if the
    /// `stateMachineArn` you specify is a state machine version ARN.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not reflect very recent updates and changes.
    pub fn describeStateMachine(self: *Self, allocator: std.mem.Allocator, input: describe_state_machine.DescribeStateMachineInput, options: describe_state_machine.Options) !describe_state_machine.DescribeStateMachineOutput {
        return describe_state_machine.execute(self, allocator, input, options);
    }

    /// Returns details about a state machine
    /// [alias](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html).
    ///
    /// **Related operations:**
    ///
    /// * CreateStateMachineAlias
    ///
    /// * ListStateMachineAliases
    ///
    /// * UpdateStateMachineAlias
    ///
    /// * DeleteStateMachineAlias
    pub fn describeStateMachineAlias(self: *Self, allocator: std.mem.Allocator, input: describe_state_machine_alias.DescribeStateMachineAliasInput, options: describe_state_machine_alias.Options) !describe_state_machine_alias.DescribeStateMachineAliasOutput {
        return describe_state_machine_alias.execute(self, allocator, input, options);
    }

    /// Provides information about a state machine's definition, its execution role
    /// ARN, and
    /// configuration. If a Map Run dispatched the execution, this action returns
    /// the Map Run
    /// Amazon Resource Name (ARN) in the response. The state machine returned is
    /// the state machine associated with the
    /// Map Run.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not reflect very recent updates and changes.
    ///
    /// This API action is not supported by `EXPRESS` state machines.
    pub fn describeStateMachineForExecution(self: *Self, allocator: std.mem.Allocator, input: describe_state_machine_for_execution.DescribeStateMachineForExecutionInput, options: describe_state_machine_for_execution.Options) !describe_state_machine_for_execution.DescribeStateMachineForExecutionOutput {
        return describe_state_machine_for_execution.execute(self, allocator, input, options);
    }

    /// Used by workers to retrieve a task (with the specified activity ARN) which
    /// has been
    /// scheduled for execution by a running state machine. This initiates a long
    /// poll, where the
    /// service holds the HTTP connection open and responds as soon as a task
    /// becomes available (i.e.
    /// an execution of a task of this type is needed.) The maximum time the service
    /// holds on to the
    /// request before responding is 60 seconds. If no task is available within 60
    /// seconds, the poll
    /// returns a `taskToken` with a null string.
    ///
    /// This API action isn't logged in CloudTrail.
    ///
    /// Workers should set their client side socket timeout to at least 65 seconds
    /// (5 seconds
    /// higher than the maximum time the service may hold the poll request).
    ///
    /// Polling with `GetActivityTask` can cause latency in some implementations.
    /// See
    /// [Avoid
    /// Latency When Polling for Activity
    /// Tasks](https://docs.aws.amazon.com/step-functions/latest/dg/bp-activity-pollers.html) in the Step Functions Developer Guide.
    pub fn getActivityTask(self: *Self, allocator: std.mem.Allocator, input: get_activity_task.GetActivityTaskInput, options: get_activity_task.Options) !get_activity_task.GetActivityTaskOutput {
        return get_activity_task.execute(self, allocator, input, options);
    }

    /// Returns the history of the specified execution as a list of events. By
    /// default, the
    /// results are returned in ascending order of the `timeStamp` of the events.
    /// Use the
    /// `reverseOrder` parameter to get the latest events first.
    ///
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    ///
    /// This API action is not supported by `EXPRESS` state machines.
    pub fn getExecutionHistory(self: *Self, allocator: std.mem.Allocator, input: get_execution_history.GetExecutionHistoryInput, options: get_execution_history.Options) !get_execution_history.GetExecutionHistoryOutput {
        return get_execution_history.execute(self, allocator, input, options);
    }

    /// Lists the existing activities.
    ///
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not reflect very recent updates and changes.
    pub fn listActivities(self: *Self, allocator: std.mem.Allocator, input: list_activities.ListActivitiesInput, options: list_activities.Options) !list_activities.ListActivitiesOutput {
        return list_activities.execute(self, allocator, input, options);
    }

    /// Lists all executions of a state machine or a Map Run. You can list all
    /// executions related to a state machine by specifying a state machine Amazon
    /// Resource Name (ARN), or those related to a Map Run by specifying a Map Run
    /// ARN. Using this API action, you can also list all
    /// [redriven](https://docs.aws.amazon.com/step-functions/latest/dg/redrive-executions.html) executions.
    ///
    /// You can also provide a state machine
    /// [alias](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html) ARN or [version](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html) ARN to list the executions associated with a specific alias or version.
    ///
    /// Results are
    /// sorted by time, with the most recent execution first.
    ///
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not reflect very recent updates and changes.
    ///
    /// This API action is not supported by `EXPRESS` state machines.
    pub fn listExecutions(self: *Self, allocator: std.mem.Allocator, input: list_executions.ListExecutionsInput, options: list_executions.Options) !list_executions.ListExecutionsOutput {
        return list_executions.execute(self, allocator, input, options);
    }

    /// Lists all Map Runs that were started by a given state machine execution. Use
    /// this API action to obtain Map Run ARNs, and then call `DescribeMapRun` to
    /// obtain more information, if needed.
    pub fn listMapRuns(self: *Self, allocator: std.mem.Allocator, input: list_map_runs.ListMapRunsInput, options: list_map_runs.Options) !list_map_runs.ListMapRunsOutput {
        return list_map_runs.execute(self, allocator, input, options);
    }

    /// Lists
    /// [aliases](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html) for a specified state machine ARN. Results are sorted by time, with the most recently created aliases listed first.
    ///
    /// To list aliases that reference a state machine
    /// [version](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html), you can specify the version ARN in the `stateMachineArn` parameter.
    ///
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    ///
    /// **Related operations:**
    ///
    /// * CreateStateMachineAlias
    ///
    /// * DescribeStateMachineAlias
    ///
    /// * UpdateStateMachineAlias
    ///
    /// * DeleteStateMachineAlias
    pub fn listStateMachineAliases(self: *Self, allocator: std.mem.Allocator, input: list_state_machine_aliases.ListStateMachineAliasesInput, options: list_state_machine_aliases.Options) !list_state_machine_aliases.ListStateMachineAliasesOutput {
        return list_state_machine_aliases.execute(self, allocator, input, options);
    }

    /// Lists
    /// [versions](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html) for the specified state machine Amazon Resource Name (ARN).
    ///
    /// The results are sorted in descending order of the version creation time.
    ///
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    ///
    /// **Related operations:**
    ///
    /// * PublishStateMachineVersion
    ///
    /// * DeleteStateMachineVersion
    pub fn listStateMachineVersions(self: *Self, allocator: std.mem.Allocator, input: list_state_machine_versions.ListStateMachineVersionsInput, options: list_state_machine_versions.Options) !list_state_machine_versions.ListStateMachineVersionsOutput {
        return list_state_machine_versions.execute(self, allocator, input, options);
    }

    /// Lists the existing state machines.
    ///
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not reflect very recent updates and changes.
    pub fn listStateMachines(self: *Self, allocator: std.mem.Allocator, input: list_state_machines.ListStateMachinesInput, options: list_state_machines.Options) !list_state_machines.ListStateMachinesOutput {
        return list_state_machines.execute(self, allocator, input, options);
    }

    /// List tags for a given resource.
    ///
    /// Tags may only contain Unicode letters, digits, white space, or these
    /// symbols: `_ . : / = + - @`.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates a
    /// [version](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html) from the
    /// current revision of a state machine. Use versions to create immutable
    /// snapshots of your state
    /// machine. You can start executions from versions either directly or with an
    /// alias. To create an
    /// alias, use CreateStateMachineAlias.
    ///
    /// You can publish up to 1000 versions for each state machine. You must
    /// manually delete unused versions using the DeleteStateMachineVersion API
    /// action.
    ///
    /// `PublishStateMachineVersion` is an idempotent API. It doesn't create a
    /// duplicate state machine version if it already exists for the current
    /// revision. Step Functions bases `PublishStateMachineVersion`'s idempotency
    /// check on the
    /// `stateMachineArn`, `name`, and `revisionId` parameters.
    /// Requests with the same parameters return a successful idempotent response.
    /// If you don't
    /// specify a `revisionId`, Step Functions checks for a previously published
    /// version of the state machine's current revision.
    ///
    /// **Related operations:**
    ///
    /// * DeleteStateMachineVersion
    ///
    /// * ListStateMachineVersions
    pub fn publishStateMachineVersion(self: *Self, allocator: std.mem.Allocator, input: publish_state_machine_version.PublishStateMachineVersionInput, options: publish_state_machine_version.Options) !publish_state_machine_version.PublishStateMachineVersionOutput {
        return publish_state_machine_version.execute(self, allocator, input, options);
    }

    /// Restarts unsuccessful executions of Standard workflows that didn't complete
    /// successfully in the last 14 days. These include failed, aborted, or timed
    /// out executions. When you
    /// [redrive](https://docs.aws.amazon.com/step-functions/latest/dg/redrive-executions.html) an execution, it continues the failed execution from the unsuccessful step and uses the same input. Step Functions preserves the results and execution history of the successful steps, and doesn't rerun these steps when you redrive an execution. Redriven executions use the same state machine definition and execution ARN as the original execution attempt.
    ///
    /// For workflows that include an [Inline
    /// Map](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-map-state.html) or [Parallel](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-parallel-state.html) state, `RedriveExecution` API action reschedules and redrives only the iterations and branches that failed or aborted.
    ///
    /// To redrive a workflow that includes a Distributed Map state whose Map Run
    /// failed, you must redrive the [parent
    /// workflow](https://docs.aws.amazon.com/step-functions/latest/dg/use-dist-map-orchestrate-large-scale-parallel-workloads.html#dist-map-orchestrate-parallel-workloads-key-terms). The parent workflow redrives all the unsuccessful states, including a failed Map Run. If a Map Run was not started in the original execution attempt, the redriven parent workflow starts the Map Run.
    ///
    /// This API action is not supported by `EXPRESS` state machines.
    ///
    /// However, you can restart the unsuccessful executions of Express child
    /// workflows in a Distributed Map by redriving its Map Run. When you redrive a
    /// Map Run, the Express child workflows are rerun using the StartExecution API
    /// action. For more information, see [Redriving Map
    /// Runs](https://docs.aws.amazon.com/step-functions/latest/dg/redrive-map-run.html).
    ///
    /// You can redrive executions if your original execution meets the following
    /// conditions:
    ///
    /// * The execution status isn't `SUCCEEDED`.
    ///
    /// * Your workflow execution has not exceeded the redrivable period of 14 days.
    ///   Redrivable period refers to the time during which you can redrive a given
    ///   execution. This period starts from the day a state machine completes its
    ///   execution.
    ///
    /// * The workflow execution has not exceeded the maximum open time of one year.
    ///   For more information about state machine quotas, see [Quotas related to
    ///   state machine
    ///   executions](https://docs.aws.amazon.com/step-functions/latest/dg/limits-overview.html#service-limits-state-machine-executions).
    ///
    /// * The execution event history count is less than 24,999. Redriven executions
    ///   append their event history to the existing event history. Make sure your
    ///   workflow execution contains less than 24,999 events to accommodate the
    ///   `ExecutionRedriven` history event and at least one other history event.
    pub fn redriveExecution(self: *Self, allocator: std.mem.Allocator, input: redrive_execution.RedriveExecutionInput, options: redrive_execution.Options) !redrive_execution.RedriveExecutionOutput {
        return redrive_execution.execute(self, allocator, input, options);
    }

    /// Used by activity workers, Task states using the
    /// [callback](https://docs.aws.amazon.com/step-functions/latest/dg/connect-to-resource.html#connect-wait-token)
    /// pattern, and optionally Task states using the [job
    /// run](https://docs.aws.amazon.com/step-functions/latest/dg/connect-to-resource.html#connect-sync) pattern to report that the task identified by the `taskToken` failed.
    ///
    /// For an execution with encryption enabled, Step Functions will encrypt the
    /// error and cause fields using the KMS key for the execution role.
    ///
    /// A caller can mark a task as fail without using any KMS permissions in the
    /// execution role if the caller provides a null value for both `error` and
    /// `cause` fields because no data needs to be encrypted.
    pub fn sendTaskFailure(self: *Self, allocator: std.mem.Allocator, input: send_task_failure.SendTaskFailureInput, options: send_task_failure.Options) !send_task_failure.SendTaskFailureOutput {
        return send_task_failure.execute(self, allocator, input, options);
    }

    /// Used by activity workers and Task states using the
    /// [callback](https://docs.aws.amazon.com/step-functions/latest/dg/connect-to-resource.html#connect-wait-token)
    /// pattern, and optionally Task states using the [job
    /// run](https://docs.aws.amazon.com/step-functions/latest/dg/connect-to-resource.html#connect-sync) pattern to report to Step Functions that the task represented by the specified
    /// `taskToken` is still making progress. This action resets the
    /// `Heartbeat` clock. The `Heartbeat` threshold is specified in the state
    /// machine's Amazon States Language definition (`HeartbeatSeconds`). This
    /// action does not in itself
    /// create an event in the execution history. However, if the task times out,
    /// the execution
    /// history contains an `ActivityTimedOut` entry for activities, or a
    /// `TaskTimedOut` entry for tasks using the [job
    /// run](https://docs.aws.amazon.com/step-functions/latest/dg/connect-to-resource.html#connect-sync) or
    /// [callback](https://docs.aws.amazon.com/step-functions/latest/dg/connect-to-resource.html#connect-wait-token)
    /// pattern.
    ///
    /// The `Timeout` of a task, defined in the state machine's Amazon States
    /// Language definition, is
    /// its maximum allowed duration, regardless of the number of SendTaskHeartbeat
    /// requests received. Use `HeartbeatSeconds` to configure the timeout interval
    /// for heartbeats.
    pub fn sendTaskHeartbeat(self: *Self, allocator: std.mem.Allocator, input: send_task_heartbeat.SendTaskHeartbeatInput, options: send_task_heartbeat.Options) !send_task_heartbeat.SendTaskHeartbeatOutput {
        return send_task_heartbeat.execute(self, allocator, input, options);
    }

    /// Used by activity workers, Task states using the
    /// [callback](https://docs.aws.amazon.com/step-functions/latest/dg/connect-to-resource.html#connect-wait-token)
    /// pattern, and optionally Task states using the [job
    /// run](https://docs.aws.amazon.com/step-functions/latest/dg/connect-to-resource.html#connect-sync) pattern to report that the task identified by the `taskToken` completed
    /// successfully.
    pub fn sendTaskSuccess(self: *Self, allocator: std.mem.Allocator, input: send_task_success.SendTaskSuccessInput, options: send_task_success.Options) !send_task_success.SendTaskSuccessOutput {
        return send_task_success.execute(self, allocator, input, options);
    }

    /// Starts a state machine execution.
    ///
    /// A qualified state machine ARN can either refer to a *Distributed Map state*
    /// defined within a state machine, a version ARN, or an alias ARN.
    ///
    /// The following are some examples of qualified and unqualified state machine
    /// ARNs:
    ///
    /// * The following qualified state machine ARN refers to a *Distributed Map
    ///   state* with a label `mapStateLabel` in a state machine named
    ///   `myStateMachine`.
    ///
    /// `arn:partition:states:region:account-id:stateMachine:myStateMachine/mapStateLabel`
    ///
    /// If you provide a qualified state machine ARN that refers to a *Distributed
    /// Map state*, the request fails with `ValidationException`.
    ///
    /// * The following qualified state machine ARN refers to an alias named `PROD`.
    ///
    /// `arn::states:::stateMachine:`
    ///
    /// If you provide a qualified state machine ARN that refers to a version ARN or
    /// an alias ARN, the request starts execution for that version or alias.
    ///
    /// * The following unqualified state machine ARN refers to a state machine
    ///   named `myStateMachine`.
    ///
    /// `arn::states:::stateMachine:`
    ///
    /// If you start an execution with an unqualified state machine ARN, Step
    /// Functions uses the latest revision of the state machine for the execution.
    ///
    /// To start executions of a state machine
    /// [version](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html), call
    /// `StartExecution` and provide the version ARN or the ARN of an
    /// [alias](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html) that points to the version.
    ///
    /// `StartExecution` is idempotent for `STANDARD` workflows. For a
    /// `STANDARD` workflow, if you call `StartExecution` with the same name
    /// and input as a running execution, the call succeeds and return the same
    /// response as the
    /// original request. If the execution is closed or if the input is different,
    /// it returns a
    /// `400 ExecutionAlreadyExists` error. You can reuse names after 90 days.
    ///
    /// `StartExecution` isn't idempotent for `EXPRESS` workflows.
    pub fn startExecution(self: *Self, allocator: std.mem.Allocator, input: start_execution.StartExecutionInput, options: start_execution.Options) !start_execution.StartExecutionOutput {
        return start_execution.execute(self, allocator, input, options);
    }

    /// Starts a Synchronous Express state machine execution. `StartSyncExecution`
    /// is not available for `STANDARD` workflows.
    ///
    /// `StartSyncExecution` will return a `200 OK` response, even if your
    /// execution fails, because the status code in the API response doesn't reflect
    /// function
    /// errors. Error codes are reserved for errors that prevent your execution from
    /// running, such
    /// as permissions errors, limit errors, or issues with your state machine code
    /// and
    /// configuration.
    ///
    /// This API action isn't logged in CloudTrail.
    pub fn startSyncExecution(self: *Self, allocator: std.mem.Allocator, input: start_sync_execution.StartSyncExecutionInput, options: start_sync_execution.Options) !start_sync_execution.StartSyncExecutionOutput {
        return start_sync_execution.execute(self, allocator, input, options);
    }

    /// Stops an execution.
    ///
    /// This API action is not supported by `EXPRESS` state machines.
    ///
    /// For an execution with encryption enabled, Step Functions will encrypt the
    /// error and cause fields using the KMS key for the execution role.
    ///
    /// A caller can stop an execution without using any KMS permissions in the
    /// execution role if the caller provides a null value for both `error` and
    /// `cause` fields because no data needs to be encrypted.
    pub fn stopExecution(self: *Self, allocator: std.mem.Allocator, input: stop_execution.StopExecutionInput, options: stop_execution.Options) !stop_execution.StopExecutionOutput {
        return stop_execution.execute(self, allocator, input, options);
    }

    /// Add a tag to a Step Functions resource.
    ///
    /// An array of key-value pairs. For more information, see [Using
    /// Cost Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the *Amazon Web Services Billing and Cost Management User
    /// Guide*, and [Controlling Access Using IAM
    /// Tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_iam-tags.html).
    ///
    /// Tags may only contain Unicode letters, digits, white space, or these
    /// symbols: `_ . : / = + - @`.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Accepts the definition of a single state and executes it. You can test a
    /// state without creating a state machine or updating an existing state
    /// machine. Using this API, you can test the following:
    ///
    /// * A state's [input and output
    ///   processing](https://docs.aws.amazon.com/step-functions/latest/dg/test-state-isolation.html#test-state-input-output-dataflow) data flow
    ///
    /// * An [Amazon Web Services service
    ///   integration](https://docs.aws.amazon.com/step-functions/latest/dg/connect-to-services.html) request and response
    ///
    /// * An [HTTP
    ///   Task](https://docs.aws.amazon.com/step-functions/latest/dg/call-https-apis.html) request and response
    ///
    /// You can call this API on only one state at a time. The states that you can
    /// test include the following:
    ///
    /// * [All Task
    ///   types](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-task-state.html#task-types) except [Activity](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-activities.html)
    ///
    /// *
    ///   [Pass](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-pass-state.html)
    ///
    /// *
    ///   [Wait](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-wait-state.html)
    ///
    /// *
    ///   [Choice](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-choice-state.html)
    ///
    /// *
    ///   [Succeed](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-succeed-state.html)
    ///
    /// *
    ///   [Fail](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-fail-state.html)
    ///
    /// The `TestState` API assumes an IAM role which must contain the required IAM
    /// permissions for the resources your state is accessing. For information about
    /// the permissions a state might need, see [IAM permissions to test a
    /// state](https://docs.aws.amazon.com/step-functions/latest/dg/test-state-isolation.html#test-state-permissions).
    ///
    /// The `TestState` API can run for up to five minutes. If the execution of a
    /// state exceeds this duration, it fails with the `States.Timeout` error.
    ///
    /// `TestState` only supports the following when a mock is specified: [Activity
    /// tasks](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-activities.html), `.sync` or `.waitForTaskToken`
    /// [service integration
    /// patterns](https://docs.aws.amazon.com/step-functions/latest/dg/connect-to-resource.html), [Parallel](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-parallel-state.html), or [Map](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-map-state.html) states.
    pub fn testState(self: *Self, allocator: std.mem.Allocator, input: test_state.TestStateInput, options: test_state.Options) !test_state.TestStateOutput {
        return test_state.execute(self, allocator, input, options);
    }

    /// Remove a tag from a Step Functions resource
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an in-progress Map Run's configuration to include changes to the
    /// settings that control maximum concurrency and Map Run failure.
    pub fn updateMapRun(self: *Self, allocator: std.mem.Allocator, input: update_map_run.UpdateMapRunInput, options: update_map_run.Options) !update_map_run.UpdateMapRunOutput {
        return update_map_run.execute(self, allocator, input, options);
    }

    /// Updates an existing state machine by modifying its `definition`,
    /// `roleArn`, `loggingConfiguration`, or `EncryptionConfiguration`. Running
    /// executions will continue
    /// to use the previous `definition` and `roleArn`. You must include at
    /// least one of `definition` or `roleArn` or you will receive a
    /// `MissingRequiredParameter` error.
    ///
    /// A qualified state machine ARN refers to a *Distributed Map state* defined
    /// within a state machine. For example, the qualified state machine ARN
    /// `arn:partition:states:region:account-id:stateMachine:stateMachineName/mapStateLabel` refers to a *Distributed Map state* with a label `mapStateLabel` in the state machine named `stateMachineName`.
    ///
    /// A qualified state machine ARN can either refer to a *Distributed Map state*
    /// defined within a state machine, a version ARN, or an alias ARN.
    ///
    /// The following are some examples of qualified and unqualified state machine
    /// ARNs:
    ///
    /// * The following qualified state machine ARN refers to a *Distributed Map
    ///   state* with a label `mapStateLabel` in a state machine named
    ///   `myStateMachine`.
    ///
    /// `arn:partition:states:region:account-id:stateMachine:myStateMachine/mapStateLabel`
    ///
    /// If you provide a qualified state machine ARN that refers to a *Distributed
    /// Map state*, the request fails with `ValidationException`.
    ///
    /// * The following qualified state machine ARN refers to an alias named `PROD`.
    ///
    /// `arn::states:::stateMachine:`
    ///
    /// If you provide a qualified state machine ARN that refers to a version ARN or
    /// an alias ARN, the request starts execution for that version or alias.
    ///
    /// * The following unqualified state machine ARN refers to a state machine
    ///   named `myStateMachine`.
    ///
    /// `arn::states:::stateMachine:`
    ///
    /// After you update your state machine, you can set the `publish` parameter to
    /// `true` in the same action to publish a new
    /// [version](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html). This
    /// way, you can opt-in to strict versioning of your state machine.
    ///
    /// Step Functions assigns monotonically increasing integers for state machine
    /// versions, starting at version number 1.
    ///
    /// All `StartExecution` calls within a few seconds use the updated
    /// `definition` and `roleArn`. Executions started immediately after you
    /// call `UpdateStateMachine` may use the previous state machine
    /// `definition` and `roleArn`.
    pub fn updateStateMachine(self: *Self, allocator: std.mem.Allocator, input: update_state_machine.UpdateStateMachineInput, options: update_state_machine.Options) !update_state_machine.UpdateStateMachineOutput {
        return update_state_machine.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing state machine
    /// [alias](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html) by modifying its `description` or `routingConfiguration`.
    ///
    /// You must specify at least one of the `description` or `routingConfiguration`
    /// parameters to update a state machine alias.
    ///
    /// `UpdateStateMachineAlias` is an idempotent API. Step Functions bases the
    /// idempotency check on the `stateMachineAliasArn`, `description`, and
    /// `routingConfiguration` parameters. Requests with the same parameters return
    /// an
    /// idempotent response.
    ///
    /// This operation is eventually consistent. All StartExecution requests
    /// made within a few seconds use the latest alias configuration. Executions
    /// started immediately
    /// after calling `UpdateStateMachineAlias` may use the previous routing
    /// configuration.
    ///
    /// **Related operations:**
    ///
    /// * CreateStateMachineAlias
    ///
    /// * DescribeStateMachineAlias
    ///
    /// * ListStateMachineAliases
    ///
    /// * DeleteStateMachineAlias
    pub fn updateStateMachineAlias(self: *Self, allocator: std.mem.Allocator, input: update_state_machine_alias.UpdateStateMachineAliasInput, options: update_state_machine_alias.Options) !update_state_machine_alias.UpdateStateMachineAliasOutput {
        return update_state_machine_alias.execute(self, allocator, input, options);
    }

    /// Validates the syntax of a state machine definition specified in [Amazon
    /// States
    /// Language](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html) (ASL), a
    /// JSON-based, structured language.
    ///
    /// You can validate that a state machine definition is correct without creating
    /// a state
    /// machine resource.
    ///
    /// Suggested uses for `ValidateStateMachineDefinition`:
    ///
    /// * Integrate automated checks into your code review or Continuous Integration
    /// (CI) process to check state machine definitions before starting
    /// deployments.
    ///
    /// * Run validation from a Git pre-commit hook to verify the definition before
    /// committing to your source repository.
    ///
    /// Validation will look for problems in your state machine definition and
    /// return a
    /// **result** and a list of **diagnostic
    /// elements**.
    ///
    /// The **result** value will be `OK` when your
    /// workflow definition can be successfully created or updated. Note the result
    /// can be
    /// `OK` even when diagnostic warnings are present in the response. The
    /// **result** value will be `FAIL` when the
    /// workflow definition contains errors that would prevent you from creating or
    /// updating
    /// your state machine.
    ///
    /// The list of
    /// [ValidateStateMachineDefinitionDiagnostic](https://docs.aws.amazon.com/step-functions/latest/apireference/API_ValidateStateMachineDefinitionDiagnostic.html) data elements can contain zero or more **WARNING** and/or **ERROR** elements.
    ///
    /// The **ValidateStateMachineDefinition API** might add
    /// new diagnostics in the future, adjust diagnostic codes, or change the
    /// message
    /// wording. Your automated processes should only rely on the value of the
    /// **result** field value (OK, FAIL). Do **not** rely on the exact order,
    /// count, or
    /// wording of diagnostic messages.
    pub fn validateStateMachineDefinition(self: *Self, allocator: std.mem.Allocator, input: validate_state_machine_definition.ValidateStateMachineDefinitionInput, options: validate_state_machine_definition.Options) !validate_state_machine_definition.ValidateStateMachineDefinitionOutput {
        return validate_state_machine_definition.execute(self, allocator, input, options);
    }

    pub fn getExecutionHistoryPaginator(self: *Self, params: get_execution_history.GetExecutionHistoryInput) paginator.GetExecutionHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listActivitiesPaginator(self: *Self, params: list_activities.ListActivitiesInput) paginator.ListActivitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExecutionsPaginator(self: *Self, params: list_executions.ListExecutionsInput) paginator.ListExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMapRunsPaginator(self: *Self, params: list_map_runs.ListMapRunsInput) paginator.ListMapRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStateMachinesPaginator(self: *Self, params: list_state_machines.ListStateMachinesInput) paginator.ListStateMachinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
