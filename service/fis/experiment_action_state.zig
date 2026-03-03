const ExperimentActionStatus = @import("experiment_action_status.zig").ExperimentActionStatus;

/// Describes the state of an action.
pub const ExperimentActionState = struct {
    /// The reason for the state.
    reason: ?[]const u8 = null,

    /// The state of the action.
    status: ?ExperimentActionStatus = null,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
