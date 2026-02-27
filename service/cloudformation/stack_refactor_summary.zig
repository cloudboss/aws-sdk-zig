const StackRefactorExecutionStatus = @import("stack_refactor_execution_status.zig").StackRefactorExecutionStatus;
const StackRefactorStatus = @import("stack_refactor_status.zig").StackRefactorStatus;

/// The summary of a stack refactor operation.
pub const StackRefactorSummary = struct {
    /// A description to help you identify the refactor.
    description: ?[]const u8,

    /// The operation status that's provided after calling the ExecuteStackRefactor
    /// action.
    execution_status: ?StackRefactorExecutionStatus,

    /// A detailed explanation for the stack refactor `ExecutionStatus`.
    execution_status_reason: ?[]const u8,

    /// The ID associated with the stack refactor created from the
    /// CreateStackRefactor action.
    stack_refactor_id: ?[]const u8,

    /// The stack refactor operation status that's provided after calling the
    /// CreateStackRefactor action.
    status: ?StackRefactorStatus,

    /// A detailed explanation for the stack refactor `Status`.
    status_reason: ?[]const u8,
};
