const CallbackFailedDetails = @import("callback_failed_details.zig").CallbackFailedDetails;
const CallbackStartedDetails = @import("callback_started_details.zig").CallbackStartedDetails;
const CallbackSucceededDetails = @import("callback_succeeded_details.zig").CallbackSucceededDetails;
const CallbackTimedOutDetails = @import("callback_timed_out_details.zig").CallbackTimedOutDetails;
const ChainedInvokeFailedDetails = @import("chained_invoke_failed_details.zig").ChainedInvokeFailedDetails;
const ChainedInvokeStartedDetails = @import("chained_invoke_started_details.zig").ChainedInvokeStartedDetails;
const ChainedInvokeStoppedDetails = @import("chained_invoke_stopped_details.zig").ChainedInvokeStoppedDetails;
const ChainedInvokeSucceededDetails = @import("chained_invoke_succeeded_details.zig").ChainedInvokeSucceededDetails;
const ChainedInvokeTimedOutDetails = @import("chained_invoke_timed_out_details.zig").ChainedInvokeTimedOutDetails;
const ContextFailedDetails = @import("context_failed_details.zig").ContextFailedDetails;
const ContextStartedDetails = @import("context_started_details.zig").ContextStartedDetails;
const ContextSucceededDetails = @import("context_succeeded_details.zig").ContextSucceededDetails;
const EventType = @import("event_type.zig").EventType;
const ExecutionFailedDetails = @import("execution_failed_details.zig").ExecutionFailedDetails;
const ExecutionStartedDetails = @import("execution_started_details.zig").ExecutionStartedDetails;
const ExecutionStoppedDetails = @import("execution_stopped_details.zig").ExecutionStoppedDetails;
const ExecutionSucceededDetails = @import("execution_succeeded_details.zig").ExecutionSucceededDetails;
const ExecutionTimedOutDetails = @import("execution_timed_out_details.zig").ExecutionTimedOutDetails;
const InvocationCompletedDetails = @import("invocation_completed_details.zig").InvocationCompletedDetails;
const StepFailedDetails = @import("step_failed_details.zig").StepFailedDetails;
const StepStartedDetails = @import("step_started_details.zig").StepStartedDetails;
const StepSucceededDetails = @import("step_succeeded_details.zig").StepSucceededDetails;
const WaitCancelledDetails = @import("wait_cancelled_details.zig").WaitCancelledDetails;
const WaitStartedDetails = @import("wait_started_details.zig").WaitStartedDetails;
const WaitSucceededDetails = @import("wait_succeeded_details.zig").WaitSucceededDetails;

/// An event that occurred during the execution of a durable function.
pub const Event = struct {
    callback_failed_details: ?CallbackFailedDetails,

    callback_started_details: ?CallbackStartedDetails,

    callback_succeeded_details: ?CallbackSucceededDetails,

    callback_timed_out_details: ?CallbackTimedOutDetails,

    chained_invoke_failed_details: ?ChainedInvokeFailedDetails,

    chained_invoke_started_details: ?ChainedInvokeStartedDetails,

    /// Details about a chained invocation that was stopped.
    chained_invoke_stopped_details: ?ChainedInvokeStoppedDetails,

    /// Details about a chained invocation that succeeded.
    chained_invoke_succeeded_details: ?ChainedInvokeSucceededDetails,

    /// Details about a chained invocation that timed out.
    chained_invoke_timed_out_details: ?ChainedInvokeTimedOutDetails,

    /// Details about a context that failed.
    context_failed_details: ?ContextFailedDetails,

    /// Details about a context that started.
    context_started_details: ?ContextStartedDetails,

    /// Details about a context that succeeded.
    context_succeeded_details: ?ContextSucceededDetails,

    /// The unique identifier for this event. Event IDs increment sequentially.
    event_id: i32 = 1,

    /// The date and time when this event occurred, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    event_timestamp: ?i64,

    /// The type of event that occurred.
    event_type: ?EventType,

    /// Details about an execution that failed.
    execution_failed_details: ?ExecutionFailedDetails,

    /// Details about an execution that started.
    execution_started_details: ?ExecutionStartedDetails,

    /// Details about an execution that was stopped.
    execution_stopped_details: ?ExecutionStoppedDetails,

    /// Details about an execution that succeeded.
    execution_succeeded_details: ?ExecutionSucceededDetails,

    /// Details about an execution that timed out.
    execution_timed_out_details: ?ExecutionTimedOutDetails,

    /// The unique identifier for this operation.
    id: ?[]const u8,

    /// Details about a function invocation that completed.
    invocation_completed_details: ?InvocationCompletedDetails,

    /// The customer-provided name for this operation.
    name: ?[]const u8,

    /// The unique identifier of the parent operation, if this operation is running
    /// within a child context.
    parent_id: ?[]const u8,

    /// Details about a step that failed.
    step_failed_details: ?StepFailedDetails,

    /// Details about a step that started.
    step_started_details: ?StepStartedDetails,

    /// Details about a step that succeeded.
    step_succeeded_details: ?StepSucceededDetails,

    /// The subtype of the event, providing additional categorization.
    sub_type: ?[]const u8,

    /// Details about a wait operation that was cancelled.
    wait_cancelled_details: ?WaitCancelledDetails,

    /// Details about a wait operation that started.
    wait_started_details: ?WaitStartedDetails,

    /// Details about a wait operation that succeeded.
    wait_succeeded_details: ?WaitSucceededDetails,

    pub const json_field_names = .{
        .callback_failed_details = "CallbackFailedDetails",
        .callback_started_details = "CallbackStartedDetails",
        .callback_succeeded_details = "CallbackSucceededDetails",
        .callback_timed_out_details = "CallbackTimedOutDetails",
        .chained_invoke_failed_details = "ChainedInvokeFailedDetails",
        .chained_invoke_started_details = "ChainedInvokeStartedDetails",
        .chained_invoke_stopped_details = "ChainedInvokeStoppedDetails",
        .chained_invoke_succeeded_details = "ChainedInvokeSucceededDetails",
        .chained_invoke_timed_out_details = "ChainedInvokeTimedOutDetails",
        .context_failed_details = "ContextFailedDetails",
        .context_started_details = "ContextStartedDetails",
        .context_succeeded_details = "ContextSucceededDetails",
        .event_id = "EventId",
        .event_timestamp = "EventTimestamp",
        .event_type = "EventType",
        .execution_failed_details = "ExecutionFailedDetails",
        .execution_started_details = "ExecutionStartedDetails",
        .execution_stopped_details = "ExecutionStoppedDetails",
        .execution_succeeded_details = "ExecutionSucceededDetails",
        .execution_timed_out_details = "ExecutionTimedOutDetails",
        .id = "Id",
        .invocation_completed_details = "InvocationCompletedDetails",
        .name = "Name",
        .parent_id = "ParentId",
        .step_failed_details = "StepFailedDetails",
        .step_started_details = "StepStartedDetails",
        .step_succeeded_details = "StepSucceededDetails",
        .sub_type = "SubType",
        .wait_cancelled_details = "WaitCancelledDetails",
        .wait_started_details = "WaitStartedDetails",
        .wait_succeeded_details = "WaitSucceededDetails",
    };
};
