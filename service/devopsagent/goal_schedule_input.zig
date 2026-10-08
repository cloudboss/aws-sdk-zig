const SchedulerState = @import("scheduler_state.zig").SchedulerState;

/// Schedule configuration for updating goal evaluations
pub const GoalScheduleInput = struct {
    /// Whether the schedule is enabled or disabled
    state: SchedulerState,

    pub const json_field_names = .{
        .state = "state",
    };
};
