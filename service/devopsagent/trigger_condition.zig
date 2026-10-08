const ScheduleCondition = @import("schedule_condition.zig").ScheduleCondition;

/// Defines the firing condition for a Trigger
pub const TriggerCondition = union(enum) {
    /// Time-based firing condition
    schedule: ?ScheduleCondition,

    pub const json_field_names = .{
        .schedule = "schedule",
    };
};
