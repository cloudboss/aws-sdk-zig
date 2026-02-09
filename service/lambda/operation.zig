const CallbackDetails = @import("callback_details.zig").CallbackDetails;
const ChainedInvokeDetails = @import("chained_invoke_details.zig").ChainedInvokeDetails;
const ContextDetails = @import("context_details.zig").ContextDetails;
const ExecutionDetails = @import("execution_details.zig").ExecutionDetails;
const OperationStatus = @import("operation_status.zig").OperationStatus;
const StepDetails = @import("step_details.zig").StepDetails;
const OperationType = @import("operation_type.zig").OperationType;
const WaitDetails = @import("wait_details.zig").WaitDetails;

/// Information about an operation within a durable execution.
pub const Operation = struct {
    callback_details: ?CallbackDetails,

    chained_invoke_details: ?ChainedInvokeDetails,

    /// Details about the context, if this operation represents a context.
    context_details: ?ContextDetails,

    /// The date and time when the operation ended, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    end_timestamp: ?i64,

    /// Details about the execution, if this operation represents an execution.
    execution_details: ?ExecutionDetails,

    /// The unique identifier for this operation.
    id: []const u8,

    /// The customer-provided name for this operation.
    name: ?[]const u8,

    /// The unique identifier of the parent operation, if this operation is running
    /// within a child context.
    parent_id: ?[]const u8,

    /// The date and time when the operation started, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    start_timestamp: i64,

    /// The current status of the operation.
    status: OperationStatus,

    /// Details about the step, if this operation represents a step.
    step_details: ?StepDetails,

    /// The subtype of the operation, providing additional categorization.
    sub_type: ?[]const u8,

    /// The type of operation.
    @"type": OperationType,

    /// Details about the wait operation, if this operation represents a wait.
    wait_details: ?WaitDetails,
};
