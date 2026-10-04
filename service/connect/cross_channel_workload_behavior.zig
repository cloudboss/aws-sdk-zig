const ChannelWorkloadBehaviorType = @import("channel_workload_behavior_type.zig").ChannelWorkloadBehaviorType;

/// Defines the cross-channel and workload type routing behavior that allows an
/// agent working on a contact to be
/// offered a contact from a different channel or workload type.
pub const CrossChannelWorkloadBehavior = struct {
    /// Specifies the routing behavior for an agent handling their current channel
    /// and workload type.
    channel_workload_behavior_type: ?ChannelWorkloadBehaviorType = null,

    pub const json_field_names = .{
        .channel_workload_behavior_type = "ChannelWorkloadBehaviorType",
    };
};
