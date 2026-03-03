const InstanceGroupState = @import("instance_group_state.zig").InstanceGroupState;
const InstanceGroupStateChangeReason = @import("instance_group_state_change_reason.zig").InstanceGroupStateChangeReason;
const InstanceGroupTimeline = @import("instance_group_timeline.zig").InstanceGroupTimeline;

/// The details of the instance group status.
pub const InstanceGroupStatus = struct {
    /// The current state of the instance group.
    state: ?InstanceGroupState = null,

    /// The status change reason details for the instance group.
    state_change_reason: ?InstanceGroupStateChangeReason = null,

    /// The timeline of the instance group status over time.
    timeline: ?InstanceGroupTimeline = null,

    pub const json_field_names = .{
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .timeline = "Timeline",
    };
};
