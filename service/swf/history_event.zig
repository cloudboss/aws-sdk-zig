const ActivityTaskCanceledEventAttributes = @import("activity_task_canceled_event_attributes.zig").ActivityTaskCanceledEventAttributes;
const ActivityTaskCancelRequestedEventAttributes = @import("activity_task_cancel_requested_event_attributes.zig").ActivityTaskCancelRequestedEventAttributes;
const ActivityTaskCompletedEventAttributes = @import("activity_task_completed_event_attributes.zig").ActivityTaskCompletedEventAttributes;
const ActivityTaskFailedEventAttributes = @import("activity_task_failed_event_attributes.zig").ActivityTaskFailedEventAttributes;
const ActivityTaskScheduledEventAttributes = @import("activity_task_scheduled_event_attributes.zig").ActivityTaskScheduledEventAttributes;
const ActivityTaskStartedEventAttributes = @import("activity_task_started_event_attributes.zig").ActivityTaskStartedEventAttributes;
const ActivityTaskTimedOutEventAttributes = @import("activity_task_timed_out_event_attributes.zig").ActivityTaskTimedOutEventAttributes;
const CancelTimerFailedEventAttributes = @import("cancel_timer_failed_event_attributes.zig").CancelTimerFailedEventAttributes;
const CancelWorkflowExecutionFailedEventAttributes = @import("cancel_workflow_execution_failed_event_attributes.zig").CancelWorkflowExecutionFailedEventAttributes;
const ChildWorkflowExecutionCanceledEventAttributes = @import("child_workflow_execution_canceled_event_attributes.zig").ChildWorkflowExecutionCanceledEventAttributes;
const ChildWorkflowExecutionCompletedEventAttributes = @import("child_workflow_execution_completed_event_attributes.zig").ChildWorkflowExecutionCompletedEventAttributes;
const ChildWorkflowExecutionFailedEventAttributes = @import("child_workflow_execution_failed_event_attributes.zig").ChildWorkflowExecutionFailedEventAttributes;
const ChildWorkflowExecutionStartedEventAttributes = @import("child_workflow_execution_started_event_attributes.zig").ChildWorkflowExecutionStartedEventAttributes;
const ChildWorkflowExecutionTerminatedEventAttributes = @import("child_workflow_execution_terminated_event_attributes.zig").ChildWorkflowExecutionTerminatedEventAttributes;
const ChildWorkflowExecutionTimedOutEventAttributes = @import("child_workflow_execution_timed_out_event_attributes.zig").ChildWorkflowExecutionTimedOutEventAttributes;
const CompleteWorkflowExecutionFailedEventAttributes = @import("complete_workflow_execution_failed_event_attributes.zig").CompleteWorkflowExecutionFailedEventAttributes;
const ContinueAsNewWorkflowExecutionFailedEventAttributes = @import("continue_as_new_workflow_execution_failed_event_attributes.zig").ContinueAsNewWorkflowExecutionFailedEventAttributes;
const DecisionTaskCompletedEventAttributes = @import("decision_task_completed_event_attributes.zig").DecisionTaskCompletedEventAttributes;
const DecisionTaskScheduledEventAttributes = @import("decision_task_scheduled_event_attributes.zig").DecisionTaskScheduledEventAttributes;
const DecisionTaskStartedEventAttributes = @import("decision_task_started_event_attributes.zig").DecisionTaskStartedEventAttributes;
const DecisionTaskTimedOutEventAttributes = @import("decision_task_timed_out_event_attributes.zig").DecisionTaskTimedOutEventAttributes;
const EventType = @import("event_type.zig").EventType;
const ExternalWorkflowExecutionCancelRequestedEventAttributes = @import("external_workflow_execution_cancel_requested_event_attributes.zig").ExternalWorkflowExecutionCancelRequestedEventAttributes;
const ExternalWorkflowExecutionSignaledEventAttributes = @import("external_workflow_execution_signaled_event_attributes.zig").ExternalWorkflowExecutionSignaledEventAttributes;
const FailWorkflowExecutionFailedEventAttributes = @import("fail_workflow_execution_failed_event_attributes.zig").FailWorkflowExecutionFailedEventAttributes;
const LambdaFunctionCompletedEventAttributes = @import("lambda_function_completed_event_attributes.zig").LambdaFunctionCompletedEventAttributes;
const LambdaFunctionFailedEventAttributes = @import("lambda_function_failed_event_attributes.zig").LambdaFunctionFailedEventAttributes;
const LambdaFunctionScheduledEventAttributes = @import("lambda_function_scheduled_event_attributes.zig").LambdaFunctionScheduledEventAttributes;
const LambdaFunctionStartedEventAttributes = @import("lambda_function_started_event_attributes.zig").LambdaFunctionStartedEventAttributes;
const LambdaFunctionTimedOutEventAttributes = @import("lambda_function_timed_out_event_attributes.zig").LambdaFunctionTimedOutEventAttributes;
const MarkerRecordedEventAttributes = @import("marker_recorded_event_attributes.zig").MarkerRecordedEventAttributes;
const RecordMarkerFailedEventAttributes = @import("record_marker_failed_event_attributes.zig").RecordMarkerFailedEventAttributes;
const RequestCancelActivityTaskFailedEventAttributes = @import("request_cancel_activity_task_failed_event_attributes.zig").RequestCancelActivityTaskFailedEventAttributes;
const RequestCancelExternalWorkflowExecutionFailedEventAttributes = @import("request_cancel_external_workflow_execution_failed_event_attributes.zig").RequestCancelExternalWorkflowExecutionFailedEventAttributes;
const RequestCancelExternalWorkflowExecutionInitiatedEventAttributes = @import("request_cancel_external_workflow_execution_initiated_event_attributes.zig").RequestCancelExternalWorkflowExecutionInitiatedEventAttributes;
const ScheduleActivityTaskFailedEventAttributes = @import("schedule_activity_task_failed_event_attributes.zig").ScheduleActivityTaskFailedEventAttributes;
const ScheduleLambdaFunctionFailedEventAttributes = @import("schedule_lambda_function_failed_event_attributes.zig").ScheduleLambdaFunctionFailedEventAttributes;
const SignalExternalWorkflowExecutionFailedEventAttributes = @import("signal_external_workflow_execution_failed_event_attributes.zig").SignalExternalWorkflowExecutionFailedEventAttributes;
const SignalExternalWorkflowExecutionInitiatedEventAttributes = @import("signal_external_workflow_execution_initiated_event_attributes.zig").SignalExternalWorkflowExecutionInitiatedEventAttributes;
const StartChildWorkflowExecutionFailedEventAttributes = @import("start_child_workflow_execution_failed_event_attributes.zig").StartChildWorkflowExecutionFailedEventAttributes;
const StartChildWorkflowExecutionInitiatedEventAttributes = @import("start_child_workflow_execution_initiated_event_attributes.zig").StartChildWorkflowExecutionInitiatedEventAttributes;
const StartLambdaFunctionFailedEventAttributes = @import("start_lambda_function_failed_event_attributes.zig").StartLambdaFunctionFailedEventAttributes;
const StartTimerFailedEventAttributes = @import("start_timer_failed_event_attributes.zig").StartTimerFailedEventAttributes;
const TimerCanceledEventAttributes = @import("timer_canceled_event_attributes.zig").TimerCanceledEventAttributes;
const TimerFiredEventAttributes = @import("timer_fired_event_attributes.zig").TimerFiredEventAttributes;
const TimerStartedEventAttributes = @import("timer_started_event_attributes.zig").TimerStartedEventAttributes;
const WorkflowExecutionCanceledEventAttributes = @import("workflow_execution_canceled_event_attributes.zig").WorkflowExecutionCanceledEventAttributes;
const WorkflowExecutionCancelRequestedEventAttributes = @import("workflow_execution_cancel_requested_event_attributes.zig").WorkflowExecutionCancelRequestedEventAttributes;
const WorkflowExecutionCompletedEventAttributes = @import("workflow_execution_completed_event_attributes.zig").WorkflowExecutionCompletedEventAttributes;
const WorkflowExecutionContinuedAsNewEventAttributes = @import("workflow_execution_continued_as_new_event_attributes.zig").WorkflowExecutionContinuedAsNewEventAttributes;
const WorkflowExecutionFailedEventAttributes = @import("workflow_execution_failed_event_attributes.zig").WorkflowExecutionFailedEventAttributes;
const WorkflowExecutionSignaledEventAttributes = @import("workflow_execution_signaled_event_attributes.zig").WorkflowExecutionSignaledEventAttributes;
const WorkflowExecutionStartedEventAttributes = @import("workflow_execution_started_event_attributes.zig").WorkflowExecutionStartedEventAttributes;
const WorkflowExecutionTerminatedEventAttributes = @import("workflow_execution_terminated_event_attributes.zig").WorkflowExecutionTerminatedEventAttributes;
const WorkflowExecutionTimedOutEventAttributes = @import("workflow_execution_timed_out_event_attributes.zig").WorkflowExecutionTimedOutEventAttributes;

/// Event within a workflow execution. A history event can be one of these
/// types:
///
/// * `ActivityTaskCancelRequested` – A `RequestCancelActivityTask` decision was
///   received by the
/// system.
///
/// * `ActivityTaskCanceled` – The activity task was successfully canceled.
///
/// * `ActivityTaskCompleted` – An activity worker successfully completed an
///   activity task by calling
/// RespondActivityTaskCompleted.
///
/// * `ActivityTaskFailed` – An activity worker failed an activity task by
///   calling
/// RespondActivityTaskFailed.
///
/// * `ActivityTaskScheduled` – An activity task was scheduled for execution.
///
/// * `ActivityTaskStarted` – The scheduled activity task was dispatched to a
///   worker.
///
/// * `ActivityTaskTimedOut` – The activity task timed out.
///
/// * `CancelTimerFailed` – Failed to process CancelTimer decision. This happens
///   when the decision isn't
/// configured properly, for example no timer exists with the specified timer
/// Id.
///
/// * `CancelWorkflowExecutionFailed` – A request to cancel a workflow execution
///   failed.
///
/// * `ChildWorkflowExecutionCanceled` – A child workflow execution, started by
///   this workflow execution, was
/// canceled and closed.
///
/// * `ChildWorkflowExecutionCompleted` – A child workflow execution, started by
///   this workflow execution,
/// completed successfully and was closed.
///
/// * `ChildWorkflowExecutionFailed` – A child workflow execution,
/// started by this workflow execution, failed to complete successfully and was
/// closed.
///
/// * `ChildWorkflowExecutionStarted` – A child workflow execution was
///   successfully started.
///
/// * `ChildWorkflowExecutionTerminated` – A child workflow execution, started
///   by this workflow execution, was
/// terminated.
///
/// * `ChildWorkflowExecutionTimedOut` – A child workflow execution, started by
///   this workflow execution, timed
/// out and was closed.
///
/// * `CompleteWorkflowExecutionFailed` – The workflow execution failed to
///   complete.
///
/// * `ContinueAsNewWorkflowExecutionFailed` – The workflow execution failed to
///   complete after being continued
/// as a new workflow execution.
///
/// * `DecisionTaskCompleted` – The decider successfully completed a decision
///   task by calling
/// RespondDecisionTaskCompleted.
///
/// * `DecisionTaskScheduled` – A decision task was scheduled for the workflow
///   execution.
///
/// * `DecisionTaskStarted` – The decision task was dispatched to a decider.
///
/// * `DecisionTaskTimedOut` – The decision task timed out.
///
/// * `ExternalWorkflowExecutionCancelRequested` – Request to cancel an external
///   workflow execution was
/// successfully delivered to the target execution.
///
/// * `ExternalWorkflowExecutionSignaled` – A signal, requested by this workflow
///   execution, was successfully
/// delivered to the target external workflow execution.
///
/// * `FailWorkflowExecutionFailed` – A request to mark a workflow execution as
///   failed, itself failed.
///
/// * `MarkerRecorded` – A marker was recorded in the workflow history as the
///   result of a
/// `RecordMarker` decision.
///
/// * `RecordMarkerFailed` – A `RecordMarker` decision was returned as failed.
///
/// * `RequestCancelActivityTaskFailed` – Failed to process
///   RequestCancelActivityTask decision. This happens
/// when the decision isn't configured properly.
///
/// * `RequestCancelExternalWorkflowExecutionFailed` – Request to cancel an
///   external workflow execution
/// failed.
///
/// * `RequestCancelExternalWorkflowExecutionInitiated` – A request was made to
///   request the cancellation of an
/// external workflow execution.
///
/// * `ScheduleActivityTaskFailed` – Failed to process ScheduleActivityTask
///   decision. This happens when the
/// decision isn't configured properly, for example the activity type specified
/// isn't registered.
///
/// * `SignalExternalWorkflowExecutionFailed` – The request to signal an
///   external workflow execution
/// failed.
///
/// * `SignalExternalWorkflowExecutionInitiated` – A request to signal an
///   external workflow was made.
///
/// * `StartActivityTaskFailed` – A scheduled activity task failed to start.
///
/// * `StartChildWorkflowExecutionFailed` – Failed to process
///   StartChildWorkflowExecution decision. This happens
/// when the decision isn't configured properly, for example the workflow type
/// specified isn't registered.
///
/// * `StartChildWorkflowExecutionInitiated` – A request was made to start a
///   child workflow execution.
///
/// * `StartTimerFailed` – Failed to process StartTimer decision. This happens
///   when the decision isn't
/// configured properly, for example a timer already exists with the specified
/// timer Id.
///
/// * `TimerCanceled` – A timer, previously started for this workflow execution,
///   was successfully canceled.
///
/// * `TimerFired` – A timer, previously started for this workflow execution,
///   fired.
///
/// * `TimerStarted` – A timer was started for the workflow execution due to a
///   `StartTimer`
/// decision.
///
/// * `WorkflowExecutionCancelRequested` – A request to cancel this workflow
///   execution was made.
///
/// * `WorkflowExecutionCanceled` – The workflow execution was successfully
///   canceled and closed.
///
/// * `WorkflowExecutionCompleted` – The workflow execution was closed due to
///   successful completion.
///
/// * `WorkflowExecutionContinuedAsNew` – The workflow execution was closed and
///   a new execution of the same type
/// was created with the same workflowId.
///
/// * `WorkflowExecutionFailed` – The workflow execution closed due to a
///   failure.
///
/// * `WorkflowExecutionSignaled` – An external signal was received for the
///   workflow execution.
///
/// * `WorkflowExecutionStarted` – The workflow execution was started.
///
/// * `WorkflowExecutionTerminated` – The workflow execution was terminated.
///
/// * `WorkflowExecutionTimedOut` – The workflow execution was closed because a
///   time out was exceeded.
pub const HistoryEvent = struct {
    /// If the event is of type `ActivityTaskCanceled` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    activity_task_canceled_event_attributes: ?ActivityTaskCanceledEventAttributes = null,

    /// If the event is of type `ActivityTaskcancelRequested` then this member is
    /// set and provides detailed
    /// information about the event. It isn't set for other event types.
    activity_task_cancel_requested_event_attributes: ?ActivityTaskCancelRequestedEventAttributes = null,

    /// If the event is of type `ActivityTaskCompleted` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    activity_task_completed_event_attributes: ?ActivityTaskCompletedEventAttributes = null,

    /// If the event is of type `ActivityTaskFailed` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    activity_task_failed_event_attributes: ?ActivityTaskFailedEventAttributes = null,

    /// If the event is of type `ActivityTaskScheduled` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    activity_task_scheduled_event_attributes: ?ActivityTaskScheduledEventAttributes = null,

    /// If the event is of type `ActivityTaskStarted` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    activity_task_started_event_attributes: ?ActivityTaskStartedEventAttributes = null,

    /// If the event is of type `ActivityTaskTimedOut` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    activity_task_timed_out_event_attributes: ?ActivityTaskTimedOutEventAttributes = null,

    /// If the event is of type `CancelTimerFailed` then this member is set and
    /// provides detailed information
    /// about the event. It isn't set for other event types.
    cancel_timer_failed_event_attributes: ?CancelTimerFailedEventAttributes = null,

    /// If the event is of type `CancelWorkflowExecutionFailed` then this member is
    /// set and provides detailed
    /// information about the event. It isn't set for other event types.
    cancel_workflow_execution_failed_event_attributes: ?CancelWorkflowExecutionFailedEventAttributes = null,

    /// If the event is of type `ChildWorkflowExecutionCanceled` then this member is
    /// set and provides
    /// detailed information about the event. It isn't set for other event types.
    child_workflow_execution_canceled_event_attributes: ?ChildWorkflowExecutionCanceledEventAttributes = null,

    /// If the event is of type `ChildWorkflowExecutionCompleted` then this member
    /// is set and provides
    /// detailed information about the event. It isn't set for other event types.
    child_workflow_execution_completed_event_attributes: ?ChildWorkflowExecutionCompletedEventAttributes = null,

    /// If the event is of type `ChildWorkflowExecutionFailed` then this member is
    /// set and provides detailed
    /// information about the event. It isn't set for other event types.
    child_workflow_execution_failed_event_attributes: ?ChildWorkflowExecutionFailedEventAttributes = null,

    /// If the event is of type `ChildWorkflowExecutionStarted` then this member is
    /// set and provides detailed
    /// information about the event. It isn't set for other event types.
    child_workflow_execution_started_event_attributes: ?ChildWorkflowExecutionStartedEventAttributes = null,

    /// If the event is of type `ChildWorkflowExecutionTerminated` then this member
    /// is set and provides
    /// detailed information about the event. It isn't set for other event types.
    child_workflow_execution_terminated_event_attributes: ?ChildWorkflowExecutionTerminatedEventAttributes = null,

    /// If the event is of type `ChildWorkflowExecutionTimedOut` then this member is
    /// set and provides
    /// detailed information about the event. It isn't set for other event types.
    child_workflow_execution_timed_out_event_attributes: ?ChildWorkflowExecutionTimedOutEventAttributes = null,

    /// If the event is of type `CompleteWorkflowExecutionFailed` then this member
    /// is set and provides
    /// detailed information about the event. It isn't set for other event types.
    complete_workflow_execution_failed_event_attributes: ?CompleteWorkflowExecutionFailedEventAttributes = null,

    /// If the event is of type `ContinueAsNewWorkflowExecutionFailed` then this
    /// member is set and provides
    /// detailed information about the event. It isn't set for other event types.
    continue_as_new_workflow_execution_failed_event_attributes: ?ContinueAsNewWorkflowExecutionFailedEventAttributes = null,

    /// If the event is of type `DecisionTaskCompleted` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    decision_task_completed_event_attributes: ?DecisionTaskCompletedEventAttributes = null,

    /// If the event is of type `DecisionTaskScheduled` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    decision_task_scheduled_event_attributes: ?DecisionTaskScheduledEventAttributes = null,

    /// If the event is of type `DecisionTaskStarted` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    decision_task_started_event_attributes: ?DecisionTaskStartedEventAttributes = null,

    /// If the event is of type `DecisionTaskTimedOut` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    decision_task_timed_out_event_attributes: ?DecisionTaskTimedOutEventAttributes = null,

    /// The system generated ID of the event. This ID uniquely identifies the event
    /// with in the workflow execution history.
    event_id: i64 = 0,

    /// The date and time when the event occurred.
    event_timestamp: i64,

    /// The type of the history event.
    event_type: EventType,

    /// If the event is of type `ExternalWorkflowExecutionCancelRequested` then this
    /// member is set and
    /// provides detailed information about the event. It isn't set for other event
    /// types.
    external_workflow_execution_cancel_requested_event_attributes: ?ExternalWorkflowExecutionCancelRequestedEventAttributes = null,

    /// If the event is of type `ExternalWorkflowExecutionSignaled` then this member
    /// is set and provides
    /// detailed information about the event. It isn't set for other event types.
    external_workflow_execution_signaled_event_attributes: ?ExternalWorkflowExecutionSignaledEventAttributes = null,

    /// If the event is of type `FailWorkflowExecutionFailed` then this member is
    /// set and provides detailed
    /// information about the event. It isn't set for other event types.
    fail_workflow_execution_failed_event_attributes: ?FailWorkflowExecutionFailedEventAttributes = null,

    /// Provides the details of the `LambdaFunctionCompleted` event. It isn't set
    /// for other event types.
    lambda_function_completed_event_attributes: ?LambdaFunctionCompletedEventAttributes = null,

    /// Provides the details of the `LambdaFunctionFailed` event. It isn't set for
    /// other event types.
    lambda_function_failed_event_attributes: ?LambdaFunctionFailedEventAttributes = null,

    /// Provides the details of the `LambdaFunctionScheduled` event. It isn't set
    /// for other event types.
    lambda_function_scheduled_event_attributes: ?LambdaFunctionScheduledEventAttributes = null,

    /// Provides the details of the `LambdaFunctionStarted` event. It isn't set for
    /// other event types.
    lambda_function_started_event_attributes: ?LambdaFunctionStartedEventAttributes = null,

    /// Provides the details of the `LambdaFunctionTimedOut` event. It isn't set for
    /// other event types.
    lambda_function_timed_out_event_attributes: ?LambdaFunctionTimedOutEventAttributes = null,

    /// If the event is of type `MarkerRecorded` then this member is set and
    /// provides detailed information
    /// about the event. It isn't set for other event types.
    marker_recorded_event_attributes: ?MarkerRecordedEventAttributes = null,

    /// If the event is of type `DecisionTaskFailed` then this member is set and
    /// provides detailed
    /// information about the event. It isn't set for other event types.
    record_marker_failed_event_attributes: ?RecordMarkerFailedEventAttributes = null,

    /// If the event is of type `RequestCancelActivityTaskFailed` then this member
    /// is set and provides
    /// detailed information about the event. It isn't set for other event types.
    request_cancel_activity_task_failed_event_attributes: ?RequestCancelActivityTaskFailedEventAttributes = null,

    /// If the event is of type `RequestCancelExternalWorkflowExecutionFailed` then
    /// this member is set and
    /// provides detailed information about the event. It isn't set for other event
    /// types.
    request_cancel_external_workflow_execution_failed_event_attributes: ?RequestCancelExternalWorkflowExecutionFailedEventAttributes = null,

    /// If the event is of type `RequestCancelExternalWorkflowExecutionInitiated`
    /// then this member is set and
    /// provides detailed information about the event. It isn't set for other event
    /// types.
    request_cancel_external_workflow_execution_initiated_event_attributes: ?RequestCancelExternalWorkflowExecutionInitiatedEventAttributes = null,

    /// If the event is of type `ScheduleActivityTaskFailed` then this member is set
    /// and provides detailed
    /// information about the event. It isn't set for other event types.
    schedule_activity_task_failed_event_attributes: ?ScheduleActivityTaskFailedEventAttributes = null,

    /// Provides the details of the `ScheduleLambdaFunctionFailed` event. It isn't
    /// set for other event types.
    schedule_lambda_function_failed_event_attributes: ?ScheduleLambdaFunctionFailedEventAttributes = null,

    /// If the event is of type `SignalExternalWorkflowExecutionFailed` then this
    /// member is set and provides
    /// detailed information about the event. It isn't set for other event types.
    signal_external_workflow_execution_failed_event_attributes: ?SignalExternalWorkflowExecutionFailedEventAttributes = null,

    /// If the event is of type `SignalExternalWorkflowExecutionInitiated` then this
    /// member is set and
    /// provides detailed information about the event. It isn't set for other event
    /// types.
    signal_external_workflow_execution_initiated_event_attributes: ?SignalExternalWorkflowExecutionInitiatedEventAttributes = null,

    /// If the event is of type `StartChildWorkflowExecutionFailed` then this member
    /// is set and provides
    /// detailed information about the event. It isn't set for other event types.
    start_child_workflow_execution_failed_event_attributes: ?StartChildWorkflowExecutionFailedEventAttributes = null,

    /// If the event is of type `StartChildWorkflowExecutionInitiated` then this
    /// member is set and provides
    /// detailed information about the event. It isn't set for other event types.
    start_child_workflow_execution_initiated_event_attributes: ?StartChildWorkflowExecutionInitiatedEventAttributes = null,

    /// Provides the details of the `StartLambdaFunctionFailed` event. It isn't set
    /// for other event types.
    start_lambda_function_failed_event_attributes: ?StartLambdaFunctionFailedEventAttributes = null,

    /// If the event is of type `StartTimerFailed` then this member is set and
    /// provides detailed information
    /// about the event. It isn't set for other event types.
    start_timer_failed_event_attributes: ?StartTimerFailedEventAttributes = null,

    /// If the event is of type `TimerCanceled` then this member is set and provides
    /// detailed information
    /// about the event. It isn't set for other event types.
    timer_canceled_event_attributes: ?TimerCanceledEventAttributes = null,

    /// If the event is of type `TimerFired` then this member is set and provides
    /// detailed information about
    /// the event. It isn't set for other event types.
    timer_fired_event_attributes: ?TimerFiredEventAttributes = null,

    /// If the event is of type `TimerStarted` then this member is set and provides
    /// detailed information
    /// about the event. It isn't set for other event types.
    timer_started_event_attributes: ?TimerStartedEventAttributes = null,

    /// If the event is of type `WorkflowExecutionCanceled` then this member is set
    /// and provides detailed
    /// information about the event. It isn't set for other event types.
    workflow_execution_canceled_event_attributes: ?WorkflowExecutionCanceledEventAttributes = null,

    /// If the event is of type `WorkflowExecutionCancelRequested` then this member
    /// is set and provides
    /// detailed information about the event. It isn't set for other event types.
    workflow_execution_cancel_requested_event_attributes: ?WorkflowExecutionCancelRequestedEventAttributes = null,

    /// If the event is of type `WorkflowExecutionCompleted` then this member is set
    /// and provides detailed
    /// information about the event. It isn't set for other event types.
    workflow_execution_completed_event_attributes: ?WorkflowExecutionCompletedEventAttributes = null,

    /// If the event is of type `WorkflowExecutionContinuedAsNew` then this member
    /// is set and provides
    /// detailed information about the event. It isn't set for other event types.
    workflow_execution_continued_as_new_event_attributes: ?WorkflowExecutionContinuedAsNewEventAttributes = null,

    /// If the event is of type `WorkflowExecutionFailed` then this member is set
    /// and provides detailed
    /// information about the event. It isn't set for other event types.
    workflow_execution_failed_event_attributes: ?WorkflowExecutionFailedEventAttributes = null,

    /// If the event is of type `WorkflowExecutionSignaled` then this member is set
    /// and provides detailed
    /// information about the event. It isn't set for other event types.
    workflow_execution_signaled_event_attributes: ?WorkflowExecutionSignaledEventAttributes = null,

    /// If the event is of type `WorkflowExecutionStarted` then this member is set
    /// and provides detailed
    /// information about the event. It isn't set for other event types.
    workflow_execution_started_event_attributes: ?WorkflowExecutionStartedEventAttributes = null,

    /// If the event is of type `WorkflowExecutionTerminated` then this member is
    /// set and provides detailed
    /// information about the event. It isn't set for other event types.
    workflow_execution_terminated_event_attributes: ?WorkflowExecutionTerminatedEventAttributes = null,

    /// If the event is of type `WorkflowExecutionTimedOut` then this member is set
    /// and provides detailed
    /// information about the event. It isn't set for other event types.
    workflow_execution_timed_out_event_attributes: ?WorkflowExecutionTimedOutEventAttributes = null,

    pub const json_field_names = .{
        .activity_task_canceled_event_attributes = "activityTaskCanceledEventAttributes",
        .activity_task_cancel_requested_event_attributes = "activityTaskCancelRequestedEventAttributes",
        .activity_task_completed_event_attributes = "activityTaskCompletedEventAttributes",
        .activity_task_failed_event_attributes = "activityTaskFailedEventAttributes",
        .activity_task_scheduled_event_attributes = "activityTaskScheduledEventAttributes",
        .activity_task_started_event_attributes = "activityTaskStartedEventAttributes",
        .activity_task_timed_out_event_attributes = "activityTaskTimedOutEventAttributes",
        .cancel_timer_failed_event_attributes = "cancelTimerFailedEventAttributes",
        .cancel_workflow_execution_failed_event_attributes = "cancelWorkflowExecutionFailedEventAttributes",
        .child_workflow_execution_canceled_event_attributes = "childWorkflowExecutionCanceledEventAttributes",
        .child_workflow_execution_completed_event_attributes = "childWorkflowExecutionCompletedEventAttributes",
        .child_workflow_execution_failed_event_attributes = "childWorkflowExecutionFailedEventAttributes",
        .child_workflow_execution_started_event_attributes = "childWorkflowExecutionStartedEventAttributes",
        .child_workflow_execution_terminated_event_attributes = "childWorkflowExecutionTerminatedEventAttributes",
        .child_workflow_execution_timed_out_event_attributes = "childWorkflowExecutionTimedOutEventAttributes",
        .complete_workflow_execution_failed_event_attributes = "completeWorkflowExecutionFailedEventAttributes",
        .continue_as_new_workflow_execution_failed_event_attributes = "continueAsNewWorkflowExecutionFailedEventAttributes",
        .decision_task_completed_event_attributes = "decisionTaskCompletedEventAttributes",
        .decision_task_scheduled_event_attributes = "decisionTaskScheduledEventAttributes",
        .decision_task_started_event_attributes = "decisionTaskStartedEventAttributes",
        .decision_task_timed_out_event_attributes = "decisionTaskTimedOutEventAttributes",
        .event_id = "eventId",
        .event_timestamp = "eventTimestamp",
        .event_type = "eventType",
        .external_workflow_execution_cancel_requested_event_attributes = "externalWorkflowExecutionCancelRequestedEventAttributes",
        .external_workflow_execution_signaled_event_attributes = "externalWorkflowExecutionSignaledEventAttributes",
        .fail_workflow_execution_failed_event_attributes = "failWorkflowExecutionFailedEventAttributes",
        .lambda_function_completed_event_attributes = "lambdaFunctionCompletedEventAttributes",
        .lambda_function_failed_event_attributes = "lambdaFunctionFailedEventAttributes",
        .lambda_function_scheduled_event_attributes = "lambdaFunctionScheduledEventAttributes",
        .lambda_function_started_event_attributes = "lambdaFunctionStartedEventAttributes",
        .lambda_function_timed_out_event_attributes = "lambdaFunctionTimedOutEventAttributes",
        .marker_recorded_event_attributes = "markerRecordedEventAttributes",
        .record_marker_failed_event_attributes = "recordMarkerFailedEventAttributes",
        .request_cancel_activity_task_failed_event_attributes = "requestCancelActivityTaskFailedEventAttributes",
        .request_cancel_external_workflow_execution_failed_event_attributes = "requestCancelExternalWorkflowExecutionFailedEventAttributes",
        .request_cancel_external_workflow_execution_initiated_event_attributes = "requestCancelExternalWorkflowExecutionInitiatedEventAttributes",
        .schedule_activity_task_failed_event_attributes = "scheduleActivityTaskFailedEventAttributes",
        .schedule_lambda_function_failed_event_attributes = "scheduleLambdaFunctionFailedEventAttributes",
        .signal_external_workflow_execution_failed_event_attributes = "signalExternalWorkflowExecutionFailedEventAttributes",
        .signal_external_workflow_execution_initiated_event_attributes = "signalExternalWorkflowExecutionInitiatedEventAttributes",
        .start_child_workflow_execution_failed_event_attributes = "startChildWorkflowExecutionFailedEventAttributes",
        .start_child_workflow_execution_initiated_event_attributes = "startChildWorkflowExecutionInitiatedEventAttributes",
        .start_lambda_function_failed_event_attributes = "startLambdaFunctionFailedEventAttributes",
        .start_timer_failed_event_attributes = "startTimerFailedEventAttributes",
        .timer_canceled_event_attributes = "timerCanceledEventAttributes",
        .timer_fired_event_attributes = "timerFiredEventAttributes",
        .timer_started_event_attributes = "timerStartedEventAttributes",
        .workflow_execution_canceled_event_attributes = "workflowExecutionCanceledEventAttributes",
        .workflow_execution_cancel_requested_event_attributes = "workflowExecutionCancelRequestedEventAttributes",
        .workflow_execution_completed_event_attributes = "workflowExecutionCompletedEventAttributes",
        .workflow_execution_continued_as_new_event_attributes = "workflowExecutionContinuedAsNewEventAttributes",
        .workflow_execution_failed_event_attributes = "workflowExecutionFailedEventAttributes",
        .workflow_execution_signaled_event_attributes = "workflowExecutionSignaledEventAttributes",
        .workflow_execution_started_event_attributes = "workflowExecutionStartedEventAttributes",
        .workflow_execution_terminated_event_attributes = "workflowExecutionTerminatedEventAttributes",
        .workflow_execution_timed_out_event_attributes = "workflowExecutionTimedOutEventAttributes",
    };
};
