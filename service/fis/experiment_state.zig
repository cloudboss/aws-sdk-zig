const ExperimentError = @import("experiment_error.zig").ExperimentError;
const ExperimentStatus = @import("experiment_status.zig").ExperimentStatus;

/// Describes the state of an experiment.
pub const ExperimentState = struct {
    /// The error information of the experiment when the action has `failed`.
    @"error": ?ExperimentError,

    /// The reason for the state.
    reason: ?[]const u8,

    /// The state of the experiment.
    status: ?ExperimentStatus,

    pub const json_field_names = .{
        .@"error" = "error",
        .reason = "reason",
        .status = "status",
    };
};
