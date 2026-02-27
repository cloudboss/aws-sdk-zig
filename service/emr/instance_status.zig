const InstanceState = @import("instance_state.zig").InstanceState;
const InstanceStateChangeReason = @import("instance_state_change_reason.zig").InstanceStateChangeReason;
const InstanceTimeline = @import("instance_timeline.zig").InstanceTimeline;

/// The instance status details.
pub const InstanceStatus = struct {
    /// The current state of the instance.
    state: ?InstanceState,

    /// The details of the status change reason for the instance.
    state_change_reason: ?InstanceStateChangeReason,

    /// The timeline of the instance status over time.
    timeline: ?InstanceTimeline,

    pub const json_field_names = .{
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .timeline = "Timeline",
    };
};
