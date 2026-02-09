const OperationAction = @import("operation_action.zig").OperationAction;
const CallbackOptions = @import("callback_options.zig").CallbackOptions;
const ChainedInvokeOptions = @import("chained_invoke_options.zig").ChainedInvokeOptions;
const ContextOptions = @import("context_options.zig").ContextOptions;
const ErrorObject = @import("error_object.zig").ErrorObject;
const StepOptions = @import("step_options.zig").StepOptions;
const OperationType = @import("operation_type.zig").OperationType;
const WaitOptions = @import("wait_options.zig").WaitOptions;

/// An update to be applied to an operation during checkpointing.
pub const OperationUpdate = struct {
    /// The action to take on the operation.
    action: OperationAction,

    callback_options: ?CallbackOptions,

    chained_invoke_options: ?ChainedInvokeOptions,

    /// Options for context operations.
    context_options: ?ContextOptions,

    /// The error information for failed operations.
    @"error": ?ErrorObject,

    /// The unique identifier for this operation.
    id: []const u8,

    /// The customer-provided name for this operation.
    name: ?[]const u8,

    /// The unique identifier of the parent operation, if this operation is running
    /// within a child context.
    parent_id: ?[]const u8,

    /// The payload for successful operations.
    payload: ?[]const u8,

    /// Options for step operations.
    step_options: ?StepOptions,

    /// The subtype of the operation, providing additional categorization.
    sub_type: ?[]const u8,

    /// The type of operation to update.
    @"type": OperationType,

    /// Options for wait operations.
    wait_options: ?WaitOptions,
};
