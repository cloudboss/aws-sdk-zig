const PauseState = @import("pause_state.zig").PauseState;

/// Specifies the automated snapshot pause options for the domain. These options
/// allow you to temporarily pause automated snapshots for a specified time
/// period.
pub const AutomatedSnapshotPauseOptions = struct {
    /// Whether automated snapshot pause is enabled for the domain.
    enabled: bool,

    /// The timestamp at which the automated snapshot pause ends.
    end_time: ?i64 = null,

    /// The timestamp at which the automated snapshot pause begins.
    start_time: ?i64 = null,

    /// The current state of the automated snapshot pause. Valid values are
    /// `Active`, `Completed`, `Scheduled`, and `Disabled`.
    state: ?PauseState = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .end_time = "EndTime",
        .start_time = "StartTime",
        .state = "State",
    };
};
