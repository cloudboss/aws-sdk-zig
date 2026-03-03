const ScheduleGroupState = @import("schedule_group_state.zig").ScheduleGroupState;

/// The details of a schedule group.
pub const ScheduleGroupSummary = struct {
    /// The Amazon Resource Name (ARN) of the schedule group.
    arn: ?[]const u8 = null,

    /// The time at which the schedule group was created.
    creation_date: ?i64 = null,

    /// The time at which the schedule group was last modified.
    last_modification_date: ?i64 = null,

    /// The name of the schedule group.
    name: ?[]const u8 = null,

    /// Specifies the state of the schedule group.
    state: ?ScheduleGroupState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .last_modification_date = "LastModificationDate",
        .name = "Name",
        .state = "State",
    };
};
