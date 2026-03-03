const ClockStatus = @import("clock_status.zig").ClockStatus;
const ClockTargetStatus = @import("clock_target_status.zig").ClockTargetStatus;

/// Status information about the simulation clock.
pub const SimulationClock = struct {
    /// The current status of the simulation clock.
    status: ?ClockStatus = null,

    /// The desired status of the simulation clock.
    target_status: ?ClockTargetStatus = null,

    pub const json_field_names = .{
        .status = "Status",
        .target_status = "TargetStatus",
    };
};
