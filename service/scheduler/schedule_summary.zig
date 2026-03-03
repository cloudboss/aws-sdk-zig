const ScheduleState = @import("schedule_state.zig").ScheduleState;
const TargetSummary = @import("target_summary.zig").TargetSummary;

/// The details of a schedule.
pub const ScheduleSummary = struct {
    /// The Amazon Resource Name (ARN) of the schedule.
    arn: ?[]const u8 = null,

    /// The time at which the schedule was created.
    creation_date: ?i64 = null,

    /// The name of the schedule group associated with this schedule.
    group_name: ?[]const u8 = null,

    /// The time at which the schedule was last modified.
    last_modification_date: ?i64 = null,

    /// The name of the schedule.
    name: ?[]const u8 = null,

    /// Specifies whether the schedule is enabled or disabled.
    state: ?ScheduleState = null,

    /// The schedule's target details.
    target: ?TargetSummary = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .group_name = "GroupName",
        .last_modification_date = "LastModificationDate",
        .name = "Name",
        .state = "State",
        .target = "Target",
    };
};
