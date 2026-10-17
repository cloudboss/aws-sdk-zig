const ScheduleCondition = @import("schedule_condition.zig").ScheduleCondition;

/// Defines how a Trigger fires.
pub const TriggerCondition = union(enum) {
    /// Schedule-based firing condition. On CreateTrigger supply exactly one of the
    /// schedule condition's expression or spec.
    schedule: ?ScheduleCondition,

    pub const json_field_names = .{
        .schedule = "schedule",
    };
};
