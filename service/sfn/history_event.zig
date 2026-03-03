const ActivityFailedEventDetails = @import("activity_failed_event_details.zig").ActivityFailedEventDetails;
const ActivityScheduledEventDetails = @import("activity_scheduled_event_details.zig").ActivityScheduledEventDetails;
const ActivityScheduleFailedEventDetails = @import("activity_schedule_failed_event_details.zig").ActivityScheduleFailedEventDetails;
const ActivityStartedEventDetails = @import("activity_started_event_details.zig").ActivityStartedEventDetails;
const ActivitySucceededEventDetails = @import("activity_succeeded_event_details.zig").ActivitySucceededEventDetails;
const ActivityTimedOutEventDetails = @import("activity_timed_out_event_details.zig").ActivityTimedOutEventDetails;
const EvaluationFailedEventDetails = @import("evaluation_failed_event_details.zig").EvaluationFailedEventDetails;
const ExecutionAbortedEventDetails = @import("execution_aborted_event_details.zig").ExecutionAbortedEventDetails;
const ExecutionFailedEventDetails = @import("execution_failed_event_details.zig").ExecutionFailedEventDetails;
const ExecutionRedrivenEventDetails = @import("execution_redriven_event_details.zig").ExecutionRedrivenEventDetails;
const ExecutionStartedEventDetails = @import("execution_started_event_details.zig").ExecutionStartedEventDetails;
const ExecutionSucceededEventDetails = @import("execution_succeeded_event_details.zig").ExecutionSucceededEventDetails;
const ExecutionTimedOutEventDetails = @import("execution_timed_out_event_details.zig").ExecutionTimedOutEventDetails;
const LambdaFunctionFailedEventDetails = @import("lambda_function_failed_event_details.zig").LambdaFunctionFailedEventDetails;
const LambdaFunctionScheduledEventDetails = @import("lambda_function_scheduled_event_details.zig").LambdaFunctionScheduledEventDetails;
const LambdaFunctionScheduleFailedEventDetails = @import("lambda_function_schedule_failed_event_details.zig").LambdaFunctionScheduleFailedEventDetails;
const LambdaFunctionStartFailedEventDetails = @import("lambda_function_start_failed_event_details.zig").LambdaFunctionStartFailedEventDetails;
const LambdaFunctionSucceededEventDetails = @import("lambda_function_succeeded_event_details.zig").LambdaFunctionSucceededEventDetails;
const LambdaFunctionTimedOutEventDetails = @import("lambda_function_timed_out_event_details.zig").LambdaFunctionTimedOutEventDetails;
const MapIterationEventDetails = @import("map_iteration_event_details.zig").MapIterationEventDetails;
const MapRunFailedEventDetails = @import("map_run_failed_event_details.zig").MapRunFailedEventDetails;
const MapRunRedrivenEventDetails = @import("map_run_redriven_event_details.zig").MapRunRedrivenEventDetails;
const MapRunStartedEventDetails = @import("map_run_started_event_details.zig").MapRunStartedEventDetails;
const MapStateStartedEventDetails = @import("map_state_started_event_details.zig").MapStateStartedEventDetails;
const StateEnteredEventDetails = @import("state_entered_event_details.zig").StateEnteredEventDetails;
const StateExitedEventDetails = @import("state_exited_event_details.zig").StateExitedEventDetails;
const TaskFailedEventDetails = @import("task_failed_event_details.zig").TaskFailedEventDetails;
const TaskScheduledEventDetails = @import("task_scheduled_event_details.zig").TaskScheduledEventDetails;
const TaskStartedEventDetails = @import("task_started_event_details.zig").TaskStartedEventDetails;
const TaskStartFailedEventDetails = @import("task_start_failed_event_details.zig").TaskStartFailedEventDetails;
const TaskSubmitFailedEventDetails = @import("task_submit_failed_event_details.zig").TaskSubmitFailedEventDetails;
const TaskSubmittedEventDetails = @import("task_submitted_event_details.zig").TaskSubmittedEventDetails;
const TaskSucceededEventDetails = @import("task_succeeded_event_details.zig").TaskSucceededEventDetails;
const TaskTimedOutEventDetails = @import("task_timed_out_event_details.zig").TaskTimedOutEventDetails;
const HistoryEventType = @import("history_event_type.zig").HistoryEventType;

/// Contains details about the events of an execution.
pub const HistoryEvent = struct {
    activity_failed_event_details: ?ActivityFailedEventDetails = null,

    activity_scheduled_event_details: ?ActivityScheduledEventDetails = null,

    /// Contains details about an activity schedule event that failed during an
    /// execution.
    activity_schedule_failed_event_details: ?ActivityScheduleFailedEventDetails = null,

    activity_started_event_details: ?ActivityStartedEventDetails = null,

    activity_succeeded_event_details: ?ActivitySucceededEventDetails = null,

    activity_timed_out_event_details: ?ActivityTimedOutEventDetails = null,

    /// Contains details about an evaluation failure that occurred while processing
    /// a state.
    evaluation_failed_event_details: ?EvaluationFailedEventDetails = null,

    execution_aborted_event_details: ?ExecutionAbortedEventDetails = null,

    execution_failed_event_details: ?ExecutionFailedEventDetails = null,

    /// Contains details about the redrive attempt of an execution.
    execution_redriven_event_details: ?ExecutionRedrivenEventDetails = null,

    execution_started_event_details: ?ExecutionStartedEventDetails = null,

    execution_succeeded_event_details: ?ExecutionSucceededEventDetails = null,

    execution_timed_out_event_details: ?ExecutionTimedOutEventDetails = null,

    /// The id of the event. Events are numbered sequentially, starting at one.
    id: i64 = 0,

    lambda_function_failed_event_details: ?LambdaFunctionFailedEventDetails = null,

    lambda_function_scheduled_event_details: ?LambdaFunctionScheduledEventDetails = null,

    lambda_function_schedule_failed_event_details: ?LambdaFunctionScheduleFailedEventDetails = null,

    /// Contains details about a lambda function that failed to start during an
    /// execution.
    lambda_function_start_failed_event_details: ?LambdaFunctionStartFailedEventDetails = null,

    /// Contains details about a Lambda function that terminated successfully during
    /// an
    /// execution.
    lambda_function_succeeded_event_details: ?LambdaFunctionSucceededEventDetails = null,

    lambda_function_timed_out_event_details: ?LambdaFunctionTimedOutEventDetails = null,

    /// Contains details about an iteration of a Map state that was aborted.
    map_iteration_aborted_event_details: ?MapIterationEventDetails = null,

    /// Contains details about an iteration of a Map state that failed.
    map_iteration_failed_event_details: ?MapIterationEventDetails = null,

    /// Contains details about an iteration of a Map state that was started.
    map_iteration_started_event_details: ?MapIterationEventDetails = null,

    /// Contains details about an iteration of a Map state that succeeded.
    map_iteration_succeeded_event_details: ?MapIterationEventDetails = null,

    /// Contains error and cause details about a Map Run that failed.
    map_run_failed_event_details: ?MapRunFailedEventDetails = null,

    /// Contains details about the redrive attempt of a Map Run.
    map_run_redriven_event_details: ?MapRunRedrivenEventDetails = null,

    /// Contains details, such as `mapRunArn`, and the start date and time of a Map
    /// Run. `mapRunArn` is the Amazon Resource Name (ARN) of the Map Run that was
    /// started.
    map_run_started_event_details: ?MapRunStartedEventDetails = null,

    /// Contains details about Map state that was started.
    map_state_started_event_details: ?MapStateStartedEventDetails = null,

    /// The id of the previous event.
    previous_event_id: i64 = 0,

    state_entered_event_details: ?StateEnteredEventDetails = null,

    state_exited_event_details: ?StateExitedEventDetails = null,

    /// Contains details about the failure of a task.
    task_failed_event_details: ?TaskFailedEventDetails = null,

    /// Contains details about a task that was scheduled.
    task_scheduled_event_details: ?TaskScheduledEventDetails = null,

    /// Contains details about a task that was started.
    task_started_event_details: ?TaskStartedEventDetails = null,

    /// Contains details about a task that failed to start.
    task_start_failed_event_details: ?TaskStartFailedEventDetails = null,

    /// Contains details about a task that where the submit failed.
    task_submit_failed_event_details: ?TaskSubmitFailedEventDetails = null,

    /// Contains details about a submitted task.
    task_submitted_event_details: ?TaskSubmittedEventDetails = null,

    /// Contains details about a task that succeeded.
    task_succeeded_event_details: ?TaskSucceededEventDetails = null,

    /// Contains details about a task that timed out.
    task_timed_out_event_details: ?TaskTimedOutEventDetails = null,

    /// The date and time the event occurred, expressed in seconds and fractional
    /// milliseconds since the Unix epoch, which is defined as January 1, 1970, at
    /// 00:00:00 Coordinated Universal Time (UTC).
    timestamp: i64,

    /// The type of the event.
    @"type": HistoryEventType,

    pub const json_field_names = .{
        .activity_failed_event_details = "activityFailedEventDetails",
        .activity_scheduled_event_details = "activityScheduledEventDetails",
        .activity_schedule_failed_event_details = "activityScheduleFailedEventDetails",
        .activity_started_event_details = "activityStartedEventDetails",
        .activity_succeeded_event_details = "activitySucceededEventDetails",
        .activity_timed_out_event_details = "activityTimedOutEventDetails",
        .evaluation_failed_event_details = "evaluationFailedEventDetails",
        .execution_aborted_event_details = "executionAbortedEventDetails",
        .execution_failed_event_details = "executionFailedEventDetails",
        .execution_redriven_event_details = "executionRedrivenEventDetails",
        .execution_started_event_details = "executionStartedEventDetails",
        .execution_succeeded_event_details = "executionSucceededEventDetails",
        .execution_timed_out_event_details = "executionTimedOutEventDetails",
        .id = "id",
        .lambda_function_failed_event_details = "lambdaFunctionFailedEventDetails",
        .lambda_function_scheduled_event_details = "lambdaFunctionScheduledEventDetails",
        .lambda_function_schedule_failed_event_details = "lambdaFunctionScheduleFailedEventDetails",
        .lambda_function_start_failed_event_details = "lambdaFunctionStartFailedEventDetails",
        .lambda_function_succeeded_event_details = "lambdaFunctionSucceededEventDetails",
        .lambda_function_timed_out_event_details = "lambdaFunctionTimedOutEventDetails",
        .map_iteration_aborted_event_details = "mapIterationAbortedEventDetails",
        .map_iteration_failed_event_details = "mapIterationFailedEventDetails",
        .map_iteration_started_event_details = "mapIterationStartedEventDetails",
        .map_iteration_succeeded_event_details = "mapIterationSucceededEventDetails",
        .map_run_failed_event_details = "mapRunFailedEventDetails",
        .map_run_redriven_event_details = "mapRunRedrivenEventDetails",
        .map_run_started_event_details = "mapRunStartedEventDetails",
        .map_state_started_event_details = "mapStateStartedEventDetails",
        .previous_event_id = "previousEventId",
        .state_entered_event_details = "stateEnteredEventDetails",
        .state_exited_event_details = "stateExitedEventDetails",
        .task_failed_event_details = "taskFailedEventDetails",
        .task_scheduled_event_details = "taskScheduledEventDetails",
        .task_started_event_details = "taskStartedEventDetails",
        .task_start_failed_event_details = "taskStartFailedEventDetails",
        .task_submit_failed_event_details = "taskSubmitFailedEventDetails",
        .task_submitted_event_details = "taskSubmittedEventDetails",
        .task_succeeded_event_details = "taskSucceededEventDetails",
        .task_timed_out_event_details = "taskTimedOutEventDetails",
        .timestamp = "timestamp",
        .@"type" = "type",
    };
};
