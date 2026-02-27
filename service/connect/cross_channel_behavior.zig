const BehaviorType = @import("behavior_type.zig").BehaviorType;

/// Defines the cross-channel routing behavior that allows an agent working on a
/// contact in one channel to be
/// offered a contact from a different channel.
pub const CrossChannelBehavior = struct {
    /// Specifies the other channels that can be routed to an agent handling their
    /// current channel.
    behavior_type: BehaviorType,

    pub const json_field_names = .{
        .behavior_type = "BehaviorType",
    };
};
