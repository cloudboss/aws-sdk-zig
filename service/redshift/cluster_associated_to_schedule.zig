const ScheduleState = @import("schedule_state.zig").ScheduleState;

pub const ClusterAssociatedToSchedule = struct {
    cluster_identifier: ?[]const u8,

    schedule_association_state: ?ScheduleState,
};
