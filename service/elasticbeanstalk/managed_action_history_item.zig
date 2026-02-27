const ActionType = @import("action_type.zig").ActionType;
const FailureType = @import("failure_type.zig").FailureType;
const ActionHistoryStatus = @import("action_history_status.zig").ActionHistoryStatus;

/// The record of a completed or failed managed action.
pub const ManagedActionHistoryItem = struct {
    /// A description of the managed action.
    action_description: ?[]const u8,

    /// A unique identifier for the managed action.
    action_id: ?[]const u8,

    /// The type of the managed action.
    action_type: ?ActionType,

    /// The date and time that the action started executing.
    executed_time: ?i64,

    /// If the action failed, a description of the failure.
    failure_description: ?[]const u8,

    /// If the action failed, the type of failure.
    failure_type: ?FailureType,

    /// The date and time that the action finished executing.
    finished_time: ?i64,

    /// The status of the action.
    status: ?ActionHistoryStatus,
};
