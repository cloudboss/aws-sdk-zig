const SchedulerState = @import("scheduler_state.zig").SchedulerState;

/// Schedule configuration for goal evaluations
pub const GoalSchedule = struct {
    /// Schedule expression (e.g., 'rate(7 days)')
    expression: ?[]const u8 = null,

    /// Whether the schedule is enabled or disabled
    state: SchedulerState,

    pub const json_field_names = .{
        .expression = "expression",
        .state = "state",
    };
};
