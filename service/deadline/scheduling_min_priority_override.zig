const SchedulingMinPriorityOverrideAlwaysScheduleLast = @import("scheduling_min_priority_override_always_schedule_last.zig").SchedulingMinPriorityOverrideAlwaysScheduleLast;

/// Defines the override behavior for jobs at the minimum priority (0) in
/// weighted balanced scheduling.
pub const SchedulingMinPriorityOverride = union(enum) {
    /// Jobs at the minimum priority (0) are always scheduled after all other jobs,
    /// regardless of the weighted scheduling formula. If multiple jobs have
    /// priority 0, ties are broken using the standard weighted formula.
    always_schedule_last: ?SchedulingMinPriorityOverrideAlwaysScheduleLast,

    pub const json_field_names = .{
        .always_schedule_last = "alwaysScheduleLast",
    };
};
