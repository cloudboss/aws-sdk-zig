const ActionType = @import("action_type.zig").ActionType;
const ActionStatus = @import("action_status.zig").ActionStatus;

/// The record of an upcoming or in-progress managed action.
pub const ManagedAction = struct {
    /// A description of the managed action.
    action_description: ?[]const u8 = null,

    /// A unique identifier for the managed action.
    action_id: ?[]const u8 = null,

    /// The type of managed action.
    action_type: ?ActionType = null,

    /// The status of the managed action. If the action is `Scheduled`, you can
    /// apply it immediately with ApplyEnvironmentManagedAction.
    status: ?ActionStatus = null,

    /// The start time of the maintenance window in which the managed action will
    /// execute.
    window_start_time: ?i64 = null,
};
