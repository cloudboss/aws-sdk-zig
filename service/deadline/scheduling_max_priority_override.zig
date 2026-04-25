const SchedulingMaxPriorityOverrideAlwaysScheduleFirst = @import("scheduling_max_priority_override_always_schedule_first.zig").SchedulingMaxPriorityOverrideAlwaysScheduleFirst;

/// Defines the override behavior for jobs at the maximum priority (100) in
/// weighted balanced scheduling.
pub const SchedulingMaxPriorityOverride = union(enum) {
    /// Jobs at the maximum priority (100) are always scheduled before other jobs,
    /// regardless of the weighted scheduling formula. If multiple jobs have
    /// priority 100, ties are broken using the standard weighted formula.
    always_schedule_first: ?SchedulingMaxPriorityOverrideAlwaysScheduleFirst,

    pub const json_field_names = .{
        .always_schedule_first = "alwaysScheduleFirst",
    };
};
