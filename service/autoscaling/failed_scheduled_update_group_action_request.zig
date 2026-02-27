/// Describes a scheduled action that could not be created, updated, or deleted.
pub const FailedScheduledUpdateGroupActionRequest = struct {
    /// The error code.
    error_code: ?[]const u8,

    /// The error message accompanying the error code.
    error_message: ?[]const u8,

    /// The name of the scheduled action.
    scheduled_action_name: []const u8,
};
