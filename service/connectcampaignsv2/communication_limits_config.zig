const CommunicationLimits = @import("communication_limits.zig").CommunicationLimits;
const InstanceLimitsHandling = @import("instance_limits_handling.zig").InstanceLimitsHandling;

/// Communication limits config
pub const CommunicationLimitsConfig = struct {
    all_channel_subtypes: ?CommunicationLimits,

    instance_limits_handling: ?InstanceLimitsHandling,

    pub const json_field_names = .{
        .all_channel_subtypes = "allChannelSubtypes",
        .instance_limits_handling = "instanceLimitsHandling",
    };
};
